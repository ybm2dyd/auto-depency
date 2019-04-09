INC = -Iinc
CC = gcc

SRC = $(wildcard src/*.c)

OBJ = $(SRC:.c=.o)

%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $< $(INC)

server : $(OBJ)
	$(CC) $(CFLAGS) $^  -o $@ $(INC)

#%.d : %.c
#	$(CC) $(CFLAGS) -MM $< -o $@ $(INC)

%d:%c
	@$(CC) -MM $(CFLAGS) $< $(INC) > $@.dd;
	@sed -i 's,\($(*F)\)o[ :]*,$(*D)/\1o: ,g'  $@.dd ;
	@sed 's,\($*\)o[ :]*,\1o $@ : ,g' < $@.dd > $@;
#	@echo "\t$(CC) -c -o $*o $< $(INC)" >>$@;
	@$(RM) $@.dd

include $(patsubst %.c, %.d, $(SRC))



