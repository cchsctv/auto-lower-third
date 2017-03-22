#!/bin/sh
## Adobe, the Adobe logo, and After Effects are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States and/or other countries.

##Finds the most current version of After Effects (2014.2+ required)

##TODO
## Accept input NAME and TITLE as flags

SEARCH_DIR="/Applications"
#AELOC="$(find $SEARCH_DIR -maxdepth 4 -regex "$SEARCH_DIR/Adobe After Effects CC.*/.*aeredddnder")" #This line will fail. This is intentional
AELOC="$(find $SEARCH_DIR -maxdepth 4 -regex "$SEARCH_DIR/Adobe After Effects CC.*/.*aerender")"
while [ "x$AELOC" = "x" ];
do
  echo "I couldnt find After Effects in $SEARCH_DIR"
  echo "Would you like to specify a directory I should look in?"
  read RESPONSE
  if [[ "$RESPONSE" =~ ^([yY][eE][sS]|[yY])+$ ]];
  then
    echo "Enter a directory"
    read SEARCH_DIR
    AELOC="$(find $SEARCH_DIR -maxdepth 4 -regex "*$SEARCH_DIR/.*aerender")"
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
##Dave Dopson on StackOverflow
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "The current working directory is:"
echo $DIR

echo "Chua Title Visualizer (CTV) v2.017.3 by Jason Chua"
echo "For Sammi <3"

##Get User Input
echo "Enter the name (No Slashes) and press [ENTER]"
#read NAME
echo "Enter the title and press [ENTER]"
#read TITLE
echo "This title is for $NAME the $TITLE"

##Sanitize inputs
##TODO
echo $NAME | tr "/"  " "

##Variables
#To Prevent collision of files, epoch time is used
#Limits to 1 per second but more than enough for
#Standard use case
TARGET="$(date +%s)"
AEPROJ="/lowerthird2017.aepx"
AEPROJ_TMP="/$TARGET.aepx"
RENDES="/"$NAME".mov"

##Create tmp files
cp "$DIR""$AEPROJ" "$DIR""$AEPROJ_TMP"

##Use Stream EDitor to change layer names
#TODO
#Make into a function

TITLE=TITLE
NAME=NAME

edit_xml() {
  REPLACETHIS="$1"
  WITHTHIS="$2"
  echo $REPLACETHIS
  echo $WITHTHIS
  echo $DIR
  echo $AEPROJ_TMP
  sed -i .bak s~"$REPLACETHIS"~"$WITHTHIS"~g "$DIR""$AEPROJ_TMP"
}

edit_xml CTV_NAME $NAME
#sed -i .bak s~CTV_NAME~"$NAME"~g "$DIR""$AEPROJ_TMP"
edit_xml CTV_TITLE "\$TITLE"
#sed -i .bak s~CTV_TITLE~"$TITLE"~g "$DIR""$AEPROJ_TMP"

##Render with After Effects
"$AELOC" -project "$DIR""$AEPROJ_TMP" -rqindex "1" -RStemplate "Best Settings" -output "$DIR""$RENDES"

##Remove tmp files
rm -R "$DIR""$AEPROJ_TMP"*

##Close Terminal Window
#osascript -e 'tell application "Terminal" to quit' &
#exit
echo -n -e "\033]0;My Window Name\007"
osascript -e 'tell application "Terminal" to close "My Window Name" & exit
