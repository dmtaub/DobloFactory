// Based on ball joint in SCAD by Erik de Bruijn, modified by juniortan
// Based on a design by Makerblock ( http://makerblock.com/2010/03/blender-help/ )

//render settings

module ball(size=11){
  $fs=0.8; // def 1, 0.2 is high res
  $fa=4;//def 12, 3 is very nice
	sphere(r=size);
	translate([0,0,-size]) cylinder(r1=size,r2=size/2,h=size/3);
	translate([0,0,-size*4/3]) cylinder(r=size,h=size/3);
}

/*
  size=10.5; // size of the ball joint
  joint_spacing =0; // some space between them?
  joint_thickness = 3; // thickness of the arms - was 2
  joint_arms = 2; // how many arms do you want?
  arm_width = 5; // actually: how much is removed from the arms Larger values will remove more - was 10
*/
module joint(size=10.5,joint_spacing=0, joint_arms=2)
  {
  joint_thickness = size/3;
  arm_width = 2*size+joint_thickness;
  $fs=0.8; // def 1, 0.2 is high res
  $fa=4;//def 12, 3 is very nice
    difference()
    {
      sphere(r=size+joint_spacing+joint_thickness);
      sphere(r=size+joint_spacing);
      translate([0,0,-size]) cube([(size+joint_thickness+joint_spacing)*2,(size+joint_spacing+joint_thickness)*2,size+joint_thickness],center=true);
      for(i=[0:joint_arms])
      {
        #rotate([0,0,360/joint_arms*i]) translate([-arm_width/2,size*.90, -size])
          cube([arm_width,size,(size+joint_thickness)*2]);
      }
    }
    translate([0,0,size-0]) cylinder(r2=size,r1=size,h=size/2);
  }
