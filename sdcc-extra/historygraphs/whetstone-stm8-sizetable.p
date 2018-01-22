set output "whetstone-stm8-size.svg"
set terminal svg size 640,480
set style data lines
plot "whetstone-stm8-sizetable" using 1:4 title "default", "whetstone-stm8-sizetable" using 1:2 title "size", "whetstone-stm8-sizetable" using 1:3 title "speed"

