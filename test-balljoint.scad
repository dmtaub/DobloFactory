include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;
/*include <vendor/ballsocket/ballsocket.scad>;


doblo   (2,   -2,   0,   2,   1,    3,  true, false, DOBLO);
translate([24,DOBLOWIDTH(DOBLO)*(1-1/4),5]) rotate([0,90,0])rotate([0,0,90])joint(size=5, frontchop=1.2);

translate([-10,0,0]) union(){
  doblo   (-1,   -2,   0,   2,   1,    3,  true, false, DOBLO);
  translate([24,DOBLOWIDTH(DOBLO)*(1-1/4),5]) rotate([0,90,0])ball(size=5);
}



doblo   (2,   2,   0,   2,   2,    3,  true, false, DOBLO);
translate([24,DOBLOWIDTH(DOBLO)*(-1-1/2),5]) rotate([0,90,0])rotate([0,0,90])joint(size=5);

translate([-10,0,0]) union(){
  doblo   (-1,   2,   0,   2,   2,    3,  true, false, DOBLO);
  translate([24,DOBLOWIDTH(DOBLO)*(-1-1/2),5]) rotate([0,90,0])ball(size=5);
}

*/
ball_doblo   (4,   1,   0,   2,   2,size=LUGO);
#ball_doblo   (2,   2,   0,   2,   1,size=DOBLO);
ball_doblo   (2,   4,   0,   1,   1,size=DOBLO);
ball_doblo   (4,   6,   0,   2,   2,size=DOBLO);

