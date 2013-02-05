include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

/*
NOTE: Source and license information for these STLs can be found in the file called COPYING in the stls directory
*/

/* hippo 
doblo   (3,   0,   0,   2,   4	,    3,  false, true, DOBLO);
merge_stl ("stls/hippo.stl",3.0,  .93,   -3.3, 20, DOBLO,.93);
*/

/* duck */
doblo   (3,   3,   0,   2,   2	,    3,  false, true, DOBLO);
block(4,5.06,0,.5,.4,5,false,DOBLO);
merge_stl ("stls/rubber_duck_supports.stl",1.24,  .28,   0, 8, DOBLO,2);


/* cat sitting
doblo   (3,   0,   0,   2,   3	,    3,  false, true, DOBLO);
merge_stl ("stls/catStand.stl",3.0,  .40,   -3.3, 20, DOBLO,.9);
*/

/* cat walking
stl_z_offset_mm=10 	;

hh=2.6;
ho=3;
h=9;
x=1.365;
xx=1.38;
y=2.3;
yy=1.3;
w=.25;
ww=.2;
hd=0.3;
translate([9,9,0])rotate([0,0,-45]){
  merge_stl ("stls/bool_simplified.stl",0.38,  0,   5, 2, DOBLO,2);    


  //tail lift
  block   (1.36,   -.5,   2.55,   .12,   .3	,    2, false,DOBLO);

  // head lift
  block (x-.05, y, 0, 0.1, w	, h, false,DOBLO);
  block (x-.025, y, h, 0.05, w	, 0.1, false,DOBLO);


  // tummy lift
  block (xx-.025, yy,ho-hd, 0.05, ww	, hd, false,DOBLO);
  block (xx-.05, yy, ho, .1, ww	, hh, false,DOBLO);
  block (xx-.025, yy,ho+hh, 0.05, ww	, hd, false,DOBLO);
 translate([0,7,0]){
  // tummy lift
  block (xx-.025, yy,ho-hd, 0.05, ww	, hd, false,DOBLO);
  block (xx-.05, yy, ho, .1, ww	, hh, false,DOBLO);
  block (xx-.025, yy,ho+hh, 0.05, ww	, hd, false,DOBLO);
 }
}


doblo   (0,   0,   0,   2,   2	,    3,  false, false, DOBLO);
*/