#!/bin/bash
#description:find the word who·s length is not greater than six
#author:vita
#version:v1.0
words="I am oldboy teacher welcome to oldboy training class"
for word in $words;do
    leth=$(expr length $word)
    [ $leth -le 6 ]&&echo "$word--length is $leth"
done
