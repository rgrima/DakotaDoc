#!/bin/bash
BOLD="\033[1m"
UNLI="\033[4m"
END="\033[0m"
FN=dakotatheory
shopt -s expand_aliases

# CLEAN
function CLEAN
{
  fn=$1
  for ext in aux dvi log pdf toc blg bbl
  do
    name=${fn}.${ext}
    if [ -f ${name} ]
    then
      echo -e "${BOLD}CLEANING:${END} ${name}"
      rm $name
    fi
  done
}
# CLEAN

function PROCESS
{
  fn=$1
  name=${fn}.tex
  auxn=${fn}.aux
  if [ ! -f ${name} ]; then echo -e "${BOLD}ERROR:${END}\n\tCan not find latex file ${UNLI}${name}${END}"; exit; fi
  echo -e "${BOLD}PROCESSING:${END} ${name}"
  pdflatex ${name}
#  bibtex   ${auxn}
  pdflatex ${name}
}

if [ "$#" -gt 1 ]; then echo -e "${BOLD}ERROR:${END}\n\tToo much parameters"; exit; fi
if [ "$#" -eq 1 ];
then
  if [ "$1" == "clean" ]
  then
    CLEAN ${FN}
    exit
  else
    FN=$1
  fi
fi
CLEAN ${FN}
PROCESS ${FN}
