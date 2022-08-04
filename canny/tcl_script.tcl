set Project     canny
set Solution    solution1
set Device      "xc7z020clg400-1"
set Flow        "vivado"
set Clock       10

open_project $Project -reset

set_top canny

add_files canny.cpp -cflags -I.
add_files canny.hpp -cflags -I. 
add_files -tb src.txt -cflags -I.
add_files -tb dst.txt -cflags -I.
add_files -tb canny_test.cpp -cflags -I.

open_solution -flow_target $Flow -reset $Solution
set_part $Device
create_clock -period $Clock

csim_design
csynth_design
cosim_design

exit
