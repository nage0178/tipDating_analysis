awk -F , '{print $1 "," $10 "," $12}' supplements/Chang_2017/table1_dates.txt > dates_reduced.txt
awk -F , '{print $1 "," $10 "," $12}' supplements/Chang_2017/table2_dates.txt >> dates_reduced.txt
awk -F , '{print $1 "," $12 "," $2}' supplements/Chang_2017/table3_dates.txt >> dates_reduced.txt
awk -F , '{print $1 "," $10 "," $11}' supplements/Chang_2017/table4_dates.txt >> dates_reduced.txt
awk -F '\t' '{print $1 "," $4"," $9}' supplements/Pecnerova_2017/table_1.txt >> dates_reduced.txt
echo NC_007596.2,12170, >> dates_reduced.txt
echo Scotland,48264, >> dates_reduced.txt

# have two identical sequences
# 10643f_Beringia_25890_140_30131
# KX176750.1 Mammuthus primigenius isolate 10643 mitochondrion, partial genome KX176750 30131

cat seqsWSpecies | while read line 
do
   # do something with $line here
   #echo $line
   modern=$(echo $line |grep 'Lox\|Ele')
   if [ ! -z "$modern" ]
   then
	   short=$(echo $line |awk '{print $1}' | sed 's/\.[1-2]//g')
	   echo $short 0
	   continue
   fi

   

	short=$(echo $line |awk '{print $1}' |awk -F _ '{print $1}'| sed 's/\.[1-2]//g' | sed 's/f\>//g')
	if [ "$short" == "NC" ]
	then
		
		short=$(echo $line |awk '{print $1}' | sed 's/\.[1-2]//g')
	fi
	#echo $short

	dateline=$(grep $short dates_reduced.txt | awk -F , '{print $2}' |head -1)
	if [ ! -z $dateline ]
	then
		echo $short $dateline
	fi

done
