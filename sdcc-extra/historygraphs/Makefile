# Important revisions:
# 3.4.0: 8985 (affected by -Werror bug #2280)
# 3.5.0: 9256
# 3.6.0: 9618.
# Broken: <= 9104 (bug #2280), 9112 (whetstone build segfaults), 9379-9402 (SDCC build fails), 9477 (SDCC build fails), 9958 (whetstone build fails)
REVISIONS = 9105 9127 9138 9157 9182 9193 9207 9256 9275 9291 9307 9319 9354 9376 9410 9418 9424 9438 9445 9452 9461 9478 9487 9492 9498 9521 9540 9550 9568 9589 9618 9632 9635 9636 9637 9638 9640 9645 9646 9649 9651 9653 9662 9666 9679 9707 9730 9751 9761 9773 9784 9797 9803 9815 9820 9830 9836 9879 9901 9905 9926 9929 9932 9939 9941 9946 9949 9953 9961 9962 9969 9976 9994 9997 10000 10017 10048 10058 10069 10072 10080 10124 10147 10163 10165 10174 10182 10185 10192 10209
       
BENCHMARKS = whetstone dhrystone coremark

GOALS = size speed default

TARGETS = stm8

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

.PHONY: all clean

# Do not include Coremark (non-free) or score graphs (requires STM8AF hardware) in all target.
all: whetstone-stm8-size.svg dhrystone-stm8-size.svg

clean:
	echo $(BENCHMARKS_SIZES)

whetstone-stm8-size.svg: whetstone-stm8-sizetable whetstone-stm8-sizetable.p
	gnuplot whetstone-stm8-sizetable.p

dhrystone-stm8-size.svg: dhrystone-stm8-sizetable dhrystone-stm8-sizetable.p
	gnuplot dhrystone-stm8-sizetable.p

coremark-stm8-size.svg: coremark-stm8-sizetable coremark-stm8-sizetable.p
	gnuplot coremark-stm8-sizetable.p

whetstone-stm8-score.svg: whetstone-stm8-scoretable whetstone-stm8-scoretable.p
	gnuplot whetstone-stm8-scoretable.p

dhrystone-stm8-score.svg: dhrystone-stm8-scoretable dhrystone-stm8-scoretable.p
	gnuplot dhrystone-stm8-scoretable.p

coremark-stm8-score.svg: coremark-stm8-scoretable coremark-stm8-scoretable.p
	gnuplot coremark-stm8-scoretable.p

whetstone-stm8-sizetable: $(BENCHMARKS_WHETSTONE_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat whetstone-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat whetstone-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat whetstone-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-stm8-sizetable: $(BENCHMARKS_DHRYSTONE_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat dhrystone-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat dhrystone-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat dhrystone-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

coremark-stm8-sizetable: $(BENCHMARKS_COREMARK_SIZES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat coremark-stm8-size-$$r/size`; \
		SIZE_SPEED=`cat coremark-stm8-speed-$$r/size`; \
		SIZE_DEFAULT=`cat coremark-stm8-default-$$r/size `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

whetstone-stm8-scoretable: $(BENCHMARKS_WHETSTONE_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat whetstone-stm8-size-$$r/score`; \
		SIZE_SPEED=`cat whetstone-stm8-speed-$$r/score`; \
		SIZE_DEFAULT=`cat whetstone-stm8-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

dhrystone-stm8-scoretable: $(BENCHMARKS_DHRYSTONE_SCORES)
	echo "#Revision size speed default" > $@
	for r in $(REVISIONS); do \
		SIZE_SIZE=`cat dhrystone-stm8-size-$$r/score`; \
		SIZE_SPEED=`cat dhrystone-stm8-speed-$$r/score`; \
		SIZE_DEFAULT=`cat dhrystone-stm8-default-$$r/score `; \
		echo $$r $$SIZE_SIZE $$SIZE_SPEED $$SIZE_DEFAULT >> $@; \
	done

coremark-stm8-scoretable: $(BENCHMARKS_COREMARK_SCORES)
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
	cd sdcc-$* && ./configure --disable-pic14-port --disable-pic16-port && make -j 3

%: REVISION=$(lastword $(subst -, ,$*))

.SECONDEXPANSION:
$(BENCHMARKS_3000): %/image.ihx: $$(BENCHMARK) sdcc-$$(REVISION)/bin/sdcc
	rm -rf $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION)
	cp -r $(BENCHMARK)-$(TARGET) $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION)
	cd $(BENCHMARK)-$(TARGET)-$(GOAL)-$(REVISION) && make SDCC="../sdcc-$(REVISION)/bin/sdcc" SDCCFLAGS="$(SDCCFLAGS) -I../sdcc-$(REVISION)/device/include -L ../sdcc-$(REVISION)/device/lib/build/$(TARGET)"

$(BENCHMARKS_SIZES): %/size: %/image.ihx
	echo `size $< | tail -n 1 | sed -e "s/ *0[ 	]*\([0-9]*\).*/\1/"`> $@

# The benchmarks are executed on the STM8AF board, and thus cannotbe run in parallel. Also this might require root, so don't target all depend on it.
.NOTPARALLEL: $(BENCHMARKS_SCORES)

$(BENCHMARKS_WHETSTONE_SCORES): %/score: %/image.ihx
	echo "scale=3;" 1000000 / `./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Loops: 10, Iterations: 1, Duration: //" | sed -e "s/ msec.//"` | bc > $@

$(BENCHMARKS_DHRYSTONE_SCORES): %/score: %/image.ihx
	./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Dhrystones per Second: //" > $@

$(BENCHMARKS_COREMARK_SCORES): %/score: %/image.ihx
	echo "scale=3;" 60000 / `./execute_benchmark-stm8 /dev/ttyUSB0 $< | sed -e "s/Total ticks : //"` | bc > $@

