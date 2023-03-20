CC = gcc
CFLAGS=`pkg-config --cflags glib-2.0` -g -Wall -O3
LDADD=`pkg-config --libs glib-2.0`

testPrior_4_tip_symmetric: testPrior_4_tip_symmetric.c
	$(CC) $(CFLAGS) testPrior_4_tip_symmetric.c -lgsl -lgslcblas -lm -g -o testPrior_4_tip_symmetric
clean:
	$(RM) testPrior_4_tip_symmetric
