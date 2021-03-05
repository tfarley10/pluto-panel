import geopandas as gpd
import pandas as pd
import requests
import zipfile, io
import tempfile
import re
import fnmatch
import os



def unzip_to_temp(zip_path):
    r = requests.get(zip_path)
    z = zipfile.ZipFile(io.BytesIO(r.content))
    tmp = tempfile.TemporaryDirectory()
    z.extractall(tmp.name)
    
    return(tmp)



def get_shp_path(dire):

    matches = []
    for root, dirnames, filenames in os.walk(dire.name):
        for filename in fnmatch.filter(filenames, '*.shp'):
            matches.append(os.path.join(root, filename))
    return(matches)



def negative_filter(filter_word, list_to_filter):
    
    r = (f'(?i)^((?!{filter_word}).)*$')
    reg = re.compile(r)
    
    return_list = []
    
    for s in list_to_filter:
        if reg.match(s):
            return_list.append(s)
    return(return_list)


def append_shapefiles(shapefile_list):
    
    length = len(shapefile_list)
    
    if length == 1:
        return gpd.read_file(shapefile_list[0])
    else:
        g = gpd.read_file(shapefile_list[0])
        for x in range(1, length):
            g = g.append(gpd.read_file(shapefile_list[x]))
    return(g)