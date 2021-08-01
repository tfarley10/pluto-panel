import os
import psutil
import httplib2 
from bs4 import BeautifulSoup, SoupStrainer
from typing import List


def list_files(dir:str) -> List[str]:
    """
    returns all files given a root directory
    """

    paths = []
    for root, _, files in os.walk(dir):
        for file in files:
                paths.append(os.path.join(root, file))
    return paths


def get_links(url_path:str) -> List[str]:
    
    h = httplib2.Http()
    status, response = h.request(url_path)
    a_tags = BeautifulSoup(response, 'html.parser', parse_only=SoupStrainer('a'))
    links = [link['href'] for link in a_tags if link.has_attr('href')]
    
    return links


def cpu_use():
    """
    helper for logging
    """
    return f'cpu usage: {psutil.cpu_percent()}%'

