include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;
include <ext/text.scad>;

//hinge2(DOBLO,2,3,0);
//hinge2(DOBLO,2,3,1,4);

//hinge2(3,3,0,20,true,LUGO);
//hinge2(3,3,1,16,false,LUGO);

hinge_y   (0,  0,  0,   1,  4, 3, false, DOBLO);
//translate([0,0,-1])rotate([0,0,90])text(-16,9,FULL*2,NH(DOBLO)/2,"12:12:12",8,DOBLO/4);

hinge_y  (2,  0,  0,   1,  4, 3, false, DOBLO);
//translate([0,0,-1])rotate([0,0,90])text(-16,1,FULL*2,NH(DOBLO)/2,"12/12/12",8,DOBLO/4);


//hinge2   (0,  3,  0,   2,  2, 3, true, LUGO);
//rotate([0,0,180])hinge2   (-6,  -5,  0,   2,  2, 3, true, LUGO);

//hinge2   (20,  3,  0,   4,  4, 3, true, LUGO);
//rotate([0,0,180])hinge2   (-30,  -7,  0,  4,  4, 3, true, LUGO);
