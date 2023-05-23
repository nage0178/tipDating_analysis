grep -v 5 mammoth_nuclear.txt |echo $(cat $1) |sed 's/\^/\n/g' > rmLinesNuclear.txt

grep ASIAN rmLinesNuclear.txt |awk '{$1=""}1' | echo $(cat $1) | sed 's/ //g' > ASIAN
grep FOR rmLinesNuclear.txt |awk '{$1=""}1' | echo $(cat $1) | sed 's/ //g' > FOR
grep MAM rmLinesNuclear.txt |awk '{$1=""}1' | echo $(cat $1) | sed 's/ //g' > MAM
grep SAV rmLinesNuclear.txt |awk '{$1=""}1' | echo $(cat $1) | sed 's/ //g' > SAV
grep MAST rmLinesNuclear.txt |awk '{$1=""}1' | echo $(cat $1) | sed 's/ //g' > MAST

echo '>ASIAN' > seqPrior.fa
echo $(cat ASIAN)  >> seqPrior.fa

echo '>FOR' >> seqPrior.fa
echo $(cat FOR)  >> seqPrior.fa

echo '>MAM' >> seqPrior.fa
echo $(cat MAM)  >> seqPrior.fa

echo '>SAV' >> seqPrior.fa
echo $(cat SAV)  >> seqPrior.fa

echo '>MAST' >> seqPrior.fa
echo $(cat MAST)  >> seqPrior.fa

#sed -i 's/_[^ ]*//g' mammoth_nuclear.txt
#sed -i 's/ASIAN/^ASIAN/g' mammoth_nuclear.txt
#sed -i 's/FOR/^FOR/g' mammoth_nuclear.txt
#sed -i 's/MAM/^MAM/g' mammoth_nuclear.txt
#sed -i 's/MAST/^MAST/g' mammoth_nuclear.txt
#sed -i 's/SAV/^SAV/g' mammoth_nuclear.txt

#ASIAN2_Ema
#FOR_DS1535
#MAM1_A001_
#MAST_A001_
#SAV1_SE210
