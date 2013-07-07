include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;


module gap(x,y){

  top = PART_HEIGHT(DOBLO)*HALF;
  end = PART_WIDTH(DOBLO)*y;
  ang = atan(top/end);

difference(){
 union(){ 
  angle_block(0,0,0,x,y,HALF,false,DOBLO);
  block(0,-y,0,x,2*y,1,false,DOBLO);
  }
 rotate([ang,0,0])block(-.5,-y-.05,1-.15/y,x+1,y,HALF,false,DOBLO);
}
angle_block(0,-y,0,x,y,HALF,true,DOBLO);

}



translate([10,0,0])gap(2,4);

translate([50,0,0])gap(2,2);

angle_doblo(-3,0,0,0,2,2,HALF,true,DOBLO);
angle_doblo(-3,-3,0,0,2,2,HALF,true,DOBLO);

angle_doblo(-.7,-4,0,0,4,1,HALF,true,DOBLO);
angle_doblo(-.7,1,0,0,4,1,HALF,true,DOBLO);