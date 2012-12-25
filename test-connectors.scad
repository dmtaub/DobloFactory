include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;


// for odd-length hinges, must specify one of each 'type' AKA handedness
hinge_y   (4,  4,  0,   2,  3, HALF, true, DOBLO,type = 0);
hinge_y   (4,  0,  0,   2,  3, HALF, true, DOBLO,type = 1);

// even-length hinges are symmetrical 
hinge_y   (0,  5,  0,   2,  4, HALF, true, DOBLO);
hinge_y   (0,  0,  0,   2,  4, HALF, true, DOBLO);

hinge_z_pin (1,  -4,  0,   2,  1, FULL, true, DOBLO,slit=false);
hinge_z_hole (1,  -2.5,  0,   2,  1, FULL, true, DOBLO);

hinge_z_hole (-2,  -.5,  0,   1,  2, FULL, true, DOBLO);
hinge_z_pin (-4,  -.5,  0,   1,  2, FULL, true, DOBLO);

//hinge1b(DOBLO,1,-4);
//hinge1a(DOBLO,3,-4);

//hinge1b(LUGO,1,-3);
//hinge1a(LUGO,3,-3);

// propeller for duplo plane
translate([70,20,0])pin_prop();


socket_doblo   (4,   8,   0,   2,   2,diamonds=true,size=DOBLO);
ball_doblo   (5,   -4,   0,   2,   2,diamonds=true,size=DOBLO);
