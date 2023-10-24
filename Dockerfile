# Use an official Node.js runtime as the base image
FROM node:hydrogen

# Install required packages
RUN apt-get update && \
    apt-get install -y git build-essential && \
    rm -rf /var/lib/apt/lists/*

# Clone the repository and build Tippecanoe
RUN git clone https://github.com/mapbox/tippecanoe.git && \
    cd tippecanoe && \
    make -j && \
    make install

# Set the working directory in the container
WORKDIR /app

COPY example.geojson ./example.geojson

# Install tippecanoe
RUN npm install -g tippecanoe

# Create a shell script to run Tippecanoe
RUN echo "#!/bin/sh\n\
tippecanoe -zg --full-detail=10 --low-detail=11 --simplification=10 --layer=buildings --output=/app/output/sample.mbtiles --description='Building footprints in the municipality of Hobbiton.' --force --extend-zooms-if-still-dropping -pk -pf ./example.geojson" > run_tippecanoe.sh && \
    chmod +x run_tippecanoe.sh

# Define the entry point for the container (this is your script)
ENTRYPOINT ["/app/run_tippecanoe.sh"]
