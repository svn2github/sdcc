set output "whetstone-mcs51-size.svg"
set terminal svg size 640,480
set style data lines
plot "whetstone-mcs51-sizetable" using 1:4 title "default", "whetstone-mcs51-sizetable" using 1:2 title "size", "whetstone-mcs51-sizetable" using 1:3 title "speed"

