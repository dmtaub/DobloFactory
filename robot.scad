include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;
use <vendor/clip.scad>;


blockType = DOBLO;
bwidth = DOBLOWIDTH(blockType);
bheight = PART_HEIGHT(blockType);

//doblo (0,0,0,2,2,FULL,true,false,blockType);

//body();
//cap();
base();
batpack();
doblo (4,1,-10,1,2,FULL*2+HALF,true,false,blockType);
doblo (-2,1,-10,1,2,FULL*2+HALF,true,false,blockType);

doblo (0,6,-10,3,2,FULL,false,false,blockType);
rounded_block(.5,6,-10+FULL,2,2,HALF,true,DOBLO);


module holes(x=0,y=0,z=0, dist=17,rad=1.6,hei=THIRD, $fs=.5){
  translate([bwidth/2*(x),bwidth*(-y/2-1/2),bheight*(z+hei/2)]){
    translate([bwidth/2,-dist/2,-bheight*2]){ 
      cylinder(h=bheight*hei*2,r=rad);
      translate([0,dist,0])cylinder(h=bheight*hei*2,r=rad);
     }
   }
}


module batpack(x=1,y=1,z=-10,zoff=5.5,yoff=-4.5){
//  doblo(x-5,y,z,2,2,FULL*2+HALF,false,false,DOBLO);

support1 (x,y+.25,z+11.2,1,90,1, DOBLO);
support1 (x+1,y+4-.25,z+11.2,1,270,1, DOBLO);
union(){
  //nibbles (x,y,z+4,2,2,blockType);
  block(x-.5,y,z+FULL*2,2,4,HALF,true,DOBLO);
  doblo(x-1,y,z,3,4,THIRD,false,false,DOBLO);
  translate([bwidth/2*(x+1),bwidth*(y)-75+yoff,bheight*(z)+17+zoff]){
    rotate([90,0,90]){
translate([0,8.25,0]) batteryClip(15,52,3); // was 14.5, 50.5
translate([0,-8.25,0]) batteryClip(15,52,3);
translate([0,8.25,-8.25*2]) rotate([180,0,0])batteryClip(15,52,3);
translate([0,-8.25,-8.25*2]) rotate([180,0,0])batteryClip(15,52,3);
}
}
}
}


// cap
module cap(z=0){
  doblo(0,0,z,3,8, THIRD,false,false,blockType);
  doblo(-2,1,z,7,2, THIRD,false,false,blockType);
  doblo(-2,6,z,7,2, THIRD,false,false,blockType);

}
module body(z = -13){
	doblo(0,0,z,3,8, FULL,true,true,blockType);
}
// base
module base(z=-20){
  doblo(0,0,z,3,8, THIRD,true,false,blockType);
  difference(){ 
    block(-2,1,z,2,2, THIRD,true,blockType);
   holes(-2.5,1,z);
}
  difference(){ 
    block(-2,6,z,2,2, THIRD,false,blockType);
   holes(-2.7,6,z);
}  

difference(){ 
    block(3,1,z,2,2, THIRD,true,blockType);
   holes(3.5,1,z);
}
difference(){ 
    block(3,6,z,2,2, THIRD,false,blockType);
   holes(3.7,6,z);
}

difference(){
  translate([bwidth*3/4,-bwidth/2,z*bheight])
{
   translate([0,bwidth*-3.9,0])
     {
       cylinder(h=18,r=3.5,$fs=1);
       translate([0,0,18])cylinder(h=2,r1=3.5,r2=5,$fs=1);
       translate([0,0,20])cylinder(h=2,r1=5,r2=4,$fs=1);
       
     }
   difference(){plate(THIRD*bheight);block(-1.5,-1,-.5,3,8,HALF,false,DOBLO);}
 }
  rotate([0,0,90])holes(-.5,0.5,z,13);
   rotate([0,0,90])holes(-9.5,0.5,z,13);
}
}


module plate(width) {
	translate([0,0,width/2])
		union(){
   cylinder(r=bwidth,h=width, center=true, $fn=60);
      translate([0,-1.5*bwidth,0])cube([bwidth*2,bwidth*3,width],true);
		translate([0,-3*bwidth,0])cylinder(r=bwidth,h=width, center=true, $fn=60);

	}
}
