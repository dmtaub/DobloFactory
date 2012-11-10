include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <vendor/ballsocket/ballsocket.scad>;

rotate([0,90,0])ball();
rotate([0,90,0])rotate([0,0,90])joint();
