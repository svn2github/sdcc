set output "stdcbench-stm8-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
trans(x) = x < 135 ? x : x - 70
set yrange [100:145]
set ytics ("100" 100, "110" 110, "120" 120, "200" 130, "210" 140)
set arrow from graph 0, first 125 to graph 1, first 125 nohead lt 500 lw 20 lc bgnd
set label "c90lib module enabled" at 10221, 125 front
set arrow from 9256, 111 to 9256, 106
set label "3.5.0" at 9256, 111
set arrow from 9618, 113 to 9618, 108
set label "3.6.0" at 9618, 113
set arrow from 10233, trans(209) to 10233, trans(204)
set label "3.7.0" at 10233, trans(209)
set arrow from 10582, trans(212) to 10582, trans(207)
set label "3.8.0" at 10582, trans(212)
plot "stdcbench-stm8-scoretable" using 1:(trans($4)) title "default", "stdcbench-stm8-scoretable" using 1:(trans($2)) title "size", "stdcbench-stm8-scoretable" using 1:(trans($3)) title "speed", 125 lt rgb "white" lw 20 notitle

