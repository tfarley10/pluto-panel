import httplib2
from bs4 import BeautifulSoup, SoupStrainer
import re
import pandas as pd
import os


def get(url: str) -> bytes:
    con = httplib2.Http()
    try:
        return con.request(url)[1]
    except Exception as err:
        print(f'HTTP error, {err}')


def parse_links(response) -> [str]:

    tags = BeautifulSoup(response, 'html.parser', parse_only=SoupStrainer('a'))
    return [link['href'] for link in tags if link.has_attr('href')]


def filter_reg(filter_list: [str], regex: str, negate=False) -> [str]:
    r = re.compile(regex)
    if not negate:
        return [i for i in filter_list if r.findall(i)]
    else:
        return [i for i in filter_list if not bool(r.findall(filter_list))]


def extract_reg(extract_list: [], regex: str) -> list:

    r = re.compile(regex)
    return [r.findall(i)[0] for i in extract_list]


def main():


    archive_link = 'https://www1.nyc.gov/site/planning/data-maps/open-data/bytes-archive.page?sorts[year]=0'

    resp = get(archive_link)
    links = parse_links(resp)

    # filter links
    reg_mappluto = '^(?=.*mappluto)'  # contains mappluto
    reg_not_fgdb = '(?!.*fgdb)'  # is not fgdb
    reg_zipfile = '.*(\.zip).*$'  # is a zipfile
    reg_pluto = reg_mappluto + reg_not_fgdb + reg_zipfile
    pluto_links = filter_reg(links, reg_pluto)

    # extracting year from path
    reg_year = 'pluto_([\d]{2})'
    year = extract_reg(pluto_links, reg_year)

    # extracting version from path
    reg_version = 'pluto_[\d]{2}v*([\d]+)?_*([\d])?'
    version = extract_reg(pluto_links, reg_version)

    # parse versions
    version = ['.'.join(i) for i in version]
    versions_numeric = [*map(lambda x: 1.0 if x == '.' else float(x), version)]

    # to df, get latest version
    df = pd.DataFrame({'file': pluto_links, 'year': year, 'version': versions_numeric})
    df = df.iloc[df.groupby(['year'])['version'].agg(pd.Series.idxmax)]
    path_prefix = 'https://www1.nyc.gov'
    df['path'] = path_prefix + df['file']
    df.reset_index(drop=True, inplace=True)
    df['year'] = df['year'].astype(int) + 2000
    parent_path = os.path.abspath(os.path.join(os.getcwd(), '..'))
    df.to_csv('zip_links.csv', index=False)


if __name__ == "__main__":
    main()
