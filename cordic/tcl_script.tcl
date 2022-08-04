set Project     cordiccart2pol
set Solution    solution1
set Device      "xc7z020clg400-1"
set Flow        "vivado"
set Clock       10

open_project $Project -reset

set_top cordiccart2pol

add_files cordiccart2pol.cpp -cflags -I.
add_files cordiccart2pol.h -cflags -I. 
add_files -tb cordiccart2pol_test.cpp -cflags -I.

open_solution -flow_target $Flow -reset $Solution
set_part $Device
create_clock -period $Clock

csim_design
csynth_design
cosim_design

exit
