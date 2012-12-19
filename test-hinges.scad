include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

hinge_y   (0,  0,  0,   1,  4, 3, true, DOBLO);
hinge_y  (2,  0,  0,   1,  4, 3, true, DOBLO);


/*
//default settings have a large tolerance 
// and a pin that is a complete cylinder (may need sanding)
// so that it is less likely to break

hinge1a(DOBLO,0,5);
hinge1b(DOBLO,2,5);

*/

hinge1b(DOBLO,2,5,whole_pin=false);
hinge1a(DOBLO,0,5,tolerance=.5);

