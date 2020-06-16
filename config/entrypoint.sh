#!/bin/bash

set -e

MAIN_PATH="/opt/agent"
XML_CONFIG_PATH="${MAIN_PATH}/config.xml"
XML_ORIGIN="origin"
WRAPPER_PATH="${MAIN_PATH}/bin/wrapper-linux-x86-64"

declare -A mid

# Mandorory variables
SN_URL="${SN_URL:?-Error: Mandotory variable}"
SN_USERNAME="${SN_USERNAME:?-Error: Mandotory variable}"
SN_PASSWORD="${SN_PASSWORD:?-Error: Mandotory variable}"
SN_MID_NAME="${SN_MID_NAME:?-Error: Mandorory variable}"

logs() {
    local DATE=$(date +%F-%T)
    printf "[%s]: %s \n" $DATE "$@"
}

checkWrapperPermission() {
   logs "Check wrapper permissions"

   if [[ ! -x ${WRAPPER_PATH} ]]
      then
          chmod +x ${WRAPPER_PATH}
   fi
}

checkXMLConf() {

  logs "Checking if the main config.xml is in a new path"
  if [[ ! -e  "${XML_CONFIG_PATH}_${XML_ORIGIN}" ]];
    then
      cp -v ${XML_CONFIG_PATH}{,_${XML_ORIGIN}}
      midConfig
  fi
}


midConfig() {

  mid=(
      ["YOUR_INSTANCE.service-now.com"]="${SN_URL}"
      ["YOUR_INSTANCE_USER_NAME_HERE"]="${SN_USERNAME}"
      ["YOUR_INSTANCE_PASSWORD_HERE"]="${SN_PASSWORD}"
      ["YOUR_MIDSERVER_NAME_GOES_HERE"]="${SN_MID_NAME}"
    )

    logs "Adds parameters to mid_server config.xml"

    for key in ${!mid[@]};
        do
          printf "%-10s   %-10s\n" $key ${mid[$key]}
          sed -i 's/'"${key}"'/'"${mid[$key]}"'/' ${XML_CONFIG_PATH}
    done
}


main() {
  checkWrapperPermission
  checkXMLConf
}

main
exec "$@"
