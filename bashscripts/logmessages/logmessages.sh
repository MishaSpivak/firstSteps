#!/bin/bash
#Parse /var/log/messages
#Get every message from every even second
#Get every odd word from that every message
#Replace all vowels with letter "s" in all these words
#Count the letters "s" in resulting message
#if remnant of divsion of that number by three is not 0, then repeat the loop, discarding first 10 messages in the log until the remnant is 0
sudo awk '$3 ~ /\<.{6}[0-6][0,2,4,6,8]/ { print }' /var/log/messages > test1
numbwr_of_collumn=$(awk '$0=""NR": "NF' test1 > test2 && awk -F : '{print $2}' test2 | sort -n | tail -n 1)
number_of_line=$(awk -F : '{print $1}' test2 | sort -n | tail -n 1 )
listPATH="$"
k=$
for ((i = 1 ; i <= $numbwr_of_collumn ; i=i+2)); do
 listPATH+=$i,$k
done
echo $listPATH > test3
z=$(rev test3 | cut -c 3- | rev)
printW="sudo awk '{ print $z }' test1"
eval $printW > test4 
sed -i "s/[aeiouAEIOUS]/s/g" test4
cp test4 test14
for ((q = $number_of_line ; q <= $number_of_line ; q=q-10)); do
	tail -n $q test14 > test5
cat test5 |tr -cd 's' | wc -m > test6
ns=$(cat test6)
m=$(awk 'BEGIN{print ('"$ns"'/'"3"')}')
if (($m % 3 == 0)) 2>/dev/null
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




#cat $number_of_line
#cat $number_of_line_after_cycle

#echo $ns
#echo $number_of_line

#for value in $ns
#do
#m=$(awk 'BEGIN{print ('"$ns"'/'"3"')}')
#if [$m % 3 == 0]
#then
#echo -e "\e[32msuccess\e[0m"
#else
#sed -i '1d' /test4
#cat test4 |tr -cd 's' | wc -m > test5
#ns=$(cat test5)
#continue
#fi
#done

