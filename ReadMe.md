# OSM water layer scripts
The scripts to generate OSM Water Layer

http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html

Dai Yamazaki, 2nd April 2021

## Requirement
Install OSMOSIS, GDAL, Fortran.
The scripts are written for MacOS. Modifications might be needed for other environment.

## Procedures
### [1] Prepare "sea mask" from OSM water-polygons
- Work in OSM_sea/ directory.
- Detailed procedure written in ReadMe.md in OSM_sea/

### [2] Create OSM water layer
- Make a project directory (sample calc_2021Feb/ to process the OSM planet data at that time)
- Go to extract_water/ directory.
- Make osm/ directory, and download the latest planet.pbf from servers.
    ### https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf
- Then, follow the instruction in ReadMe.md  in calc_2021Feb/ directory.

### [3] (optional) Create High-resolution OSM water layer
- Make a high-res project directory (sample hires_2021Feb/ )
- Then, follow the instruction in ReadMe.md  in hires_2021Feb/ directory.

### [4] Prepare distribution data
- Goto distribute/ directory.
- Edit copy.sh, and execute it.
- Edit copy_hires.sh, and execute it.

=== OSM PBF file ===

<Original> **extract_water/osm/water/planet-all.osm.pbf**

<Copied as> **OSM_WaterLayer.pbf**

This is "derived data" and thus should be distributed under ODbL 1.0 license.

=== Rasterized data ===

<Original>

Binary: **merge_water/5deg/**
GeoTiff: **merge_water/tif/**

<Copied as>

Binary: **5deg/**
GeoTiff: **OSM_WaterLayer_tif**

These data are "creative works"(not derived data) according to the OpenStreetMap guideline. So we can put any license. Now this is distributed under CC-BY 4.0.

#### Water classification in rasterlized data
Below values are used in rasterlized data.
0: land
1: ocean
2: large water body (poligon)
3: majopr river
4: canal
5: small stream

