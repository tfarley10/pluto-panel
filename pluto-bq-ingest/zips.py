from io import BytesIO
from urllib.request import urlopen
from zipfile import ZipFile
from tempfile import mkdtemp
import utils
import os
import logging


logger = logging.getLogger('sLogger')



def temp_sub(file):

    """Makes a subdirectory in the existing temporary directory to unzip a file"""

    new_dir = file.strip('.zip')
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)
    new_dir = mkdtemp(dir = new_dir)
    return(new_dir)

def dir_dic(zip_list):

    """
    Creates tmp directories for zipfiles, creates dictionary for zipfile -> directory
    """
    zip_dir = [temp_sub(x) for x in zip_list]
    zip_dict = dict(zip(zip_list, zip_dir))
    return(zip_dict)

def unzip_child(zip_list):
    """
    only called when there are nested zipfiles
    """
    
    zip_dict = dir_dic(zip_list)

    for file, dir in zip_dict.items():
        with ZipFile(file) as zfile:
                zfile.extractall(dir)


def filter_zips(dir:str) -> list:
    """
    from a directory, return all zipfiles
    """

    paths=utils.list_files(dir)
    is_zip=lambda x: x.rsplit('.', 1)[1].lower() == 'zip'

    filtered_paths=filter(is_zip, paths)

    return list(filtered_paths)


def unzip_to_temp(zipurl) -> str:

    """

    :param zipurl: url of MapPluto Zip file
    :return: temporary directory of unzipped shapefiles
    """

    dir = mkdtemp()

    with urlopen(zipurl) as zipresp:
        msg=f"Downloading ZIPFile {zipurl}"
        logger.info(msg)
        with ZipFile(BytesIO(zipresp.read())) as zfile:
            logger.info(f'Unzipping {zipurl}')
            zfile.extractall(dir)

    # does the shapefile contain more zipfiles?
    child_zips = filter_zips(dir)
    len_child=len(child_zips)
    if len_child > 0:
        msg2=f'{zipurl} has {len_child} nested zipfiles, unzipping'
        logger.info(msg2)
        unzip_child(child_zips)

    return dir
    



