set Project     dft
set Solution    solution1
set Device      "xc7z020clg400-1"
set Flow        "vivado"
set Clock       10

open_project $Project -reset

set_top dft

add_files dft.cpp -cflags -I.
add_files dft.h -cflags -I. 
add_files coefficients1024.h -cflags -I. 
add_files -tb out.gold.dat -cflags -I.
add_files -tb dft_test.cpp -cflags -I.

open_solution -flow_target $Flow -reset $Solution
set_part $Device
create_clock -period $Clock

csim_design
csynth_design
cosim_design

exit

