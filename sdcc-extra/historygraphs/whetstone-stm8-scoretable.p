set output "whetstone-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9256, 63.368 to 9256, 60.368
set label "3.5.0" at 9256, 62.368
set arrow from 9618, 63.085 to 9618, 60.085
set label "3.6.0" at 9618, 62.085
set arrow from 10233, 66.881 to 10233, 63.881
set label "3.7.0" at 10233, 66.881
set arrow from 10582, 67.834 to 10582, 64.834
set label "3.8.0" at 10582, 67.834
plot "whetstone-stm8-scoretable" using 1:4 title "default", "whetstone-stm8-scoretable" using 1:2 title "size", "whetstone-stm8-scoretable" using 1:3 title "speed"

