/* Connectors Library for DobloFactory

 Daniel Taub (dan@cemi.org) November 2012

 includes:
   hinge_y - rotates about y
   hinge_z - rotates about z
   ball joint
*/
include <../vendor/pins/buser_pins.scad>;

module hinge_y(xoff, yoff, zoff,length,width,height=3,nibbles=true,size=DOBLO, $fs=0.01,type=0){
  BLOCKWIDTH=DOBLOWIDTH(size)/2/size;
  //sepr = BLOCKWIDTH *(sep);
  BLOCKHEIGHT = DOBLOHEIGHT(size)/(2*size);  
  ABIT =  1/40*BLOCKHEIGHT;
  //scale = .388*BLOCKWIDTH;
  echo([BLOCKWIDTH, BLOCKHEIGHT]);

    union(){
      doblo   (xoff,   yoff,   zoff,   length,   width,    height,  nibbles, false, size);
      hinge_a (xoff, yoff, zoff, width,length, height, BLOCKWIDTH, BLOCKHEIGHT,type);
    }
}


module hinge_a (xoff, yoff, zoff, width,length,height, BLOCKWIDTH, BLOCKHEIGHT,type = 0)
{
  h_len = BLOCKWIDTH/4;
  clip = h_len /14;
  rad_i = h_len/2;
  rad_o = BLOCKHEIGHT/2;
  if (width > 1){
    for(i=[1:width]){
      translate([(xoff+length)*BLOCKWIDTH,-clip/2+(-yoff-width)*BLOCKWIDTH+h_len*2*(i*2-1),(zoff/3)*BLOCKHEIGHT]) {
        if ( (i%2) == type) {
          difference(){
            hinge_arm(BLOCKWIDTH,h_len,rad_o,clip);
            //#translate([.5*BLOCKWIDTH,clip,rad_o])sphere(r=rad_i);
            translate([.5*BLOCKWIDTH,2*h_len+clip,rad_o])rotate([90,0,0])cylinder(h=h_len*2+clip,r=rad_i*1.2);
          }
        }
        else {
          union(){
            hinge_arm(BLOCKWIDTH,h_len,rad_o,clip);
            //translate([.5*BLOCKWIDTH,clip,rad_o])sphere(r=rad_i*8/10);
            translate([.5*BLOCKWIDTH,1.5*rad_i+clip,rad_o])sphere(r=2*rad_i);
          }
        }
      } //end translate
    } // end for
  } //end if
} //end module


module hinge_arm(BLOCKWIDTH,h_len,rad_o,clip){
   union(){
     translate([0,clip,0]) cube([BLOCKWIDTH/2,h_len*2-clip,rad_o*2]);
     translate([.5*BLOCKWIDTH,h_len*2,rad_o]) rotate([90,0,0]) cylinder(r=rad_o,h=h_len*2-clip);
   }
}



//offz still needs work
module hinge_z_hole(offx=0,offy=0,offz=0,width=1,length=2,height=6,nibbles=true,size=DOBLO,tight=true){
  BLOCKHEIGHT = height/6*DOBLOHEIGHT(size)/(2*size);
  ABIT =  1/40*BLOCKHEIGHT;
  //x=PART_WIDTH(size)+PART_WIDTH(size)*offx;
  x=PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  //y=-PART_WIDTH(size)*offy;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)+INSET_WIDTH(size)/2; //w2.6
  hei = 9/7*BLOCKHEIGHT;
  RO=NB_BOTTOM_RADIUS(size); //w3.5
  RII = RO-DOBLOWALL(size)/5; //w3.2
  //echo(["xA:",RI,RO, RII,ABIT,9/7*BLOCKHEIGHT]);
 
  function hole_x() = (width < length) ? x+PART_WIDTH(size)*width : x; 
  function hole_y() = (width < length) ? y : y-PART_WIDTH(size)*length;
  difference(){
    union()
    {
      doblo   (offx,   offy, offz, width, length, height, nibbles, false, size);
      translate([hole_x(),hole_y(),0])
      {
        difference(){
          cylinder(9/7*BLOCKHEIGHT,RO,RO,$fs=.001);
          if (width > length)
            translate([-w,-3/2*w,-ABIT]) block (0,-.5,0,.5,.5,2,false,size);
          else
            translate([w,w/2,-ABIT]) block (-.5,0,0,.5,.5,2,false,size);
        }
      }
    }
    union()
    {   
      translate([hole_x(),hole_y(),-1/7*BLOCKHEIGHT])
      {
        translate([0,0,hei+1/7*BLOCKHEIGHT])rotate([0,180,0])pinhole(h=hei,r=NB_RADIUS(size));
        //cylinder(11/7*BLOCKHEIGHT,RI,RI,$fs=.01);
      }
      translate([hole_x(),hole_y(),9/7*BLOCKHEIGHT])
      {
        cylinder(31/42*BLOCKHEIGHT,RII,RII,$fs=.001);
      }
    }
  }
}


module hinge_z_pin(offx=0,offy=0,offz=0,width=1,length=2,height=6,nibbles=true,size=DOBLO,slit=true){

  //height = 6;
  BLOCKHEIGHT = height/6*DOBLOHEIGHT(size)/(2*size);
  ABIT =  1/40*BLOCKHEIGHT;
  x=PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)/2+INSET_WIDTH(size)/2; //w2.6
  RO=NB_RADIUS(size); 
  RII = NB_BOTTOM_RADIUS(size);
  hei = BLOCKHEIGHT*9/7;
  //echo(["B:",RI,RO, RII, ABIT]);

  union()
  {
    difference(){
      doblo   (offx,   offy,   offz,   width,   length,    height,  nibbles, false, size);
      translate([x,y,-ABIT]) cylinder(ABIT+9/7*BLOCKHEIGHT,RII,RII,$fs=.001);

    }
    translate([x,y,0]) {  
      union(){
        translate([0,0,hei]) rotate([180,0,0])pin(r=RO,h=hei,slit=slit);
        translate([0,0,9/7*BLOCKHEIGHT]) cylinder(5/7*BLOCKHEIGHT,2*RI,2*RI,$fs=.01);
      }
    }
  }
}


module hinge_z (xoff, yoff, zoff, width,length,height, BLOCKWIDTH, BLOCKHEIGHT)
{
  h_len = BLOCKWIDTH/4;
  clip = h_len /10;
  rad_i = h_len/2;
  rad_o = BLOCKHEIGHT/2;
  if (width > 1){
    for(i=[1:width]){
      translate([(xoff+length)*BLOCKWIDTH,-clip/2+(-yoff-width)*BLOCKWIDTH+h_len*2*(i*2-1),(zoff/3)*BLOCKHEIGHT]) {
        if ( (i%2) == 0) {
          difference(){
            hinge_arm(BLOCKWIDTH,h_len,rad_o,clip);
            //#translate([.5*BLOCKWIDTH,clip,rad_o])sphere(r=rad_i);
            translate([.5*BLOCKWIDTH,2*h_len+clip,rad_o])rotate([90,0,0])cylinder(h=h_len*2+clip,r=rad_i*1.2);
          }
        }
        else {
          union(){
            hinge_arm(BLOCKWIDTH,h_len,rad_o,clip);
            //translate([.5*BLOCKWIDTH,clip,rad_o])sphere(r=rad_i*8/10);
            translate([.5*BLOCKWIDTH,1.5*rad_i+clip,rad_o])sphere(r=2*rad_i);
          }
        }
      } //end translate
    } // end for
  } //end if
} //end module


module hinge_arm(BLOCKWIDTH,h_len,rad_o,clip){
   union(){
     translate([0,clip,0]) cube([BLOCKWIDTH/2,h_len*2-clip,rad_o*2]);
     translate([.5*BLOCKWIDTH,h_len*2,rad_o]) rotate([90,0,0]) cylinder(r=rad_o,h=h_len*2-clip);
   }
}


/*
Based on ball joint in SCAD by Erik de Bruijn, modified by juniortan
http://www.thingiverse.com/thing:2631
derived originally from Erik's parametric ball joint:
http://www.thingiverse.com/thing:1968
*/

module ball_doblo(xoff, yoff, zoff,width,length,height=3,nibbles=true,diamonds=false,size=DOBLO){
  
  x_1 = xoff    * PART_WIDTH(size)  + width  * PART_WIDTH(size);
  x_2=x_1+PART_WIDTH(size)/2;
  y_0 = - (yoff * PART_WIDTH(size) + length * PART_WIDTH(size) / 2.0) ;
  z_0 = zoff      * PART_HEIGHT(size);

  union(){
    doblo   (xoff, yoff, zoff, width,length, height, nibbles, diamonds, size);
    translate([x_2,y_0,z_0+5*size]) rotate([0,90,0])ball(size=5*size);
  }
}
module socket_doblo(xoff, yoff, zoff,width,length,height=3,nibbles=true,diamonds=false,size=DOBLO){


  x_1 = xoff    * PART_WIDTH(size);
  x_2=x_1-PART_WIDTH(size)/2;
  y_0 = - (yoff * PART_WIDTH(size) + length * PART_WIDTH(size) / 2.0) ;
  z_0 = zoff      * PART_HEIGHT(size);

  union(){
    doblo   (xoff, yoff, zoff, width,length, height, nibbles, diamonds, size);
    translate([x_2,y_0,z_0+5*size])rotate([0,90,0])rotate([0,0,90])joint(size=5*size, frontchop=1.2);

  }
}



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


module top_ball_doblo(xoff, yoff, zoff,width,length,height=3,nibbles=false,diamonds=false,size=DOBLO){
  
  x_1 = xoff    * PART_WIDTH(size)  + width  * PART_WIDTH(size)/2;
  y_0 = - (yoff * PART_WIDTH(size) + length * PART_WIDTH(size) / 2.0) ;
  z_0 = zoff      * PART_HEIGHT(size)+height*PART_HEIGHT(size);

  union(){
    doblo   (xoff, yoff, zoff, width,length, height, nibbles, diamonds, size);
    translate([x_1,y_0,z_0+1.5*5*size]) rotate([0,0,0])ball(size=5*size);
  }
}


module pin_prop(rad=2.375,len=30,hei=6,plen=11){
  rotate([0,90,270])translate([-rad,0,0]) union(){
    translate([-rad,-len])cube([rad*2,len*2,3]);
    translate([0,-len])cylinder(h=hei,r=rad);
    translate([0,len])cylinder(h=hei,r=rad);
    rotate([0,0,90])pin(h=plen,r=3);
  }
}
