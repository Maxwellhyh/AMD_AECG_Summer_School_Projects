set Project     filter2d
set Solution    solution1
set Device      "xc7z020clg400-1"
set Flow        "vivado"
set Clock       10

open_project $Project -reset

set_top filter2d_accel

add_files filter2d.cpp -cflags -I.
add_files filter2d.h -cflags -I. 
add_files -tb src.txt -cflags -I.
add_files -tb dst.txt -cflags -I.
add_files -tb filter2d_test.cpp -cflags -I.

open_solution -flow_target $Flow -reset $Solution
set_part $Device
create_clock -period $Clock

csim_design
csynth_design
cosim_design

exit

