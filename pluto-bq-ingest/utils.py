import os
import psutil


def list_files(dir:str) -> list:
    """
    returns all files given a root directory
    """

    paths = []
    for root, _, files in os.walk(dir):
        for file in files:
                paths.append(os.path.join(root, file))
    return paths


def cpu_use():
    """
    helper for logging
    """
    return f'cpu usage: {psutil.cpu_percent()}%'

