include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <vendor/ballsocket/ballsocket.scad>;


doblo   (2,   0,   0,   2,   1,    3,  true, false, DOBLO);
translate([22.22,-DOBLOWIDTH(DOBLO)/4,5]) rotate([0,90,0])rotate([0,0,90])joint(size=5);

translate([-10,0,0]) union(){
  doblo   (-1,   0,   0,   2,   1,    3,  true, false, DOBLO);
  translate([22.22,-DOBLOWIDTH(DOBLO)/4,5]) rotate([0,90,0])ball(size=5);
}