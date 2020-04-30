#!/bin/bash
sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages > test1
d=$(awk '$0="line"NR": "NF' test1 > test2 && awk -F : '{print $2}' test2 | sort -n | tail -n 1)
listPATH="$"
k=$
for ((i = 1 ; i <= $d ; i=i+2)); do
 listPATH+=$i,$k
done
echo $listPATH > test3
z=$(rev test3 | cut -c 3- | rev)
printW="sudo awk '{ print $z }' test1"
eval $printW > test4 
sed -i "s/[aeiouAEIOUS]/s/g" test4
cat test4 |tr -cd 's' | wc -m > test5
ns=$(cat test5)
echo $ns
m=$(awk 'BEGIN{print ('"$ns"'/'"3"')}')
echo $m
if(($m % 3 == 0))
then
        echo -e "\e[32msuccess\e[0m"
else
        echo -e "\e[31merror\e[0m"
fi
#end
