#!/bin/sh

# Run Tippecanoe command
tippecanoe -zg --full-detail=10 --low-detail=11 --simplification=10 --layer=buildings --output=/app/output/sample.mbtiles --description='Building footprints in the municipality of Hobbiton.' --force --extend-zooms-if-still-dropping -pk -pf ./example.geojson

# Copy the generated .mbtiles file to the project folder
cp /tmp/sample.mbtiles /app/output/sample.mbtiles
