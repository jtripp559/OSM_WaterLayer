#!/bin/sh
#
# Purpose:
#   This script is useful for processing the water data for a specific region.
#
# Description:
#   This script calls the script  t01-water.sh  for each 5x5 degree tile in the region defined by the input parameters  LON_ORI ,  LON_END ,  LAT_ORI , and  LAT_END .
#
# Arguments:
#   LON_ORI: The westernmost longitude of the region.
#   LON_END: The easternmost longitude of the region.
#   LAT_ORI: The southernmost latitude of the region.
#   LAT_END: The northernmost latitude of the region.
#   YEAR_MON: (Optional) The year and month string of the data. The default is the current year and month.
#
# Usage example:
#   $ ./s01-water.sh -180 -175 -90 -85 2021Feb
#
echo "Begin s01-water.sh script."
echo "Process water data for a specific region."

USER=`whoami`

LON_ORI=$1
LON_END=$2
LAT_ORI=$3
LAT_END=$4

if [ "$#" -lt 5 ]; then
    echo "Defaulting to current year and month."
    YEAR_MON=$(date +"%Y%b")
else
    YEAR_MON=$5
fi
echo "YearMonth: $YEAR_MON"

# Check if t01-water.sh script exists
if [ ! -f ./t01-water.sh ]; then
    echo "Error: t01-water.sh script not found in the directory: $(pwd)"
    exit 1
fi

# Check if set_name script exists
if [ ! -f ./src/set_name ]; then
    echo "Error: set_name script not found in the directory: $(pwd)/src"
    exit 1
fi

mkdir -p water

####################################

SOUTH=${LAT_ORI}
NORTH=`expr $SOUTH + 5`
while [ $SOUTH -lt ${LAT_END} ];
do
  WEST=${LON_ORI}
  EAST=`expr $WEST + 5`
  while [ $WEST -lt ${LON_END} ];
  do
    CNAME=`./src/set_name $WEST $SOUTH`

    if [ -f ./${YEAR_MON}/${CNAME}.bil ]; then

      ./t01-water.sh $WEST $SOUTH  &

      NUM=`ps aux | grep $USER | grep t01-water.sh | wc -l | awk '{print $1}'`
      while [ $NUM -gt 16 ];
      do
        sleep 1
        NUM=`ps aux | grep $USER | grep t01-water.sh | wc -l | awk '{print $1}'`
      done
    fi
  
  WEST=`expr $WEST + 5`
  EAST=`expr $WEST + 5`
  done
SOUTH=`expr $SOUTH + 5`
NORTH=`expr $SOUTH + 5`
done
wait

echo "End s01-water.sh script."