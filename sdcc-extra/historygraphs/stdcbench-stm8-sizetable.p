set output "stdcbench-stm8-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
trans(x) = x < 6750 ? x : x - 13000
set yrange [6000:9000]
set ytics ("6000" 6000, "6500" 6500, "20000" 7000, "20500" 7500, "21000" 8000, "21500" 8500, "22000" 9000)
set arrow from graph 0, first 6750 to graph 1, first 6750 nohead lt 500 lw 20 lc bgnd
set label "c90lib module enabled" at 10221, 6750 front
set arrow from 9256, 6597 to 9256, 6297 front
set label "3.5.0" at 9256, 6597 front
set arrow from 9618, 6647 to 9618, 6347 front
set label "3.6.0" at 9618, 6647 front
set arrow from 10233, trans(21766) to 10233, trans(21466)
set label "3.7.0" at 10233, trans(21766)
set arrow from 10582, trans(21164) to 10582, trans(20864)
set label "3.8.0" at 10582, trans(21164)
plot "stdcbench-stm8-sizetable" using 1:(trans($4)) title "default", "stdcbench-stm8-sizetable" using 1:(trans($2)) title "size", "stdcbench-stm8-sizetable" using 1:(trans($3)) title "speed", 6750 lt rgb "white" lw 20 notitle

