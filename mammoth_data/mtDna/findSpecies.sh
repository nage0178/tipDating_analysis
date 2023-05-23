

cat partially_filtered | while read line 
do
   # do something with $line here
   #echo $line
	short=$(echo $line |awk '{print $1}' |awk -F _ '{print $1}')
	species=$(grep $short findSpecies.txt |awk -F , '{print $3}')
	echo $line $species
done


