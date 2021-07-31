import os
import pandas as pd
from fiona import open
from time import time
import geopandas as gpd
import psutil

def get_ext(path):
    return path.rsplit('.', 1)[1].lower()

def list_files(dir:str) -> list:
    """
    returns all files given a root directory
    """

    paths = []
    for root, _, files in os.walk(dir):
        for file in files:
                paths.append(os.path.join(root, file))
    return paths


def list_file_types(dir:str, filetypes:list):

    """

    :param dir: directory to walk
    :param filetypes: list of filetypes that should be returned (eg. [pdf,htm])
    :return: list of paths to files specified by filetypes
    """

    filetypes = [types.lower() for types in filetypes]
    paths = []
    get_ext = lambda x: x.rsplit('.', 1)[1].lower()
    for root, dirs, files in os.walk(dir):
        for file in files:
            if get_ext(file) in filetypes:
                paths.append(os.path.join(root, file))
    paths = [p.lower() for p in paths]
    return (paths)


def cpu_use():
    return f'cpu usage: {psutil.cpu_percent()}%'

