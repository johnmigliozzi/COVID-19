data_path='../csse_covid_19_data/csse_covid_19_daily_reports'
out_file='result.txt'




locals=(
    "Allegheny, Pennsylvania, US"
    "Milwaukee, Wisconsin, US" 
    "New York City, New York, US"    
    "Allen, Ohio, US"
)


printf Date, > $out_file
printf "\"%s\"," "${locals[@]}" | sed 's/.$//' >> $out_file



for filename in $data_path/*.csv; do 

    dt=$(date -j -f "%m-%d-%Y.csv" $(echo $filename | awk -F "/" '{print $NF}') +%F);

    printf "%s" "$dt" >> $out_file
    
    for t in "${locals[@]}"; do
        # echo $t

        cases=$(cat $filename | grep "$t" | awk -F "US" '{print $2}'| awk -F "," '{print $5}')
        printf "%s" ",$cases" >> $out_file
    done

    printf $'\n' >> $out_file

done



# # Hubei, China

# cat $data_path/*.csv | grep "Hubei" | awk -F "China" '{print $2}'| awk -F "," '{print $2 "," $5}'

# # Allegheny