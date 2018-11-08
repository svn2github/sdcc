set output "coremark-stm8-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9256, 16246 to 9256, 16046
set label "3.5.0" at 9256, 16246
set arrow from 9618, 16316 to 9618, 16116
set label "3.6.0" at 9618, 16316
set arrow from 10233, 15145 to 10233, 14945
set label "3.7.0" at 10233, 15145
set arrow from 10582, 14698 to 10582, 14498
set label "3.8.0" at 10582, 14698
plot "coremark-stm8-sizetable" using 1:4 title "default", "coremark-stm8-sizetable" using 1:2 title "size", "coremark-stm8-sizetable" using 1:3 title "speed"

