import pandas as pd
import os
import pluto_parquet as pp
from zips import unzip_to_temp
from shutil import rmtree
from functools import partial

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = 'etc/secret.json'

client = storage.Client()
bucket = client.bucket('raw-pluto')

zip_links = pd.read_csv('./etc/zip_links.csv').loc[16:]

for index, row in zip_links.iterrows():



    print(f"make blob for {row.year}.csv")
    blob = bucket.blob(f"{row.year}.csv")
    dir = unzip_to_temp(row.path)
    shapes = list_all_files(dir, ['shp'])
    print("make pluto-year objects")
    py = PlutoYear(shapes)
    print("save py obj to tmp_data.csv")
    py.wkt_file.to_csv('tmp_data.csv', index = False)
    print("clean tmp dir")
    rmtree(dir)
    blob.upload_from_filename('./tmp_data.csv')
    os.remove('tmp_data.csv')
    
    
def main():
    zips=pd.read_csv("etc/zip_links.csv")
    link_2002=zips.iloc[0,0]
    
    dirr=unzip_to_temp(link_2002)
    
    paths=pp.list_shp(dirr)
    root_paths=['..' + p for p in paths]
    agg_year = partial(pp.agg_from_path, year=str(2002))


if __name__ == '__main__':
    pass


