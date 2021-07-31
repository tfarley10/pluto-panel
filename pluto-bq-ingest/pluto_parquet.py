import pandas as pd
import geopandas as gpd
from janitor import clean_names
import fiona
from functools import partial
import os
from utils import cpu_use

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
    return ('unclipped' not in lower_path) and ('mappluto' in lower_path)


def list_shp(dir:str) -> list:

    """

    """
    paths=[]
    get_ext = lambda x: x.rsplit('.', 1)[1].lower()
    for root, _, files in os.walk(dir):
        for file in files:
            if get_ext(file) == 'shp' and is_valid_pluto(file):
                paths.append(os.path.join(root, file))
    return (paths)


def make_chunks(path:str, size=5 * 10 ** 4):

    """
    :param gf_rows: number of rows in spatial data file
    :param size: # of rows to read in each slice
    :return: list of slices that will `chunk` the file read
    """
    df_rows = len(fiona.open((path)))
    starts = list(range(0, df_rows, size))
    ends = list(range(size, df_rows + size, size))
    slices = [slice(start, end, 1) for start, end in zip(starts, ends)]
    return slices


def transform_gdf(gdf: gpd.GeoDataFrame):
    """
    takes a raw geodataframe:
    1. sets coordinate system to ESPG: WGS 84 (?)
    2. fills blank geometry cells with empty polygons
    3. uses janitor package to make all column names snake case
    """
    transformed = gdf.to_crs(epsg = 4326) 
    transformed['geometry'] = transformed["geometry"].fillna()
    transformed = transformed.clean_names()

    return transformed


def agg_from_path(file_path, year="1984"):

    """
    1. from a path to a valid gdf, split it into chunks
    2. for each slice, transform and then aggregate all slices
    """
    terminal_name=file_path.rsplit('/',1)[1]
    file_chunks = make_chunks(path=file_path)

    g_list=[]

    for c in file_chunks:

        logger.info(f'reading from {c.start} to {c.end} rows from file: {terminal_name} \
            for year {year}')
        d=gpd.read_file(file_path, rows=c)

        logger.info('transforming data')
        d=transform_gdf(d)
        g_list.append(d) # append to list

    logger.info(f'{cpu_use()} aggregating chunked dataframes')
    df=pd.concat(g_list) # combines list of geo_dataframes
    return df


