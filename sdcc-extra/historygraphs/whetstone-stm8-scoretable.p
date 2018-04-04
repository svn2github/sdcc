set output "whetstone-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9256, 60.868 to 9256, 60.368
set arrow from 9618, 60.585 to 9618, 60.085
set arrow from 10233, 64.381 to 10233, 63.881
plot "whetstone-stm8-scoretable" using 1:4 title "default", "whetstone-stm8-scoretable" using 1:2 title "size", "whetstone-stm8-scoretable" using 1:3 title "speed"

