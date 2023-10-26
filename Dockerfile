# Use the base image
FROM ingmapping/tippecanoe

# Create a directory for input and output data
# RUN mkdir /data_tiles

# Set the working directory
WORKDIR /data_tiles

# Copy the input.geojson from the host to the container
COPY input.geojson /data_tiles/input.geojson

# Run tippecanoe to generate the mbtiles in a tmp folder
RUN tippecanoe -o /tmp/output.mbtiles -z22 /data_tiles/input.geojson

# Copy the generated mbtiles from tmp to the output folder
RUN mv /tmp/output.mbtiles /data_tiles/output.mbtiles

# Define the output folder outside of the container
VOLUME ["/output"]

# Define the entry point script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
