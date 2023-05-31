#!/bin/bash

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

LOG_FILE="backup-log.txt"

if [[ "$#" == 0 ]]
then
  echo -e "${CYAN}ArgumentError:${NC} Missing required arguments"
fi

while [[ "$#" -gt 0 ]]; do
  case $1 in
    "-e")
      if [[ "$#" == 1 ]]
      then
        echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
        exit 1
      fi
        ZIP_ARGS=""
        for (( 1=1; i<"$#"; 1++ ))
        do
          if [ -d "${@:i+1:1}" ]
          then
            ZIP_ARGS+="${@:i+1:1} "
          else
            echo "LocateError: Can not locate ./"${@:i+1:1}""
            exit 1
          fi
        done
        echo "Enter destination folder (if root press ENTER)"
        read DEST_DIR
        if [ "DEST_DIR" == "" ]
        then
          date >> $LOG_FILE
          zip -r -e "$(date +"%Y-%m-%d %H:%M:%S")-encrypt" $ZIP_ARGS >> $LOG_FILE
          echo -e "${CYAN}Encrypting${NC} ${YELLOW}folders${NC}"
                   echo -ne '#####                     (33%)\r\c'
                   sleep 1
                   echo -ne '#############             (66%)\r\c'
                   sleep 1
                   echo -ne '#######################   (100%)\r\c'
                   echo -ne '\n'
                   echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped and encrypted!${NC}"
                   echo "----------------------" >> $LOG_FILE
                   echo -e "ENCRYPTION SUCCESSFUL\n" >> $LOG_FILE
               else
                   if [ -d $DEST_DIR ]
                   then
                       echo $ZIP_ARGS
                       date >> $LOG_FILE
                       zip -r -e "$DEST_DIR/$(date +"%Y-%m-%d %H:%M:%S")-encrypt" $ZIP_ARGS >> $LOG_FILE
                       echo -e "${CYAN}Encrypting${NC} ${YELLOW}folders${NC}"
                       echo -ne '#####                     (33%)\r\c'
                       sleep 1
                       echo -ne '#############             (66%)\r\c'
                       sleep 1
                       echo -ne '#######################   (100%)\r\c'
                       echo -ne '\n'
                       echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped and encrypted!${NC}"
                       echo "----------------------" >> $LOG_FILE
                       echo -e "ENCRYPTION SUCCESSFUL\n" >> $LOG_FILE
                   else
                       echo -e "${CYAN}DestinationError:${NC} Can not locate ./${DEST_DIR}"
                       exit 1
                   fi
               fi
               ;;
       "-u")
           if [[ "$#" == 1 ]]
           then
               echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
               exit 1
           fi
           echo "Enter destination folder (if none press ENTER)"
           read DEST_DIR
           for (( i=1; i<="$#"; i++ ))
           do
               if [ -f "${@:i+1:1}" ]
               then
                   if [ "$DEST_DIR" == "" ]
                   then
                       unzip "${@:i+1:1}" -d "$(date +"%Y-%m-%d %H:%M:%S")-unzip" >> $LOG_FILE
                   else
                       if [ -d $DEST_DIR ]
                       then
                           unzip "${@:i+1:1}" -d "$DEST_DIR/$(date +"%Y-%m-%d %H:%M:%S")-unzip" >> $LOG_FILE
                       else
                           echo -e "${CYAN}DestinationError:${NC} Can not locate ./${DEST_DIR}"
                           exit 1
                       fi
                   fi
               else
                   echo "LocateError: Can not locate ./"${@:i+1:1}""
                   exit 1
               fi
           done
           date >> $LOG_FILE
           echo -e "${CYAN}Unzipping${NC} ${YELLOW}folders${NC}"
           echo -ne '#####                     (33%)\r\c'
           sleep 1
           echo -ne '#############             (66%)\r\c'
           sleep 1
           echo -ne '#######################   (100%)\r\c'
           echo -ne '\n'
           echo -e "${GREEN}Folders has been successfully un-zipped!${NC}"
           echo "----------------------" >> $LOG_FILE
           echo -e "UNZIP SUCCESSFUL\n" >> $LOG_FILE
           ;;
       "-z")
           if [[ "$#" == 1 ]]
           then
               echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
               exit 1
           fi
           ZIP_ARGS=""
           for (( i=1; i<"$#"; i++ ))
           do
               if [ -d "${@:i+1:1}" ]
               then
                   ZIP_ARGS+="${@:i+1:1} "
               else
                   echo "LocateError: Can not locate ./"${@:i+1:1}""
                   exit 1
               fi
           done
           echo "Enter destination folder (if none press ENTER)"
           read DEST_DIR
           if [ "$DEST_DIR" == "" ]
           then
               date >> $LOG_FILE
               zip -r "$(date +"%Y-%m-%d %H:%M:%S")" $ZIP_ARGS >> $LOG_FILE
               echo -e "${CYAN}Zipping${NC} ${YELLOW}folders${NC}"
               echo -ne '#####                     (33%)\r\c'
               sleep 1
               echo -ne '#############             (66%)\r\c'
               sleep 1
               echo -ne '#######################   (100%)\r\c'
               echo -ne '\n'
               echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped!${NC}"
               echo "----------------------" >> $LOG_FILE
               echo -e "ZIP SUCCESSFUL\n" >> $LOG_FILE
           else
               if [ -d $DEST_DIR ]
               then
                   date >> $LOG_FILE
                   zip -r "$DEST_DIR/$(date +"%Y-%m-%d %H:%M:%S")" $ZIP_ARGS >> $LOG_FILE
                   echo -e "${CYAN}Zipping${NC} ${YELLOW}folders${NC}"
                   echo -ne '#####                     (33%)\r\c'
                   sleep 1
                   echo -ne '#############             (66%)\r\c'
                   sleep 1
                   echo -ne '#######################   (100%)\r\c'
                   echo -ne '\n'
                   echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped!${NC}"
                   echo "----------------------" >> $LOG_FILE
                   echo -e "ZIP SUCCESSFUL\n" >> $LOG_FILE
               else
                   echo -e "${CYAN}DestinationError:${NC} Can not locate ./${DEST_DIR}"
                   exit 1
               fi
           fi
           ;;
       "-h")
           clear
           echo -e "${CYAN}NAME${NC}"
           echo -e "${YELLOW}Zippy - Zip, encrypt and unzip directories${NC}"
           echo -e "${CYAN}SYNOPSIS${NC}"
           echo -e "${YELLOW}bash ./zippy.sh [OPTION] [TARGET]${NC}"
           echo -e "${CYAN}DESCRIPTION${NC}"
           echo -e "${YELLOW}Zippy is a shell script to zip, encrypt and unzip directories${NC}"
           echo -e "${CYAN}OPTIONS${NC}"
           echo -e "${YELLOW}-e [target(s)] : Zips & Encrypts directories${NC}"
           echo -e "${YELLOW}-h: Print this help message${NC}"
           echo -e "${YELLOW}-u [target(s)]: Unzips zipped directory${NC}"
           echo -e "${YELLOW}-z [target(s)]: Zips directories${NC}"
           exit 1
           ;;
       *)
           echo -e "${CYAN}ArgumentError:${NC} Unknown argument: $1"
           exit 1
           ;;
   esac; shift;
done
