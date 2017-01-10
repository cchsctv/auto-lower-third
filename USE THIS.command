#!/bin/sh
##Finds the most current version of After Effects (2014.2+ required)
AELOC="$(find /Applications -regex "/Applications/Adobe After Effects CC.*/.*aerender" -maxdepth 4)"
AELOC="$(echo $AELOC | rev)"
AELOC="$(echo $AELOC | sed s~rednerea~':'~g | cut -f 2 -d':')"
AELOC="$(echo $AELOC | rev)"
AELOC=$AELOC'aerender'

echo "Ill be using this version:"
echo $AELOC

##For some reason this makes evverything work
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Chua Title Visualizer (CTV) v2.017 by Jason Chua"
echo "For Sammi <3"

##Get User Input
echo "Enter the name (No Slashes) and press [ENTER]"
read NAME
echo "Enter the title and press [ENTER]"
read TITLE
echo "This title is for $NAME the $TITLE"

##Variables
TARGET="$(date +%s)"
AEPROJ="/lowerthird2017.aepx"
AEPROJ2="/$TARGET.aepx"
RENDES="/"$NAME".mov"

##Create tmp files
cp "$DIR""$AEPROJ" "$DIR""$AEPROJ2"

##Use Stream EDitor to change layer names
sed -i .bak s~CTV_NAME~"$NAME"~g "$DIR""$AEPROJ2"
sed -i .bak s~CTV_TITLE~"$TITLE"~g "$DIR""$AEPROJ2"

##Render with After Effects
"$AELOC" -project "$DIR""$AEPROJ2" -rqindex "1" -RStemplate "Best Settings" -output "$DIR""$RENDES"

##Remove tmp files
rm -R "$DIR""$AEPROJ2"*

##Close Terminal Window
osascript -e 'tell application "Terminal" to quit' &
exit
