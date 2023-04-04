CC = gcc
CFLAGS=`pkg-config --cflags glib-2.0` -g -Wall -O3
LDADD=`pkg-config --libs glib-2.0`

drawDatesPop: drawDatesPop.c
	$(CC) $(CFLAGS) drawDatesPop.c -lgsl -lgslcblas -lm -g -o drawDatesPop
clean:
	$(RM)  drawDatesPop
