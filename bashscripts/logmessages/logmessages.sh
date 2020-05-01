#!/bin/bash
#Parse /var/log/messages
#Get every message from every even second
#Get every odd word from that every message
#Replace all vowels with letter "s" in all these words
#Count the letters "s" in resulting message
#if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0
#Get every message from every even second
sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages > test1
#Get number of column
number_of_column=$(awk '$0=""NR": "NF' test1 > test2 && awk -F : '{print $2}' test2 | sort -n | tail -n 1)
#get number of line
number_of_line=$(awk -F : '{print $1}' test2 | sort -n | tail -n 1 )
#Get every odd word from that every message
listPATH="$"
symbol=$
for ((i = 1 ; i <= $number_of_column ; i=i+2)); do
 listPATH+=$i,$symbol
done
echo $listPATH > test3
cut_last_2_symbol=$(rev test3 | cut -c 3- | rev) #$listPATH = something like $1,$2,$,  so I have to cut last 2 symbol
printW="sudo awk '{ print $cut_last_2_symbol }' test1"
eval $printW > test4 
#Replace all vowels with letter "s" in all these words
sed -i "s/[aeiouAEIOUS]/s/g" test4
cp test4 test14
#Count the letters "s" in resulting message
#if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0
for ((q = $number_of_line ; q <= $number_of_line ; q=q-10)); do
	tail -n $q test14 > test5
cat test5 |tr -cd 's' | wc -m > test6   #Count the letters "s" in resulting message
#add variable number_od_symbol_S
number_of_symbol_s=$(cat test6)
#add varible equality_number
equality_number=$(awk 'BEGIN{print ('"$number_of_symbol_s"'/'"3"')}')
if (($equality_number % 3 == 0)) 2>/dev/null
then
        echo -e "\e[32msuccess\e[0m"
	break
else
	echo -e "\e[31merror\e[0m"
	continue
fi
done
number_of_line_after_cycle=$(awk -F : '{print $1}' test14 | sort -n | tail -n 1 )
wc test1 test5
