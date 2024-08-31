#!/bin/sh
#
# Description:
# The script is called with an optional argument, which is a string that represents the year and month of the data. 
# The script copies the files from the directories where the data is stored to a new directory, which is named with the tag  v2.0_YYYYMon , where  YYYYMon  is the year and month string. 
# The script also compresses the directories  1deg_10m  and  1deg_30m  into tar.gz files.
# The script is called with the following command example:
#           $ ./copy_hires.sh 2021Feb
#   Note: the argument  2021Feb  is optional. If the argument is not provided, the script uses the current year and month.
# The script copies the files from the directories  ../../hires_2021Feb/merge_water/1deg_10m  and  ../../hires_2021Feb/merge_water/1deg_30m  to the directory  v2.0_2021Feb . 
# The script also compresses the directories  1deg_10m  and  1deg_30m  into tar.gz files.
# The script is useful for creating a distribution package for the data.
#
echo "Begin copy_hires.sh script."

if [ "$#" -eq 0 ]; then
    echo "Defaulting to current year and month."
    YEAR_MON=$(date +"%Y%b")
else
    YEAR_MON=$1
fi
echo "YearMonth: $YEAR_MON"

TAG="v2.0_${YEAR_MON}"

INPBIN="../../hires_${YEAR_MON}/merge_water/"

cd $TAG
echo "Current directory: $(pwd)"

if [ -f "$INPBIN/1deg_10m" ]; then
    cp -r $INPBIN/1deg_10m   .
else
    echo "Directory path $INPBIN/1deg_10m does not exist from current directory."
fi

if [ -f "$INPBIN/1deg_30m" ]; then
    cp -r $INPBIN/1deg_30m   .
else
    echo "Directory path $INPBIN/1deg_30m does not exist from current directory."
fi

if [ -d "./1deg_10m" ]; then
    tar cvfz 1deg_10m.tar.gz 1deg_10m
else
    echo "Could not compress 1deg_10m directory. Directory $(pwd)/1deg_10m does not exist."
fi

if [ -d "./1deg_30m" ]; then
    tar cvfz 1deg_30m.tar.gz 1deg_30m
else
    echo "Could not compress 1deg_30m directory. Directory $(pwd)/1deg_30m does not exist."
fi

echo "End copy_hires.sh script."
###


