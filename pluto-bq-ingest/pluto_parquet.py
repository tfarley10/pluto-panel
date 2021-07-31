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


def clipped(path: str):
    lower_path=path.lower()
    return ('unclipped' not in lower_path) and ('mappluto' in lower_path)


def list_shp(dir:str):

    """

    :param dir: directory to walk
    :param filetypes: list of filetypes that should be returned (eg. [pdf,htm])
    :return: list of paths to files specified by filetypes
    """
    paths=[]
    get_ext = lambda x: x.rsplit('.', 1)[1].lower()
    for root, dirs, files in os.walk(dir):
        for file in files:
            if get_ext(file) == 'shp' and clipped(file):
                paths.append(os.path.join(root, file))
    return (paths)



def filter_clipped(path_list: list):
    return list(filter(clipped, path_list))


def nrows(path):
    return len(fiona.open(path))


def make_chunks(path, size=5 * 10 ** 4):

    """
    :param gf_rows: number of rows in spatial data file
    :param size: # of rows to read in each slice
    :return: list of slices that will `chunk` the file read
    """
    df_rows = nrows(path)
    starts = list(range(0, df_rows, size))
    ends = list(range(size, df_rows + size, size))
    slices = [slice(start, end, 1) for start, end in zip(starts, ends)]
    return slices


def file_name(path):
    return path.rsplit('/',1)[1]


def read_chunk(path, chunk:slice, year):

    """

    :param path: path to spatial file
    :return: geodataframe
    """
    name = file_name(path)
    msg=f'reading from {chunk.start} to {chunk.stop} rows from {name} for year {year}'
    logger.info(msg)
    return gpd.read_file(path, rows=chunk)


def transform_gdf(gdf: gpd.GeoDataFrame):

    msg="transforming dataframe"
    logger.info(msg)
    transformed = gdf.copy(deep=False)
    transformed = transformed.to_crs(epsg = 4326)
    transformed['geometry'] = transformed["geometry"].fillna()
    transformed = transformed.clean_names()

    return transformed


def read_transform(path: str, chunk: slice, year):
    chunk_gdf = read_chunk(path, chunk, year)
    return transform_gdf(chunk_gdf)


def agg_from_path(pth, year="1984"):
    chunks = make_chunks(path=pth)
    g_list=[]
    for c in chunks:
        g_list.append(read_transform(pth, c, year=year))
    logger.info(f'{cpu_use()} aggregating dataframes')
    
    df=pd.concat(g_list)

    return df







