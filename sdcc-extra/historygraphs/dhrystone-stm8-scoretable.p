set output "dhrystone-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
plot "dhrystone-stm8-scoretable" using 1:4 title "default", "dhrystone-stm8-scoretable" using 1:2 title "size", "dhrystone-stm8-scoretable" using 1:3 title "speed"

