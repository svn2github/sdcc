# Release revisions:
# 3.4.0: 8985 (affected by -Werror bug #2280)
# 3.5.0: 9256
# 3.6.0: 9618
# 3.7.0: 10233
# Broken: 8984-9000, 9104 (bug #2280), 9106-9114 (whetstone build segfaults), 9379-9402-9418 (SDCC build fails), 9477 (SDCC build fails), 9958-9959 (whetstone build fails)
# Build of large-stack-auto lib for mcs51 was enabled in 9521.
REVISIONS_MCS51 = 9521 9540 9550 9568 9581 9589 9596 9601 9602 9603 9604 9618 9624 9632 9635 9636 9637 9638 9640 9645 9646 9649 9651 9653 9654 9659 9662 9664 9665 9666 9679 9707 9730 9740 9747 9751 9761 9764 9765 9766 9767 9773 9784 9790 9791 9793 9797 9803 9807 9808 9815 9818 9819 9820 9830 9832 9836 9879 9901 9904 9905 9919 9926 9928 9929 9930 9932 9934 9939 9941 9946 9949 9953 9955 9956 9961 9962 9964 9965 9969 9976 9984 9994 9997 10000 10017 10048 10058 10069 10072 10077 10080 10108 10124 10147 10163 10165 10167 10174 10181 10182 10185 10192 10209 10211 10233 10237 10240 10270 10279 10280 10282 10287 10300 10305 10310 10314 10340 10345 10349 10350 10366 10367 10374 10408 10430 10437 10439 10440 10441 10442 10448 10461 10495 10510 10540 10558
REVISIONS = 9105 9120 9124 9127 9138 9157 9171 9175 9182 9187 9191 9193 9207 9208 9218 9233 9256 9275 9291 9307 9311 9319 9354 9376 9424 9438 9442 9445 9452 9461 9478 9487 9492 9493 9498 $(REVISIONS_MCS51)

       
BENCHMARKS = whetstone dhrystone coremark

GOALS = size speed default

TARGETS = stm8 mcs51

COMPILERS = $(foreach revision, $(REVISIONS), sdcc-$(revision)/bin/sdcc)

BENCHMARKS_WHETSTONE = $(foreach target, $(TARGETS), $(foreach goal, $(GOALS), $(foreach revision, $(REVISIONS), whetstone-$(target)-$(goal)-$(revision)/image.ihx)))
$(BENCHMARKS_WHETSTONE): BENCHMARK = whetstone
BENCHMARKS_DHRYSTONE = $(foreach target, $(TARGETS), $(foreach goal, $(GOALS), $(foreach revision, $(REVISIONS), dhrystone-$(target)-$(goal)-$(revision)/image.ihx)))
$(BENCHMARKS_DHRYSTONE): BENCHMARK = dhrystone
BENCHMARKS_COREMARK = $(foreach target, $(TARGETS), $(foreach goal, $(GOALS), $(foreach revision, $(REVISIONS), coremark-$(target)-$(goal)-$(revision)/image.ihx)))
$(BENCHMARKS_COREMARK): BENCHMARK = coremark

BENCHMARKS_STM8 = $(foreach benchmark, $(BENCHMARKS), $(foreach goal, $(GOALS), $(foreach revision, $(REVISIONS), $(benchmark)-stm8-$(goal)-$(revision)/image.ihx)))
$(BENCHMARKS_STM8): TARGET = stm8
$(BENCHMARKS_STM8): SDCCFLAGS += -mstm8
BENCHMARKS_MCS51 = $(foreach benchmark, $(BENCHMARKS), $(foreach goal, $(GOALS), $(foreach revision, $(REVISIONS_MCS51), $(benchmark)-mcs51-$(goal)-$(revision)/image.ihx)))
$(BENCHMARKS_MCS51): TARGET = mcs51
$(BENCHMARKS_MCS51): SDCCFLAGS += -mmcs51 --model-large --stack-auto

BENCHMARKS_DEFAULT = $(foreach benchmark, $(BENCHMARKS), $(foreach target, $(TARGETS), $(foreach revision, $(REVISIONS), $(benchmark)-$(target)-default-$(revision)/image.ihx)))
$(BENCHMARKS_DEFAULT): GOAL = default
BENCHMARKS_SIZE = $(foreach benchmark, $(BENCHMARKS), $(foreach target, $(TARGETS), $(foreach revision, $(REVISIONS), $(benchmark)-$(target)-size-$(revision)/image.ihx)))
$(BENCHMARKS_SIZE): GOAL = size
$(BENCHMARKS_SIZE): SDCCFLAGS += --opt-code-size
BENCHMARKS_SPEED = $(foreach benchmark, $(BENCHMARKS), $(foreach target, $(TARGETS), $(foreach revision, $(REVISIONS), $(benchmark)-$(target)-speed-$(revision)/image.ihx)))
$(BENCHMARKS_SPEED): GOAL = speed
$(BENCHMARKS_SPEED): SDCCFLAGS += --opt-code-speed

# Default setting for --max-allocs-per-node (currently 3000)
BENCHMARKS_3000 = $(BENCHMARKS_WHETSTONE) $(BENCHMARKS_DHRYSTONE) $(BENCHMARKS_COREMARK)

BENCHMARKS_WHETSTONE_SIZES = $(BENCHMARKS_WHETSTONE:image.ihx=size)
BENCHMARKS_DHRYSTONE_SIZES = $(BENCHMARKS_DHRYSTONE:image.ihx=size)
BENCHMARKS_COREMARK_SIZES = $(BENCHMARKS_COREMARK:image.ihx=size)
BENCHMARKS_SIZES = $(BENCHMARKS_3000:image.ihx=size)
BENCHMARKS_WHETSTONE_SCORES = $(BENCHMARKS_WHETSTONE:image.ihx=score)
BENCHMARKS_DHRYSTONE_SCORES = $(BENCHMARKS_DHRYSTONE:image.ihx=score)
BENCHMARKS_COREMARK_SCORES = $(BENCHMARKS_COREMARK:image.ihx=score)
BENCHMARKS_SCORES = $(BENCHMARKS_3000:image.ihx=score)

BENCHMARKS_WHETSTONE_STM8_SIZES = $(patsubst %image.ihx, %size, $(filter $(BENCHMARKS_WHETSTONE), $(BENCHMARKS_STM8)))
BENCHMARKS_WHETSTONE_MCS51_SIZES = $(patsubst %image.ihx, %size, $(filter $(BENCHMARKS_WHETSTONE), $(BENCHMARKS_MCS51)))
BENCHMARKS_DHRYSTONE_STM8_SIZES = $(patsubst %image.ihx, %size, $(filter $(BENCHMARKS_DHRYSTONE), $(BENCHMARKS_STM8)))
BENCHMARKS_DHRYSTONE_MCS51_SIZES = $(patsubst %image.ihx, %size, $(filter $(BENCHMARKS_DHRYSTONE), $(BENCHMARKS_MCS51)))
BENCHMARKS_COREMARK_STM8_SIZES = $(patsubst %image.ihx, %size, $(filter $(BENCHMARKS_COREMARK), $(BENCHMARKS_STM8)))
BENCHMARKS_WHETSTONE_STM8_SCORES = $(patsubst %image.ihx, %score, $(filter $(BENCHMARKS_WHETSTONE), $(BENCHMARKS_STM8)))
BENCHMARKS_WHETSTONE_MCS51_SCORES = $(patsubst %image.ihx, %score, $(filter $(BENCHMARKS_WHETSTONE), $(BENCHMARKS_MCS51)))
BENCHMARKS_DHRYSTONE_STM8_SCORES = $(patsubst %image.ihx, %score, $(filter $(BENCHMARKS_DHRYSTONE), $(BENCHMARKS_STM8)))
BENCHMARKS_DHRYSTONE_MCS51_SCORES = $(patsubst %image.ihx, %score, $(filter $(BENCHMARKS_DHRYSTONE), $(BENCHMARKS_MCS51)))
BENCHMARKS_COREMARK_STM8_SCORES = $(patsubst %image.ihx, %score, $(filter $(BENCHMARKS_COREMARK), $(BENCHMARKS_STM8)))

.PHONY: all clean

# Do not include Coremark (non-free) or score graphs (requires STM8AF hardware) in all target.
all: whetstone-stm8-size.svg whetstone-mcs51-size.svg dhrystone-stm8-size.svg dhrystone-mcs51-size.svg

clean:
	echo $(BENCHMARKS_SIZES)

# coremark_v1.0.tgz is non-free, needs to be downloaded from https://www.eembc.org/coremark/
coremark-stm8: coremark_v1.0.tgz
	rm -rf coremark_v1.0
	tar -xzf coremark_v1.0.tgz
	cp -r coremark_v1.0 coremark-stm8
	cd coremark-stm8 && cp barebones/core_portme.? ./ && cat ../coremark-1.0.patch | patch -p1
	cp Makefile.coremark coremark-stm8/Makefile

whetstone-stm8-size.svg: whetstone-stm8-sizetable whetstone-stm8-sizetable.p
	gnuplot whetstone-stm8-sizetable.p

whetstone-mcs51-size.svg: whetstone-mcs51-sizetable whetstone-mcs51-sizetable.p
	gnuplot whetstone-mcs51-sizetable.p

dhrystone-stm8-size.svg: dhrystone-stm8-sizetable dhrystone-stm8-sizetable.p
	gnuplot dhrystone-stm8-sizetable.p

dhrystone-mcs51-size.svg: dhrystone-mcs51-sizetable dhrystone-mcs51-sizetable.p
	gnuplot dhrystone-mcs51-sizetable.p

coremark-stm8-size.svg: coremark-stm8-sizetable coremark-stm8-sizetable.p
	gnuplot coremark-stm8-sizetable.p

whetstone-stm8-score.svg: whetstone-stm8-scoretable whetstone-stm8-scoretable.p
	gnuplot whetstone-stm8-scoretable.p

whetstone-mcs51-score.svg: whetstone-mcs51-scoretable whetstone-mcs51-scoretable.p
	gnuplot whetstone-mcs51-scoretable.p

dhrystone-stm8-score.svg: dhrystone-stm8-scoretable dhrystone-stm8-scoretable.p
	gnuplot dhrystone-stm8-scoretable.p

dhrystone-mcs51-score.svg: dhrystone-mcs51-scoretable dhrystone-mcs51-scoretable.p
	gnuplot dhrystone-mcs51-scoretable.p

coremark-stm8-score.svg: coremark-stm8-scoretable coremark-stm8-scoretable.p
	gnuplot coremark-stm8-scoretable.p

whetstone-stm8-sizetable: $(BENCHMARKS_WHETSTONE_STM8_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat whetstone-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat whetstone-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat whetstone-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

whetstone-mcs51-sizetable: $(BENCHMARKS_WHETSTONE_MCS51_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS_MCS51); do \
		SIZE_SIZE=`cat whetstone-mcs51-size-$$r/size`; \
		SIZE_SPEED=`cat whetstone-mcs51-speed-$$r/size`; \
		SIZE_DEFAULT=`cat whetstone-mcs51-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-stm8-sizetable: $(BENCHMARKS_DHRYSTONE_STM8_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat dhrystone-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat dhrystone-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat dhrystone-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-mcs51-sizetable: $(BENCHMARKS_DHRYSTONE_MCS51_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS_MCS51); do \
		SIZE_SIZE=`cat dhrystone-mcs51-size-$$r/size`; \
		SIZE_SPEED=`cat dhrystone-mcs51-speed-$$r/size`; \
		SIZE_DEFAULT=`cat dhrystone-mcs51-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

coremark-stm8-sizetable: $(BENCHMARKS_COREMARK_STM8_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat coremark-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat coremark-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat coremark-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

whetstone-stm8-scoretable: $(BENCHMARKS_WHETSTONE_STM8_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat whetstone-stm8-size-$$r/score`; \
		SIZE_SPEED=`cat whetstone-stm8-speed-$$r/score`; \
		SIZE_DEFAULT=`cat whetstone-stm8-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

whetstone-mcs51-scoretable: $(BENCHMARKS_WHETSTONE_MCS51_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS_MCS51); do \
		SIZE_SIZE=`cat whetstone-mcs51-size-$$r/score`; \
		SIZE_SPEED=`cat whetstone-mcs51-speed-$$r/score`; \
		SIZE_DEFAULT=`cat whetstone-mcs51-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-stm8-scoretable: $(BENCHMARKS_DHRYSTONE_STM8_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat dhrystone-stm8-size-$$r/score`; \
		SIZE_SPEED=`cat dhrystone-stm8-speed-$$r/score`; \
		SIZE_DEFAULT=`cat dhrystone-stm8-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-mcs51-scoretable: $(BENCHMARKS_DHRYSTONE_MCS51_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS_MCS51); do \
		SIZE_SIZE=`cat dhrystone-mcs51-size-$$r/score`; \
		SIZE_SPEED=`cat dhrystone-mcs51-speed-$$r/score`; \
		SIZE_DEFAULT=`cat dhrystone-mcs51-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

coremark-stm8-scoretable: $(BENCHMARKS_COREMARK_STM8_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat coremark-stm8-size-$$r/score`; \
		SIZE_SPEED=`cat coremark-stm8-speed-$$r/score`; \
		SIZE_DEFAULT=`cat coremark-stm8-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

$(COMPILERS): sdcc-%/bin/sdcc:
	rm -rf sdcc-$*
	svn co -r $* https://svn.code.sf.net/p/sdcc/code/trunk/sdcc sdcc-$*
	cd sdcc-$* && ./configure --disable-pic14-port --disable-pic16-port && make -j 3 && rm -rf device/non-free support .svn && rm src/*.o src/*/*.o src/*/*.a

%: REVISION=$(lastword $(subst -, ,$*))

.SECONDEXPANSION:
$(BENCHMARKS_3000): %/image.ihx: $$(BENCHMARK)-$$(TARGET) sdcc-$$(REVISION)/bin/sdcc
	rm -rf $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION)
	cp -r $(BENCHMARK)-$(TARGET) $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION)
	if [ "$(TARGET)" = "mcs51" ] ; \
	then \
		cd $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION) && make SDCC="../sdcc-$(REVISION)/bin/sdcc" SDCCFLAGS="$(SDCCFLAGS) -I../sdcc-$(REVISION)/device/include -I../sdcc-$(REVISION)/device/include/$(TARGET) -L ../sdcc-$(REVISION)/device/lib/build/large-stack-auto"; \
	else \
		cd $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION) && make SDCC="../sdcc-$(REVISION)/bin/sdcc" SDCCFLAGS="$(SDCCFLAGS) -I../sdcc-$(REVISION)/device/include -L ../sdcc-$(REVISION)/device/lib/build/$(TARGET)"; \
	fi

$(BENCHMARKS_SIZES): %/size: %/image.ihx
	echo `size $< | tail -n 1 | sed -e "s/ *0[ 	]*\([0-9]*\).*/\1/"`> $@

# The benchmarks are executed on the STM8AF board, and thus cannotbe run in parallel. Also this might require root, so don't target all depend on it.
.NOTPARALLEL: $(BENCHMARKS_SCORES)

$(BENCHMARKS_WHETSTONE_STM8_SCORES): %/score: %/image.ihx
	echo "scale=3;" 1000000 / `./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Loops: 10, Iterations: 1, Duration: //" | sed -e "s/ msec.//"` | bc > $@

$(BENCHMARKS_WHETSTONE_MCS51_SCORES): %/score: %/image.ihx
	echo "scale=3;" 1000000 / `./execute_benchmark-mcs51 /dev/ttyUSB1 $< | sed -e "s/Loops: 10, Iterations: 1, Duration: //" | sed -e "s/ msec.//"` | bc > $@

$(BENCHMARKS_DHRYSTONE_STM8_SCORES): %/score: %/image.ihx
	./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Dhrystones per Second: //" > $@

$(BENCHMARKS_DHRYSTONE_MCS51_SCORES): %/score: %/image.ihx
	./execute_benchmark-mcs51 /dev/ttyUSB1 $< | sed -e "s/Dhrystones per Second: //" > $@

$(BENCHMARKS_COREMARK_STM8_SCORES): %/score: %/image.ihx
	echo "scale=3;" 60000 / `./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Total ticks : //"` | bc > $@

