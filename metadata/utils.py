import os
import pandas as pd
import re
import fiona
from django.core.validators import URLValidator
import datetime
from functools import wraps


def get_terminal(path: str) -> str:
    terminal_regex = re.compile(r'([\w.]+)$')
    return re.findall(terminal_regex, path)[0]


def walk_dir(dirname: str) -> list:
    """
    returns list of all filepaths in dirname
    :param dirname: directory to walk
    """
    out = []

    for root, dir, file in os.walk(dirname):
        for f in file:
            out.append(os.path.join(root, f))
    return out


def make_chunks(rows, size=5 * 10 ** 4):
    """

    :param gf_rows: number of rows in spatial data file
    :param size: # of rows to read in each slice
    :return: list of slices that will `chunk` the file read
    """
    starts = list(range(0, rows, size))
    ends = list(range(size, rows + size, size))
    slices = [slice(start, end, 1) for start, end in zip(starts, ends)]
    return slices


def shapefile_length(path:str) -> int:

    with fiona.open(path) as p:
        return len(p)


def is_url(path):
    validate = URLValidator()
    try:
        validate(path)
    except Exception:
        return False
    return True


def is_shapefile(file_path) -> bool:
    
    shape_reg = re.compile(r'\.shp$')
    return bool(re.findall(shape_reg, file_path))


def is_pluto_path(file_path) -> bool:

    terminal_path = get_terminal(file_path).lower()

    is_pluto_shapefile = is_shapefile(terminal_path) and \
                 ('unclipped' not in terminal_path) and \
                 ('mappluto' in terminal_path)

    return is_pluto_shapefile




def get_terminal_path(df: pd.DataFrame, col_name: str):
    return df[col_name].str.rsplit('/', n=1, expand=True).loc[:, 1]

# def log_timing(f):
#
#     @wraps(f)
#     def wrapper(*args, **kwargs):
#         tic = dt.datetime.now()
#         result = f(*args, **kwargs)
#         toc = dt.datetime.now()
#         print(f"{f.__name__} took {toc-tic}")
#         return result
#     return wrapper

def log_kw(arg_kw):
    def decor(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            tic = datetime.datetime.now()
            result = func(*args, **kwargs)
            toc = datetime.datetime.now()
            diff = toc - tic
            obj = kwargs[arg_kw]
            f_name = func.__name__ 
            print(f"it took {f_name} {diff} with argument: {obj}")
            return result
        return wrapper
    return decor





