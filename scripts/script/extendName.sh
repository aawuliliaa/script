#!/bin/bash
#description:identify the extend name of one file
#author:vita
#version:v1.0
if expr "$1" : .*\.pub &>/dev/null
  then
    echo "you are using $1"
else
  echo "pls use *.pub file"
fi
