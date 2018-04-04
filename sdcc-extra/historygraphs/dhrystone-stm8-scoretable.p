set output "dhrystone-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9256, 4725 to 9256, 4225
set arrow from 9618, 5038 to 9618, 4538
set arrow from 10233, 10733 to 10233, 10233
plot "dhrystone-stm8-scoretable" using 1:4 title "default", "dhrystone-stm8-scoretable" using 1:2 title "size", "dhrystone-stm8-scoretable" using 1:3 title "speed"

