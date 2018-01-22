all: whetstone

whetstone: whetstone.rel portme.rel
	$(SDCC) $(SDCCFLAGS) *.rel -o image.ihx

%.rel: %.c
	$(SDCC) --fverbose-asm -c -DNOSTRUCTASSIGN $(SDCCFLAGS) $<

clean:
	rm -rf *.rel *.map *.lst *.noi *.lk *.lnk *.sym *.asm *.ihx *.o

