import pandas as pd
import geopandas as gpd
from janitor import clean_names
import fiona
from functools import partial
import os
from utils import cpu_use, list_files
import logging
from logging.config import fileConfig

loginipath='logs/logging_config.ini'
log_file='extract_load.log'
log_path=os.path.join('logs', log_file)
logger = logging.getLogger('sLogger')


def is_valid_pluto(path: str) -> bool:
    """
    only include 'clipped' shapefiles, and mappluto files
    """
    lower_path=path.lower()

    is_shapefile=lower_path.rsplit('.', 1)[1] == 'shp'

    criteria=(is_shapefile) and \
                ('unclipped' not in lower_path) and \
                ('mappluto' in lower_path)

    return criteria


def filter_valid_pluto(dir:str) -> list:

    """
    takes a directory, returns a list of valid pluto files from that directory
    """
    paths=list_files(dir)
    filtered_paths=filter(is_valid_pluto, paths)
    
    return list(filtered_paths)


def make_chunks(path:str, size=5 * 10 ** 4) -> list:

    """
    makes appropriately sized slices to process a dataframe (50,000 rows)
    returns: a list of slices
    """
    df_rows = len(fiona.open((path)))
    starts = list(range(0, df_rows, size))
    ends = list(range(size, df_rows + size, size))
    slices = [slice(start, end, 1) for start, end in zip(starts, ends)]
    return slices


def transform_gdf(gdf: gpd.GeoDataFrame) -> gpd.GeoDataFrame:
    """
    takes a raw geodataframe:
    1. sets coordinate system to ESPG: WGS 84 (?)
    2. fills blank geometry cells with empty polygons
    3. uses janitor package to make all column names snake case
    """
    transformed = gdf.to_crs(epsg = 4326) 
    transformed['geometry'] = transformed["geometry"].fillna()
    transformed_df = transformed.clean_names()

    return transformed_df


def agg_from_path(file_path, year="1984"):

    """
    1. from a path to a valid gdf, split it into chunks
    2. for each slice, transform and then aggregate all slices
    """
    terminal_name=file_path.rsplit('/',1)[1]
    file_chunks = make_chunks(path=file_path)

    gdf_list=[] # initialize list of transformed gdf's

    for chunk in file_chunks:

        logger.info(f'reading from {chunk.start} to {chunk.stop} rows from file: {terminal_name} for year {year}')
        d=gpd.read_file(file_path, rows=chunk)

        logger.info('transforming data')
        d=transform_gdf(d)
        gdf_list.append(d) # append to list

    logger.info(f'{cpu_use()} aggregating chunked dataframes')
    df=pd.concat(gdf_list) # combines list of geo_dataframes
    return df


