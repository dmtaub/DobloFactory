// originally created by irts
// http://www.thingiverse.com/thing:14833
// modified by Dan Taub 2012-11-01

$fs=.01;
module model(right,len){
if(right==1){
    

difference(){
      union(){
        intersection(){
        cylinder(r=.8,h=8);
          for(i=[0,2,4]){
            translate([0,0,1.05*i])cylinder(r=.8,h=.95);
          }//end for
        }//end union
         for(i=[0,2,4]){
         translate([0,-.4,1.05*i])cube([len,.8,.95]);
       }//end for
    }//end intersection
  cylinder(r=.2,h=8.5);
    }//end difference
  }//end if
  else{
  
union(){
  for(i=[1,3]){
    translate([0,0,1.05*i])sphere(r=.2);
    translate([0,0,.95+1.05*i])sphere(r=.2);

  }
difference(){
    union(){
      intersection(){
      cylinder(r=.8,h=8);
        for(i=[1,3]){
          #translate([0,0,1.05*i])cylinder(r=.8,h=.95);
       }
     }
   for(i=[1,3]){
    translate([0,-.4,1.05*i])cube([len,.8,.95]);
}//end for     
}//end union
  
  cylinder(r=.2,h=8.5);
}  //end difference
} // end union
}//end else
}//end module

module hinge(right,size=1/8,len=1.5){
scale([size,size,size])model(right,len);
}

