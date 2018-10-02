set output "dhrystone-mcs51-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9618, 6070 to 9618, 6060
set label "3.6.0" at 9618, 6070
set arrow from 10233, 6073 to 10233, 6063
set label "3.7.0" at 10233, 6073
set arrow from 10582, 5983 to 10582, 5973
set label "3.8.0" at 10582, 5983
plot "dhrystone-mcs51-scoretable" using 1:4 title "default", "dhrystone-mcs51-scoretable" using 1:2 title "size", "dhrystone-mcs51-scoretable" using 1:3 title "speed"

