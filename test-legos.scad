	include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

LEGO_DIV = false;
*doblo   (0,   6,   0,   2,   2,    2,  true, false, LUGO);
*doblo   (2,   0,   0,   2,   2,    3,  true, false, DOBLO);
*doblo   (2,   3,   0,   1,   1,    3,  true, false, DOBLO);
*doblo   (0,   3,   0,   4,   1,    3,  false, false, LUGO);

hinge1a(LUGO,-1,-1);
hinge1b(LUGO,1,-1);
//hinge1a(DOBLO,1,1);
//hinge1a(MINI,1,1);


module hinge1a(size,offx=0,offy=0){
  up = 6;
  BLOCKHEIGHT = up/6*DOBLOHEIGHT(size)/(2*size);
  x=PART_WIDTH(size)+PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)+INSET_WIDTH(size)/2; //w2.6
  RO=NB_BOTTOM_RADIUS(size); //w3.5
  RII = RO-DOBLOWALL(size)/4; //w3.2
  echo([RI,RO, RII]);

  difference(){
    union()
    {
      doblo   (offx,   offy,   0,   1,   2,    up,  true, false, size);
      translate([x,y,0])
      {
        difference(){
          cylinder(9/7*BLOCKHEIGHT,RO,RO,$fs=.001);
          translate([w,w-y,0]) block (-.5,offy,0,.5,.5,2,false,size);
        }
      }
    }
    union()
    {   
      translate([x,y,-DOBLOWIDTH(size)/2])
      {
        cylinder(3*BLOCKHEIGHT,RI,RI,$fs=.001);
      }
      translate([x,y,9/7*BLOCKHEIGHT])
      {
        cylinder(2*BLOCKHEIGHT,RII,RII,$fs=.001);
      }
    }
  }
}


module hinge1b(size,offx=0,offy=0){
  up = 6;
  BLOCKHEIGHT = up/6*DOBLOHEIGHT(size)/(2*size);
  x=PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)/2+INSET_WIDTH(size)/2; //w2.6
  RO=NB_RADIUS(size); 
  RII = NB_BOTTOM_RADIUS(size);
  echo([RI,RO, RII]);

    union()
    {
      difference(){
        doblo   (offx,   offy,   0,   1,   2,    up,  true, false, size);
        translate([x,y,-BLOCKHEIGHT/7]) cylinder(10/7*BLOCKHEIGHT,RII,RII,$fs=.001);

      }
      translate([x,y,0])
      {  union(){
          difference(){
          cylinder(9/7*BLOCKHEIGHT,RO,RO,$fs=.001);
          //#translate([w,w-y,0]) block (-w/4,offy,0,.5,.5,2,false,size);
	      translate([0,0,-DOBLOWIDTH(size)/2])
    		  {
        		cylinder(3*BLOCKHEIGHT,RI,RI,$fs=.001);
      			}
      	  }
        translate([0,0,9/7*BLOCKHEIGHT])
        {
          cylinder(5/7*BLOCKHEIGHT,RII,RII,$fs=.001);
        }
      }

      }


    }

}

