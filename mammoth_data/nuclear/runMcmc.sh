for dates in Old Young Mean noMast
do

	for rep in {1,2}
	do
		cd ${dates}_${rep}
		
		~/bpp/src/bpp --cfile  ${dates}.ctl &> output &

		cd ../

	done
done
wait;
