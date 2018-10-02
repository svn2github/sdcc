set output "dhrystone-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9256, 4825 to 9256, 4225
set label "3.5.0" at 9256, 4825
set arrow from 9618, 5138 to 9618, 4538
set label "3.6.0" at 9618, 5138
set arrow from 10233, 10833 to 10233, 10233
set label "3.7.0" at 10233, 10833
set arrow from 10582, 11617 to 10582, 10817
set label "3.8.0" at 10582, 11617
plot "dhrystone-stm8-scoretable" using 1:4 title "default", "dhrystone-stm8-scoretable" using 1:2 title "size", "dhrystone-stm8-scoretable" using 1:3 title "speed"

