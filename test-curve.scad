include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

//curve(0,0,0,1,1,HALF,true,false,DOBLO);

x=HALF;

block_curve_down(3,4,x,2,2,HALF,true,DOBLO,cw=1);
doblo_curve_up(3,4,0,2,2,x,false,DOBLO,cw=1);

doblo_curve_up(0,4,0,1,2,HALF,true,DOBLO,cw=2);

block_curve_down(-4.5,4,x,2,2,HALF,true,DOBLO,cw=2);
doblo_curve_up(-5,4,0,3,2,x,false,DOBLO,cw=1);


// Not really finished yet..
doblo_curve_down(2,-3,0,2,2,HALF,true,DOBLO,cw=2);
doblo_curve_down(0,0,0,2,2,HALF,true,DOBLO);
doblo_curve_down(4,0,0,1,2,HALF,true,DOBLO);

union(){
  doblo_curve_down(-3,0,0,1,2,HALF,false,DOBLO);
  nibbles(-3.5,0,HALF,2,2,DOBLO);
  nibbles(-3.5,0,HALF-.7,2,2,DOBLO);
}