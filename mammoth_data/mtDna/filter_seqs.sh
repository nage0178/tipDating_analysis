# Removing sequences that are labeled as undated or unknown and removing 
grep ">" Diez-Pecnerova-Valk-etal-2021-mitogenomes.fasta | grep -v undated |grep -v "unknown" |grep -v -f noDates.txt  > partially_filtered

#grep ">" Diez-Pecnerova-Valk-etal-2021-mitogenomes.fasta |grep -v -f noDates.txt  > partially_filtered

sed -i 's/>//g' partially_filtered

# Removing sequences which do not have a species in the name
grep -v "Mammuthus" partially_filtered |grep -v "Lox" |grep -v "Ele" > noSpecies.txt


#SP then number (ei SP222) are in Chang_2017/table2_dates.txt, double check they are all there
# VEP, EID, SEP, SSEP, SID, SVEP all appear to be in Chang_2017 table3_dates.txt -check

# Finding species and then removing the ones which are not identified to the species level or are Mammuthus columbi
./findSpecies.sh |grep -v "Mammuthus_sp."| grep -v "columbi\|jeffer" > seqsWSpecies

./findDates.sh | grep -v "10643" | sed 's/27943\/29208/28576/' > sampleDates.txt

awk '{print $1 " " $2 " " $3 }' seqsWSpecies | sed 's/Mammuthus primigenius/Mammuthus_primigenius/g' |sed 's/Elephas maximus/Elephas_maximus/g' | sed 's/Loxodonta /Loxodonta_/g' > map_species.txt

awk '{print $1 " " $2 " " $3 }' seqsWSpecies | sed 's/Mammuthus primigenius/Mammuthus_primigenius/g' |sed 's/Elephas maximus/Elephas_maximus/g' | sed 's/Loxodonta /Loxodonta_/g' | sed "s/_[^ ]*_[^ ]*/ /g" | sed "s/f / /g" | sed 's/\.[1-2]//g'  | grep -v 10643 | grep -v "SP1144\|SP2293\|SP2401\|SP2411\|SP2412\|SP2415" > map_species.txt

awk '{print $1}' sampleDates.txt > seqNamesShort.txt
grep -f  seqNamesShort.txt Diez-Pecnerova-Valk-etal-2021-mitogenomes.fasta | sed 's/>//g' > seqNamesLong.txt

~/pullseq/src/pullseq -n seqNamesLong.txt -i Diez-Pecnerova-Valk-etal-2021-mitogenomes.fasta > mtDnaLongNames.fa

sed "s/_[^ ]*_[^ ]*/ /g" mtDnaLongNames.fa| sed "s/\.[1-2].*//g" | sed "s/f //g" > mtDna.fa

awk '{print $1}' L_cyclotis.fa >> mtDna.fa
awk '{print $1}' L_africana.fa >> mtDna.fa
awk '{print $1}' E_maximus.fa >> mtDna.fa

grep ">" E_maximus.fa |sed 's/>//g'  |awk '{print $1 " Elephas_maximus" }'     >> map_species.txt
grep ">" L_cyclotis.fa |sed 's/>//g'  |awk '{print $1 " Loxodonta_cyclotis" }' >> map_species.txt
grep ">" L_africana.fa |sed 's/>//g'  |awk '{print $1 " Loxodonta_africana" }' >> map_species.txt

grep ">" E_maximus.fa |sed 's/>//g'  |awk '{print $1 " 0" }'     >> sampleDates.txt
grep ">" L_cyclotis.fa |sed 's/>//g'  |awk '{print  $1 " 0" }' >> sampleDates.txt
grep ">" L_africana.fa |sed 's/>//g'  |awk '{print  $1 " 0" }' >> sampleDates.txt

# Change the dates of the shipwreck sequences
sed -i 's/MT636097.1 0/MT636097.1 417/g' sampleDates.txt
sed -i 's/MT636095.1 0/MT636095.1 417/g' sampleDates.txt
sed -i 's/MT636093.1 0/MT636093.1 417/g' sampleDates.txt


~/.AliView/binaries/muscle3.8.425_i86linux64 -in mtDna.fa -out  mtDnaAligned.fa &> outAlign 
Rscript stripGap.R &> outGapStrip
mkdir -p bpp
sed 's/>/^/g' mtDnaAlignedGapStrip.fa > bpp/mtDna.fa

sed -i "1s/^/94 16189\n/" bpp/mtDna.fa
cp sampleDates.txt bpp/.
cp map_species.txt bpp/.
