#!/bin/sh

: '

loads csv to bq
'

bq load \
    --autodetect \
    --source_format=CSV \
    metadata.links \
    ./foo.csv 