#!/bin/sh

echo "Begin t02-change.sh script."

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

DIFF_DIR="dif_${YEAR}-2015"
# mkdir -p dif_2021-2015
mkdir -p ${DIFF_DIR}

####################################

if [ -x ./src/conv_change ]; then
  ./src/conv_change $WEST $SOUTH 
else
  echo "Error: ./src/conv_change not found."
  exit 1
fi

CNAME=`./src/set_name $WEST $SOUTH`

if [ -f dif_${CNAME}.bin ]; then
  if [ -f ./draw-change.py ]; then
    # python ./draw-change.py $WEST $SOUTH $CNAME dif_2021-2015
    python ./draw-change.py ${WEST} ${SOUTH} ${CNAME} ${DIFF_DIR}
    rm -f dif_${CNAME}.bin
  else
    echo "Error: ./draw-change.py not found."
  fi
fi

echo "End t02-change.sh script."