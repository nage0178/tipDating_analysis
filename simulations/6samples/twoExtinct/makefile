CC = gcc
CFLAGS=`pkg-config --cflags glib-2.0` -g -Wall -O3
LDADD=`pkg-config --libs glib-2.0`

drawDatesExtinct: drawDatesExtinct.c
	$(CC) $(CFLAGS) drawDatesExtinct.c --static -lgsl -lgslcblas -lm -g -o drawDatesExtinct
clean:
	$(RM)  drawDatesExtinct
