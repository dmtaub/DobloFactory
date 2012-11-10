include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <vendor/ballsocket/ballsocket.scad>;
translate([0,0,5])union(){
  rotate([0,90,0])ball(size=5);
  translate([10,0,0])rotate([0,90,0])rotate([0,0,90])joint(size=5);
}