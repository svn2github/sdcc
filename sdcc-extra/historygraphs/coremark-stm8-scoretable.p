set output "coremark-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9256, 3.257 to 9256, 2.957
set label "3.5.0" at 9256, 3.257
set arrow from 9618, 3.384 to 9618, 2.984
set label "3.6.0" at 9618, 3.384
set arrow from 10233, 6.324 to 10233, 6.024
set label "3.7.0" at 10233, 6.324
set arrow from 10582, 6.373 to 10582, 6.073
set label "3.8.0" at 10582, 6.373
plot "coremark-stm8-scoretable" using 1:4 title "default", "coremark-stm8-scoretable" using 1:2 title "size", "coremark-stm8-scoretable" using 1:3 title "speed"

