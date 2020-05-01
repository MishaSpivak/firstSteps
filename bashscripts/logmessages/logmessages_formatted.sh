#!/bin/bash
# Parse /var/log/messages
# Get every message from every even second
# Get every odd word from that every message
# Replace all vowels with letter "s" in all these words
# Count the letters "s" in resulting message
# if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0

# Get every message from every even second
sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages > test1

# Get count of columns
count_of_columns=$(awk '$0=""NR": "NF' test1 > test2 && awk -F : '{print $2}' test2 | sort -n | tail -n 1)

# get count of lines
count_of_lines=$(awk -F : '{print $1}' test2 | sort -n | tail -n 1 )

# Get every odd word from that every message
listPATH="$"
symbol=$

for ((i = 1 ; i <= $count_of_columns ; i=i+2)); do
	listPATH+=$i,$symbol
done
echo $listPATH > test3

# $listPATH = something like $1,$2,$, so last 2 symbols have to be cut
cut_last_2_symbol=$(rev test3 | cut -c 3- | rev) 
printW="sudo awk '{ print $cut_last_2_symbol }' test1"
eval $printW > test4

# Replace all vowels with letter "s" in all these words
sed -i "s/[aeiouAEIOUS]/s/g" test4
cp test4 test14
# Count the letters "s" in resulting message
# if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0
for ((q = $count_of_lines ; q <= $count_of_lines ; q=q-10)); do
    tail -n $q test14 > test5
	
	#Count the letters "s" in resulting message
	cat test5 |tr -cd 's' | wc -m > test6   
	
	# add variable count_of_symbols_s
	count_of_symbols_s=$(cat test6)
	
	if (($count_of_symbols_s % 3 == 0)) 2>/dev/null
	then
		echo -e "\e[32msuccess\e[0m"
		break
	else
		echo -e "\e[31merror\e[0m"
		continue
	fi
done
 count_of_symbol_s_befor_cycle=$(cat test4 |tr -cd 's' | wc -m)

 echo $count_of_symbol_s_befor_cycle
 echo $count_of_symbols_s

