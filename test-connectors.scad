include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;


// for odd-length hinges, must specify one of each 'type' AKA handedness
hinge_y   (4,  6,  0,   2,  3, HALF, true, DOBLO,type = 0);
hinge_y   (4,  2.5,  0,   2,  3, HALF, true, DOBLO,type = 1);

// even-length hinges are symmetrical 
hinge_y   (0,  5,  0,   2,  4, HALF, true, DOBLO);
hinge_y   (0,  0,  0,   2,  4, HALF, true, DOBLO);

hinge_z_pin (0.5,  -4.5,  0,   2,  1, FULL, true, DOBLO,slit=false);
hinge_z_hole (0.5,  -2.3,  0,   2,  1, FULL, true, DOBLO); //tolerance = .75 if using slit for a tight fit

// propeller for duplo plane
translate([50,15,0])pin_prop();


socket_doblo   (4,   0,   0,   2,   2,diamonds=true,size=DOBLO);
ball_doblo   (4,   -4,   0,   2,   2,diamonds=true,size=DOBLO);
