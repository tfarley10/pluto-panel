#!/bin/sh
wget -qO- https://www1.nyc.gov/site/planning/data-maps/open-data/bytes-archive.page?sorts[year]=0/ |
grep -Eoi '<a [^>]+>' | 
grep -Eo 'href="[^\"]+"' | 
grep -Eo '[^href=\"].+mappluto.+\.zip' |
grep -Ev 'fgdb' 