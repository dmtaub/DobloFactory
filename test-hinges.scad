include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

// minimum dimension for hinge side is 2

hinge_y   (0,  0,  0,   1,  4, 3, true, DOBLO);
hinge_y  (2,  0,  0,   1,  4, 3, true, DOBLO);


//default settings have a large tolerance 
// and a pin that is a complete cylinder (may need sanding)
// so that it is less likely to break

hinge_z_hole (0,5,  0,   4,  2, HALF, true, DOBLO);
hinge_z_pin (0,8,  0,   4,  2, HALF, true, DOBLO,slit=false);
