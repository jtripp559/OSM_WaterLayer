#!/bin/sh
#
# Purpose:
#   This script is useful for creating a distribution package for the data. 
#
# Description:
#   This script copies the files from the directories where the data is stored to a new directory, named v2.0_YYYYMon , where  YYYYMon  is the year and month string. 
#   This script also compresses the directories  OSM_WaterLayer_tif  and  5deg  into tar.gz files. 
#
# Arguments:
#   YEAR_MON: (Optional) The year and month string of the data. The default is the current year and month.
#
# Usage example:
#   $ ./copy.sh 2021Feb
#
echo "Begin copy.sh script."
echo "Copy files for distribution."

if [ "$#" -eq 0 ]; then
    echo "Defaulting to current year and month."
    YEAR_MON=$(date +"%Y%b")
else
    YEAR_MON=$1
fi
echo "YearMonth: $YEAR_MON"

TAG="v2.0_${YEAR_MON}"

INPPBF="../../calc${YEAR_MON}/extract_water/osm/water/planet-all.osm.pbf"
INPTIF="../../calc${YEAR_MON}/merge_water/tif"
INPBIN="../../calc${YEAR_MON}/merge_water/5deg"

mkdir -p $TAG
cd       $TAG

echo "Current directory: $(pwd)"

if [ -f "$INPPBF" ]; then
    cp    $INPPBF ./OSM_WaterLayer.pbf
else
    echo "File path $INPPBF does not exist from current directory."
fi

if [ -d "$INPTIF" ]; then
    cp -r $INPTIF ./OSM_WaterLayer_tif
else
    echo "Directory path $INPTIF does not exist from current directory."
fi

if [ -d "$INPBIN" ]; then
    cp -r $INPBIN ./5deg
else
    echo "Directory path $INPBIN does not exist from current directory."
fi

if [ -d "./OSM_WaterLayer_tif" ]; then
    tar cvfz OSM_WaterLayer_tif.tar.gz OSM_WaterLayer_tif
else
    echo "Could not compress OSM_WaterLayer_tif directory. Directory $(pwd)/OSM_WaterLayer_tif does not exist."
fi

if [ -d "./5deg" ]; then
    tar cvfz 5deg.tar.gz               5deg
else
    echo "Could not compress 5deg directory. Directory $(pwd)/5deg does not exist."
fi

echo "End copy.sh script."
