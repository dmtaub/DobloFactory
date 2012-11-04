include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

LEGO_DIV = false;
*doblo   (0,   6,   0,   2,   2,    2,  true, false, LUGO);
*doblo   (2,   0,   0,   2,   2,    3,  true, false, DOBLO);
*doblo   (2,   3,   0,   1,   1,    3,  true, false, DOBLO);
*doblo   (0,   3,   0,   4,   1,    3,  false, false, LUGO);

include <ext/hinge.scad>;

//hinge1a(LUGO,-1,-1);
//hinge1b(6,1,-1);
//hinge1a(DOBLO,-1,-3);
//hinge1b(DOBLO,1,-3);


//hinge1a(DOBLO,1,1);
//hinge1a(MINI,1,1);


//hinge2(DOBLO,2,3,0);
//hinge2(DOBLO,2,3,1,4);

//hinge2(3,3,0,20,true,LUGO);
//hinge2(3,3,1,16,false,LUGO);

hinge2   (0,  3,  2,   2,  2, 6,sep=1, size=LUGO);

//hinge2   (0,  6,  2,   2,  4, 3,sep=1, size=LUGO);


