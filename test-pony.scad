include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <vendor/ponykit/ponykit.scad>;

// completely for fun test using vendor/ponykit


difference(){
  scale(1.9)pony(mane=1,horn=-1,tail=1);
  block(-1.5,-2,-1,3,4,HALF,false,DOBLO);
}

nibbles(-.5,-1,13,1,1,DOBLO);
nibbles(-.5,-1,13.5,1,1,DOBLO);
doblo(-1,-2,-.99,2,4,HALF,false,true,DOBLO);

translate([50,0,0]){
  difference(){
    scale(1.9)pony(mane=-1,horn=0);
    block(-1.5,-2,-1,3,4,HALF,false,DOBLO);
  }

  nibbles(-.5,-1,13,1,1,DOBLO);
  nibbles(-.5,-1,13.5,1,1,DOBLO);
  doblo(-1,-1.6,-.99,2,1,HALF,false,true,DOBLO);
  doblo(-1,.4,-.99,2,1,HALF,false,true,DOBLO);

}