	include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

LEGO_DIV = false;
doblo   (0,   0,   0,   2,   2,    2,  true, false, LUGO);
*doblo   (2,   0,   0,   2,   2,    3,  true, false, DOBLO);
*doblo   (2,   3,   0,   1,   1,    3,  true, false, DOBLO);
*doblo   (0,   3,   0,   2,   1,    6,  true, false, LUGO);

x=8;
y=-47;

difference(){
union()
{
doblo   (0,   6,   0,   1,   2,    6,  true, false, LUGO);
translate([x,y,0])
{

    cylinder(9/7*DOBLOHEIGHT(LUGO),3.5,3.5,$fs=.001);
}
}

    union()
  {   
    translate([x,y,-4])
    {
      cylinder(3*DOBLOHEIGHT(LUGO),2.6,2.6,$fs=.001);
    }
  translate([x,y,6])
  {
    cylinder(5/7*DOBLOHEIGHT(LUGO),3.2,3.2,$fs=.001);
  }
}
  }
}