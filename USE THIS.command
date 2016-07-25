#!/bin/sh
AELOC="/Applications/Adobe After Effects CS6/aerender"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AEPROJ="/Lower_Third.aepx"
AEPROJ2="/Lower_Third2.aepx"
echo "This script assumes you have After Effects CS 6 Installed"
echo "Chua Title Visualizer (CTV) v0.2 by Jason Chua"
echo "For Sammi <3"
echo "Enter the name (No Slashes) and press [ENTER]"
read NAME
echo "Enter the title and press [ENTER]"
read TITLE
RENDES="/"$NAME".mov"
cp "$DIR""$AEPROJ" "$DIR""$AEPROJ2"
echo "This title is for $NAME the $TITLE"
sed -i .bak s~CTV_NAME~"$NAME"~g "$DIR""$AEPROJ2"
sed -i .bak s~CTV_TITLE~"$TITLE"~g "$DIR""$AEPROJ2"
"$AELOC" -project "$DIR""$AEPROJ2" -rqindex "1" -RStemplate "Best Settings" -output "$DIR""$RENDES" -mp
rm -R "$DIR""$AEPROJ2"*
osascript -e 'tell application "Terminal" to quit' &
exit
