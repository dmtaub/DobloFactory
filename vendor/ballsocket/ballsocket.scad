// Based on ball joint in SCAD by Erik de Bruijn, modified by juniortan
// Based on a design by Makerblock ( http://makerblock.com/2010/03/blender-help/ )

//render settings

module ball(size=10.5,postfraction=1.5){
  $fs=1; // def 1, 0.2 is high res
  $fa=4;//def 12, 3 is very nice
	sphere(r=size);
	translate([0,0,-size]) cylinder(r1=size/postfraction,r2=size/2,h=size/postfraction);
	translate([0,0,-(size*(1+1/postfraction))]) cylinder(r1=size,r2=size/postfraction,h=size/postfraction);
}

/*
  size=10.5; // size of the ball joint
  joint_spacing =0; // some space between them?
  joint_thickness = 3; // thickness of the arms - was 2
  joint_arms = 2; // how many arms do you want?
  arm_width = 5; // actually: how much is removed from the arms Larger values will remove more - was 10
*/
module joint(size=10.5, joint_arms=2,frontchop=1,spacingdiv=40)
  {  

  joint_spacing=size/spacingdiv;
  joint_thickness = size/3;
  arm_width = size*2/3;
  o = size/1;
  cutsize=size*6/5;
  $fs=0.8; // def 1, 0.2 is high res
  $fa=4;//def 12, 3 is very nice
    difference()
    {
      union(){
        sphere(r=size+joint_spacing+joint_thickness);
        translate([0,0,size-0]) cylinder(r2=size,r1=size,h=arm_width);
      }
      sphere(r=size+joint_spacing);
      translate([0,0,-size*frontchop]) cube([(size+joint_thickness+joint_spacing)*2,(size+joint_spacing+joint_thickness)*2,size+joint_thickness],center=true);
      for(i=[0:joint_arms])
      {
        rotate([0,0,360/joint_arms*i]) translate([-size*3/2,size,-joint_thickness-o/2])
           cube([size*3,size,size+joint_thickness+o]);

        rotate([0,0,360/joint_arms*i]) translate([-cutsize/2,cutsize/2, -cutsize/2])
        cube([cutsize,cutsize,cutsize]);
      }
    }
  }
