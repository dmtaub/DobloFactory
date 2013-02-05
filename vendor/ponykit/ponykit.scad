/*
   Modified version of:
   Pony Creation Kit by MaskedRetriever
   
   http://www.thingiverse.com/thing:6123
 */

module pony(tail=0,mane=0,horn=0,wings=false,body=true,ears=true,conv = 3){
  translate([0,0,19])union(){
    if (body)
      import_stl("vendor/ponykit/ponybase.stl", convexity=conv);
    tail(tail);
    mane(mane);
    if (ears)
       ears();
    horn(horn);
    if (wings)
      wings();
  }
}

module horn(val){
  if (val==0)
    translate([0,-11,14])rotate([30,0,0])cylinder(6,1.7,0.5);
}


module wing(){
  scale([0.4,2,1])sphere(3);
  translate([0,0,2])rotate([20,0,0])scale([0.4,2,1])sphere(3);
  translate([0,-2,4])rotate([40,0,0])scale([0.4,2,1])sphere(3);
  rotate([5,0,0])translate([0,3,1.2])scale([0.4,2,1])sphere(2.4);
  rotate([5,0,0])translate([0,3,5])rotate([20,0,0])scale([0.3,2,1])sphere(2.4);
  rotate([5,0,0])translate([0,2,6])rotate([40,0,0])scale([0.3,2,1])sphere(2.4);
  rotate([5,0,0])translate([0,6,8])rotate([40,0,0])scale([0.3,2,1])sphere(1.5);
  rotate([5,0,0])translate([0,6,4])rotate([20,0,0])scale([0.3,2,1])sphere(2.4);
  translate([0,-5,1])scale([0.4,1,1])sphere(3);
}

module wings(){
  scale(0.8)translate([4,4,5])rotate([10,10,0])wing();
  scale(0.8)translate([-4,4,5])rotate([10,-10,0])wing();
}

module tail(type = 0){
  if(type==0){
    translate([0,7,1])sphere(3);
    translate([1,8,0])sphere(3.3);
    translate([2,8,-2])sphere(3);
    translate([2,8,-5])sphere(3.4);
    translate([2,8,-7])sphere(3);
    translate([0,8,-9])sphere(4);
    translate([1,10,-13])sphere(4.4);
  }

  if(type==1){
    translate([0,5,2])rotate([-60,0,0])scale([0.3,0.3,1])sphere(5);
    translate([0,9,3])rotate([-120,0,0])scale([0.3,0.3,0.5])sphere(5);
    translate([0,10,-1])rotate([-10,0,0])scale([0.6,0.6,1])sphere(4);
    translate([0,10,-5])rotate([20,0,0])scale([0.6,0.6,1])sphere(4);
    translate([2,10,-9])rotate([0,-40,0])scale([0.6,0.6,1])sphere(5);
  }

  if(type==2){
    translate([0,6,2])sphere(3);
    translate([0,2,0])difference(){
      translate([0,6,-12])scale([0.4,0.4,1])sphere(15);
      translate([0,6,-25])cube(12, center=true);
    }
  }

}

  module mane(type=0){
    if(type==0)
    {
      translate([0,-6,14])scale([0.6,1,1])sphere(6);
      translate([0,-3,10])scale([0.8,1,1])sphere(4);
      translate([1,-6,14])scale([0.6,0.8,0.8])sphere(6);
      translate([-1,-6,14])scale([0.6,0.8,0.8])sphere(6);
    }
    if(type==1)
    {
      translate([0,-5.5,13])scale([0.9,1,1])sphere(5);
      translate([0,-2,11])sphere(3);
      translate([1,-2,7])rotate([0,-30,0])scale([1,1,1.5])sphere(3);
      translate([3,-3,3])rotate([-20,-20,0])scale([1,1,1.5])sphere(3);
    }
    if(type==2)
    {
      translate([0,-9,13])difference(){
        scale([1,1,0.8])sphere(6);
        translate([0,0,-7])cube(12,center=true);
      }
      translate([0,-9,8])scale([1,1,1.2])difference(){
        sphere(8);
        rotate([0,90,0])cylinder(16,5,5,center=true);
        translate([0,-5,5])cube(14,center=true);
        translate([0,-9,-2])cube(14,center=true);
        translate([0,-6,-10])rotate([-45,0,0])cube(14,center=true);
      }
    }


  }

module ears(){
  translate([3,-7,14])rotate([0,0,50])scale([1,0.3,1])rotate([180,40,0])difference(){
    intersection(){
      sphere(4);
      translate([6,0,0])sphere(6);
    }
    translate([0,6,0])sphere(5);
  }

  translate([-3,-7,14])rotate([0,0,-50])scale([1,0.3,1])rotate([0,-40,0])difference(){
    intersection(){
      sphere(4);
      translate([-6,0,0])sphere(6);
    }
    translate([0,-6,0])sphere(5);
  }


}


