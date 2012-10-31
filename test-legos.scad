	include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

LEGO_DIV = false;
doblo   (0,   0,   0,   2,   2,    4/3,  true, false, LUGO);
*doblo   (2,   0,   0,   2,   2,    2,  true, false, DOBLO);
doblo   (2,   3,   0,   1,   1,    2,  true, false, DOBLO);
*doblo   (0,   3,   0,   2,   1,    4,  true, false, LUGO);

x=9;
y=-47;

difference(){
union()
{
doblo   (0,   6,   0,   1,   2,    4,  true, false, LUGO);
translate([x,y,0])
{

    cylinder(3/2*PART_HEIGHT(DOBLO),3.5,3.5,$fs=.001);
}
}

    translate([x,y,-4])
    {
      cylinder(3*PART_HEIGHT(DOBLO),2.5,2.5,$fs=.001);
    }
}