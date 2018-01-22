set output "coremark-stm8-size.svg"
set terminal svg size 640,480
set style data lines
plot "coremark-stm8-sizetable" using 1:4 title "default", "coremark-stm8-sizetable" using 1:2 title "size", "coremark-stm8-sizetable" using 1:3 title "speed"

