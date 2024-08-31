#!/bin/sh
#
# Purpose:
#   This script is useful for processing the water data for a specific region.
#
# Description:
#   This script calls the script  s01-rasterlize.sh  for the region defined by the input parameters  LON_ORI=120 ,  LON_END=155 ,  LAT_ORI=20 , and  LAT_END=50 .
#
# Arguments:
#   YEAR_MON: (Optional) The year and month string of the data. The default is the current year and month.
#
# Usage example:
#   $ ./auto.sh 2021Feb
#
echo "Begin auto.sh script."

if [ "$#" -eq 0 ]; then
    echo "Defaulting to current year and month."
    YEAR_MON=$(date +"%Y%b")
else
    YEAR_MON=$1
fi
echo "YearMonth: $YEAR_MON"
echo "Current directory: $(pwd)"

## OSM water layer shapefile 
SHAPE_DIR="../../calc_${YEAR_MON}/add_river/shp"
if [ ! -d $SHAPE_DIR ]; then
    echo "Error: Directory path $SHAPE_DIR does not exist from current directory."
    exit 1
fi
ln -sf $SHAPE_DIR .

# Check if s01-rasterlize.sh script exists
if [ ! -f ./s01-rasterlize.sh ]; then
    echo "Error: s01-rasterlize.sh script not found in the directory: $(pwd)"
    exit 1
fi
./s01-rasterlize.sh  120 155 20 50 

echo "End auto.sh script."