pdftotext -layout pbio.1000564.s003.pdf
grep -v "                                        " pbio.1000564.s003.txt  | grep -v '1 1 1 1 1' > mammoth_nuclear_prep.txt
#grep -v "                                         " pbio.1000564.s003.txt  | grep -v '1 1 1 1 1' > mammoth_nuclear_prep.txt
sed -i 's/\f//g' mammoth_nuclear_prep.txt
#head -n -6 mammoth_nuclear_prep.txt | tail +2 > mammoth_nuclear.txt
tail +2 mammoth_nuclear_prep.txt > mammoth_nuclear.txt
 
sed -i 's/_[^ ]*//g' mammoth_nuclear.txt
sed -i 's/ASIAN/^ASIAN/g' mammoth_nuclear.txt
sed -i 's/FOR/^FOR/g' mammoth_nuclear.txt
sed -i 's/MAM/^MAM/g' mammoth_nuclear.txt
sed -i 's/MAST/^MAST/g' mammoth_nuclear.txt
sed -i 's/SAV/^SAV/g' mammoth_nuclear.txt


for dates in Old Young
do

        sed  "s/dates.txt/dates${dates}.txt/g"  Mean.ctl > ${dates}.ctl
done



echo $(cat mammoth_nuclear.txt ) | awk -F ^ '{for (i=1;i<=NF;i++) print $i}' |sed "s/ $//g" | sed 's/5 /\n/g' | awk '{if (NF == 1) {print "\n" 4 " " $1} else {print }; }' |grep -v MAST |sed "s/ $//g"> noMast.txt

sed -i 's/ASIAN/^ASIAN/g' noMast.txt
sed -i 's/FOR/^FOR/g' 	  noMast.txt
sed -i 's/MAM/^MAM/g'     noMast.txt
sed -i 's/MAST/^MAST/g'   noMast.txt
sed -i 's/SAV/^SAV/g'     noMast.txt

seed=1
for dates in Old Young Mean noMast
do

	for rep in {1,2}
	do
		mkdir -p ${dates}_${rep}
		
		sed "s/seed = 1/seed = ${seed}/g" ${dates}.ctl  > ${dates}_${rep}/${dates}.ctl

		((seed=seed+1))
	done
done
