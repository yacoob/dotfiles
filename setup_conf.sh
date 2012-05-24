#!/usr/bin/env bash
shopt -s extglob

print_help_and_exit() {
    echo "  Usage: $0 <OS> <LOCATION>"
    echo "example: $0 osx home"
    exit 0
}

if  [[ $# -ne 2 ]] \
 || [[ "$1" != +([[:alpha:]]) ]] \
 || [[ "$2" != +([[:alpha:]]) ]]; then
    print_help_and_exit;
fi

FILE=${HOME}/.yacoob-conf
rm -f ${FILE}

CONFDIR=$(pwd)
echo "export OS=$1" > ${FILE}
echo "export LOCATION=$2" >> ${FILE}
echo "export CONFDIR=${CONFDIR}" >> ${FILE}
chmod u=r,go= ${FILE}

echo "${FILE} now contains:"
cat ${FILE}
