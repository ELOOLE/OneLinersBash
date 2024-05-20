#!/bin/bash

file1="dane.txt"
file2="dane_tmp.txt"
file3="wynik.txt"

loop=1
count_next=0
while [ $loop -eq 1 ];
do
    while read -r line;
    do 
        ile=$(printf $line|sed 's/[^.]//g'| awk '{ print length }')

        if [[ $ile -eq 1 ]]
        then 
            echo "$line" >> "$file3"
        else
            if [[ $ile -gt 0 ]]
            then 
            echo "$line" >> "$file2" 
            fi
        fi
    done < "$file1"

    cut -d "." -f 2-1000 "$file2" > "$file1"
    rm "$file2"
    count_next=$(cat "$file1" |wc -l)

    if [[ $count_next -eq 0 ]]
    then
        loop=0
    fi
done

rm "$file1"
cat "$file3"|sort|uniq > "$file2"
mv "$file2" "$file3"
