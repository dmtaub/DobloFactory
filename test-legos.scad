include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

// for odd-length hinges, must specify one of each 'type' AKA handedness
hinge_y   (4,  4,  0,   2,  3, HALF, true, DOBLO,type = 0);
hinge_y   (4,  0,  0,   2,  3, HALF, true, DOBLO,type = 1);

// even-length hinges are symmetrical 
hinge_y   (0,  5,  0,   2,  4, HALF, true, DOBLO);
hinge_y   (0,  0,  0,   2,  4, HALF, true, DOBLO);



/*
LEGO_DIV = false;
*doblo   (0,   6,   0,   2,   2,    2,  true, false, LUGO);
*doblo   (2,   0,   0,   2,   2,    3,  true, false, DOBLO);
*doblo   (2,   3,   0,   1,   1,    3,  true, false, DOBLO);
*doblo   (0,   3,   0,   4,   1,    3,  false, false, LUGO);

//hinge2(DOBLO,2,3,0);
//hinge2(DOBLO,2,3,1,4);

//hinge2(3,3,0,20,true,LUGO);
//hinge2(3,3,1,16,false,LUGO);

//hinge_y   (0,  3,  0,   1,  2, 3, true, DOBLO);
//hinge_y  (2,  3,  0,   1,  2, 3, true, DOBLO);

//hinge2   (0,  3,  0,   2,  2, 3, true, LUGO);
//rotate([0,0,180])hinge2   (-6,  -5,  0,   2,  2, 3, true, LUGO);

//hinge2   (20,  3,  0,   4,  4, 3, true, LUGO);
//rotate([0,0,180])hinge2   (-30,  -7,  0,  4,  4, 3, true, LUGO);

*difference(){
hinge1b(DOBLO,1,1);
#hinge1a(DOBLO,0,1);
}
//hinge1b(LUGO,1,1);
//hinge1a(LUGO,3,-3);

pin_prop();
translate([70,0,0]) pin_prop();


socket_doblo   (5,   4,   0,   3,   2,diamonds=true,size=DOBLO);
ball_doblo   (0,   4,   0,   3,   2,diamonds=true,size=DOBLO);

ball_doblo   (1,   7,   0,   6,   2,diamonds=true,size=DOBLO);
socket_doblo   (1,   7,   0,   6,   2,diamonds=true,size=DOBLO);

ball_doblo   (1,   1,   0,   2,   2,size=DOBLO);
socket_doblo   (1,   1,   0,   2,   2,size=DOBLO);

ball_doblo   (5,   1,   0,   2,   2,size=DOBLO);
socket_doblo   (5,   1,   0,   2,   2,size=DOBLO);

//ball_doblo   (9,   1,   0,   2,   2,size=DOBLO);

//socket_doblo   (9,   4,   0,   2,   2,6,size=DOBLO); 

doblo   (-5.5,   7,   0,   2,   2,    2,  true, false, DOBLO);
doblo   (-5.5,   4.5,   0,   2,   2,    2,  true, false, DOBLO);
doblo   (-5.5,   0,   0,   2,   4,    2,  true, false, DOBLO);
*/
