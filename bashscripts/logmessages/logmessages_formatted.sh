#!/bin/bash
# Parse /var/log/messages
# Get every message from every even second
# Get every odd word from that every message
# Replace all vowels with letter "s" in all these words
# Count the letters "s" in resulting message
# if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0

# Get every message from every even second
message_from_even_second=$(sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages)
#sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages > test1
#echo "$message_from_even_second"
# Get count of columns
count_of_columns_and_lines=$(echo "$message_from_even_second" | awk '$0=""NR":"NF')
echo "$count_of_columns_and_lines"
#count_of_columns=$('{print $2}' "$count_of_collumns_and_lines" | sort -n | tail -n 1)

# get count of lines
#count_of_lines=$(awk -F : '{print $1}' $count_of_collumns_and_lines | sort -n | tail -n 1 )

# Get every odd word from that every message
listPATH="$"
symbol=$

#for ((i = 1 ; i <= $count_of_columns ; i=i+2)); do
	listPATH+=$i,$symbol
done
echo $listPATH

# $listPATH = something like $1,$2,$, so last 2 symbols have to be cut
cut_last_2_symbol=$(rev $listPATH | cut -c 3- | rev) 
printW="sudo awk '{ print $cut_last_2_symbol }' $message_from_even_second"
file_with_evensecond_and_odd_words=$(eval $printW)

# Replace all vowels with letter "s" in all these words
sed -i "s/[aeiouAEIOUS]/s/g" $file_with_evensecond_and_odd_words
# Count the letters "s" in resulting message
# if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0
#for ((q = $count_of_lines ; q <= $count_of_lines ; q=q-10)); do
    tail -n $q $file_with_evensecond_and_odd_words
	
	
	# add variable count_of_symbol_s
	count_of_symbols_s=$(cat $file_with_evensecond_and_odd_words |tr -cd 's' | wc -m)

	
	if (($count_of_symbols_s % 3 == 0)) 2>/dev/null
	then
		echo -e "\e[32msuccess\e[0m"
		break
	else
		echo -e "\e[31merror\e[0m"
		continue
	fi
done

