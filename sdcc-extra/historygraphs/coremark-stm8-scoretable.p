set output "coremark-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
plot "coremark-stm8-scoretable" using 1:4 title "default", "coremark-stm8-scoretable" using 1:2 title "size", "coremark-stm8-scoretable" using 1:3 title "speed"

