#!/bin/sh
## Adobe, the Adobe logo, and After Effects are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States and/or other countries.

##Finds the most current version of After Effects (2014.2+ required)
SEARCHDIR="/Applications"
AELOC="$(find $SEARCHDIR -maxdepth 4 -regex "*/Adobe After Effects CC.*/.*aerender")"
while [ "x$AELOC" = "x" ];
do
  echo "I couldnt find After Effects in $SEARCHDIR"
  echo "Would you like to specify a directory I should look in?"
#  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  if [ "$response" =~ ^\(\[yY\]\[eE\]\[sS\]\|\[yY\]\)\+\$ ]; then
    echo "Enter a directory"
    read SEARCHDIR
    AELOC="$(find $SEARCHDIR -maxdepth 16 -regex "*/Adobe After Effects CC.*/.*aerender.*")"
  else
    echo "Have a nice day!"
    exit
  fi
done
AELOC="$(echo $AELOC | rev)"
AELOC="$(echo $AELOC | sed s~rednerea~':'~g | cut -f 2 -d':')"
AELOC="$(echo $AELOC | rev)"
AELOC=$AELOC'aerender'

echo "I'll be using this version:"
echo $AELOC

##Get the current working directory, the directory the script is in
##Dave Dopson on StackOverflows
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="$( pwd )"

echo "The current working directory is:"
echo $DIR

echo "Chua Title Visualizer (CTV) v2.017.3 by Jason Chua"
echo "For Sammi <3"

##Get User Input
echo "Enter the name (No Slashes) and press [ENTER]"
read NAME
echo "Enter the title and press [ENTER]"
read TITLE
echo "This title is for $NAME the $TITLE"

##Sanitize inputs
##TODO

##Variables
#To Prevent collision of files, epoch time is used
#Limits to 1 per second but more than enough for
#Standard use case
TARGET="$(date +%s)"
AEPROJ="/lowerthird2017.aepx"
AEPROJ2="/$TARGET.aepx"
RENDES="/"$NAME".mov"

##Create tmp files
cp "$DIR""$AEPROJ" "$DIR""$AEPROJ2"

##Use Stream EDitor to change layer names
#TODO
#Make into a function\
edit_xml() {
  REPLACETHIS="$1"
  WITHTHIS="$2"
  echo $REPLACETHIS
  echo $WITHTHIS
  sed -i s~"$REPLACETHIS"~"$WITHTHIS"~g "$DIR""$AEPROJ2"
}
edit_xml CTV_NAME "$NAME"
#sed -i .bak s~CTV_NAME~"$NAME"~g "$DIR""$AEPROJ2"
#sed -i .bak s~CTV_TITLE~"$TITLE"~g "$DIR""$AEPROJ2"

##Render with After Effects
"$AELOC" -project "$DIR""$AEPROJ2" -rqindex "1" -RStemplate "Best Settings" -output "$DIR""$RENDES"

##Remove tmp files
rm -R "$DIR""$AEPROJ2"*

##Close Terminal Window
#osascript -e 'tell application "Terminal" to quit' &
exit
