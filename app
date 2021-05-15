#!/bin/bash

cecho(){
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    NC="\033[0m" # No Color

    printf "${!1}${2} ${NC}\n"
}

Help()
{
   # display help
   echo "Get datewise COVID vaccination sessions held in India, by area PINCODE."
   echo
   echo "Syntax: $0 <date> <area-pin-code>"
   echo "--h     Print this Help."
   echo
   echo "Written by Keshav Bhatt<keshavnrj@gmail.com> Ktechpit.com"
}

while getopts ":h" option; do
   case $option in
      h) # display help
         Help
         exit;;
   esac
done

#no argument suplied
if [ -z "$2" ]; then
 pin="246149";
 echo "Using PIN " $pin;
else
 pin=$2;
 echo "Using passed PIN " $pin;
fi

#no argument suplied
if [ -z "$1" ]; then
   echo -e "\nUsing today's Date as input argument\n"
   dateStr=$(date +"%d-%m-%Y")
else #argument suplied
   PASSED_DATE=$1;
   DATE=$(date -d $PASSED_DATE '+%d-%m-%Y');
   VALID=false;
   #check date is valid
   [[ $(date -d "${PASSED_DATE//-/\/}" 2> /dev/null) ]] && VALID=true || VALID=false 
   if [ $VALID = true ]; then
    dateStr=$DATE;
    echo "Using passed date" $dateStr;
   else
    echo -e "\nInvalid date passed, please call '$0 <date>' to run this command!\nFor example \"$0 \$(date +'%Y-%m-%d')\" or \"$0 YYYY-MM-DD\"";
    exit;
   fi 
fi

echo $date;

out=$(curl --silent 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/calendarByPin?pincode='$pin'&date='$dateStr'' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36'   --compressed);

OUTPUT_VALID=false;
VALID_JSON=false;
#check if output is a valid json
echo "$out" | jq -e '.' >/dev/null 2>&1 && VALID_JSON=ture || VALID_JSON=false;

if [ $VALID_JSON = true ]; then
  #check if contains centers
  OUTPUT_VALID=$(echo "$out" | jq '. | contains({"centers"})');
  if [ $OUTPUT_VALID ];then
    echo "$out" | jq ;
  else
    cecho "RED" "No centres found, dumping raw output:";
    echo
    echo "$out" | jq ;
  fi  
else
  cecho "RED" "Invalid output, cannot parse! dumping raw output:";
  echo
  echo "$out";
fi
  
# use jq selectors like below to extract specified data from output, for more help (https://stedolan.github.io/jq/manual/)
#'.centers[].sessions' ;
