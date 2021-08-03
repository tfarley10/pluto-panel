#!/bin/sh

# loads pluto links to foo.csv

links=$(wget -qO- https://www1.nyc.gov/site/planning/data-maps/open-data/bytes-archive.page?sorts[year]=0/ |
grep -Eoi '<a [^>]+>' | 
grep -Eo 'href="[^\"]+"' | 
grep -Eo '[^href=\"].+mappluto.+\.zip' |
grep -Ev 'fgdb');

echo "link, date" >> foo.csv;
for i in $links; 
do ts=$(gdate -u +'%Y-%m-%dT%H:%M:%S.%3NZ'); 
echo "${i}, $ts" >> foo.csv;
done