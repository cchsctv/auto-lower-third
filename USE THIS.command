#!/bin/sh
## Adobe, the Adobe logo, and After Effects are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States and/or other countries.


##TODO Accept input NAME and TITLE as flags

#epoch time
EPOCH="$(date +%s)"
#set terminal window name
echo -n -e "\033]0;"$EPOCH"\007"

echo "Chua Title Visualizer (CTV) v2.017.4 by Jason Chua"
echo "For Sammi <3"
echo "To preserve output for debugging, pass an argument"

##Finds the most current version of After Effects (2014.2+ required)
SEARCH_DIR="/Applications"
AELOC="$(find $SEARCH_DIR -regex "$SEARCH_DIR/Adobe After Effects CC.*/.*aerender" -maxdepth 4)"
if [ "x$AELOC" = "x" ];
then
  echo "I couldnt find After Effects in $SEARCH_DIR"
  echo "Please move After Effects to $SEARCH_DIR"
fi
AELOC="$(echo $AELOC | rev)"
AELOC="$(echo $AELOC | sed s~rednerea~':'~g | cut -f 2 -d':')"
AELOC="$(echo $AELOC | rev)"
AELOC=$AELOC'aerender'
echo "I'll be using this version:"
echo $AELOC

##Get the current working directory, the directory the script is in
##Credit to Dave Dopson on StackOverflow
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "The current working directory is:"
echo $DIR

##Get User Input
echo "Enter the name (No Slashes) and press [ENTER]"
read NAME
echo "Enter the title and press [ENTER]"
read TITLE

#Sanitize slashes, in case user is illiterate
NAME="$(echo $NAME | tr "/ " " \ ")"
echo "This title is for $NAME the $TITLE"

##Destination Variables
#To Prevent collision of files, epoch time is used
#Limits to 1 per second but more than enough for standard use case
TARGET=$EPOCH
AEPROJ="/lowerthird2017.aepx"
AEPROJ_TMP="/$TARGET.aepx"
RENDES="/"$NAME".mov"

##Create tmp files
cp "$DIR""$AEPROJ" "$DIR""$AEPROJ_TMP"

##Use Stream EDitor to change layer names
edit_xml() {
  REPLACETHIS="$1"
  WITHTHIS="$2"
  sed -i .bak s~"$REPLACETHIS"~"$WITHTHIS"~g "$DIR""$AEPROJ_TMP"
}

edit_xml CTV_NAME "$NAME"
edit_xml CTV_TITLE "$TITLE"

##Render with After Effects
"$AELOC" -project "$DIR""$AEPROJ_TMP" -rqindex "1" -RStemplate "Best Settings" -output "$DIR""$RENDES"

##Remove tmp files
rm -R "$DIR""$AEPROJ_TMP"*

if [[ -z "$1" ]];
then
  osascript -e 'tell application "Terminal" to close (every window whose name contains '"$EPOCH"')' & exit
fi
