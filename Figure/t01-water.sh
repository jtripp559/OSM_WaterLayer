#!/bin/sh

echo "Begin t01-water.sh script."

WEST=$1
EAST=$(( $WEST + 5 ))
SOUTH=$2
NORTH=$(( $SOUTH + 5 ))

if [ "$#" -lt 3 ]; then
    echo "Defaulting to current year."
    YEAR=$(date +"%Y%b")
else
    YEAR=$3
fi
echo "Year: $YEAR"
echo "Current directory: $(pwd)"

OSM_DIR="osm${YEAR}"
# mkdir -p osm2021
mkdir -p ${OSM_DIR}

####################################

if [ -x ./src/conv_water ]; then
  ./src/conv_water $WEST $SOUTH 
else
  echo "Error: ./src/conv_water not found."
  exit 1
fi

CNAME=`./src/set_name $WEST $SOUTH`

if [ -f wat_${CNAME}.bin ]; then
  if [ -f ./draw-water.py ]; then
    python ./draw-water.py ${WEST} ${SOUTH} ${CNAME} ${OSM_DIR}
    rm -f wat_${CNAME}.bin
  else
    echo "Error: ./draw-water.py not found."
  fi
fi

echo "End t01-water.sh script."