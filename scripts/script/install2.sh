#!/bin/bash
#description:compare to variable
#author:vita
#version:v1.0
cat <<EOF
1.install MySQL
2.install Tomcat
3.exit
EOF
read -p "(please input one number :)" num
[ -z "$num" ] && {
echo "you must input something" 
exit 5
}
expr $num + 2 &>/dev/null
[ $? -ne 0 ] && {
    echo "you must input one number!"
    exit 1
}
[ $num -eq 1 ] &&{
    echo "start to install MySQL"
    exit 2
}
[ $num -eq 2 ]&&{
    echo "start to install Tomcat"
    exit 3
}
[ $num -eq 3 ]&&{
    echo "exit now"
    exit 4
}
[ $num -gt 3 ]&&{
    echo "you can not input one number greater than 3"
    exit 5
}
