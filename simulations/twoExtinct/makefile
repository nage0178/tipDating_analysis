CC = gcc
CFLAGS=`pkg-config --cflags glib-2.0` -g -Wall -O3
LDADD=`pkg-config --libs glib-2.0`

drawDatesExtinct: drawDatesExtinct.c
	$(CC) $(CFLAGS) drawDatesExtinct.c --static -lgsl -lgslcblas -lm -g -o drawDatesExtinct
drawDatesExtinctMt: drawDatesExtinctMt.c
	$(CC) $(CFLAGS) drawDatesExtinctMt.c --static -lgsl -lgslcblas -lm -g -o drawDatesExtinctMt
drawDatesExtinctMt100: drawDatesExtinctMt100.c
	$(CC) $(CFLAGS) drawDatesExtinctMt100.c --static -lgsl -lgslcblas -lm -g -o drawDatesExtinctMt100
clean:
	$(RM)  drawDatesExtinct
	$(RM)  drawDatesExtinctMt
	$(RM)  drawDatesExtinctMt100
