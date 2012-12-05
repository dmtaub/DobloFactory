include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

//hinge_y   (0,  3,  0,   1,  2, 3, true, DOBLO);
//hinge_y  (2,  3,  0,   1,  2, 3, true, DOBLO);

hinge1b(DOBLO,1,1);
hinge1a(DOBLO,3,1);

hinge1b(LUGO,1,-3);
hinge1a(LUGO,3,-3);

pin_prop();