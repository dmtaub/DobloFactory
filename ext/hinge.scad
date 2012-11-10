// based in part on a hinge by irts
// http://www.thingiverse.com/thing:14833
// modified by Dan Taub 2012-11-01


module hinge1a(size,offx=0,offy=0){
  up = 6;
  BLOCKHEIGHT = up/6*DOBLOHEIGHT(size)/(2*size);
  ABIT =  1/40*BLOCKHEIGHT;
  x=PART_WIDTH(size)+PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)+INSET_WIDTH(size)/2; //w2.6
  RO=NB_BOTTOM_RADIUS(size); //w3.5
  RII = RO-DOBLOWALL(size)/4; //w3.2
  echo(["A:",RI,RO, RII,ABIT]);

  difference(){
    union()
    {
      doblo   (offx,   offy,   0,   1,   2,    up,  true, false, size);
      translate([x,y,0])
      {
        difference(){
          cylinder(9/7*BLOCKHEIGHT,RO,RO,$fs=.001);
          translate([w,w-y,-ABIT]) block (-.5,offy,0,.5,.5,2,false,size);
        }
      }
    }
    union()
    {   
      translate([x,y,-1/7*BLOCKHEIGHT])
      {
        cylinder(11/7*BLOCKHEIGHT,RI,RI,$fs=.001);
      }
      translate([x,y,9/7*BLOCKHEIGHT])
      {
        cylinder(31/42*BLOCKHEIGHT,RII,RII,$fs=.001);
      }
    }
  }
}


module hinge1b(size,offx=0,offy=0){
  up = 6;
  BLOCKHEIGHT = up/6*DOBLOHEIGHT(size)/(2*size);
  ABIT =  1/40*BLOCKHEIGHT;
  x=PART_WIDTH(size)*offx;
  y=-PART_WIDTH(size)*offy-INSET_WIDTH(size)/2;
  w=-DOBLOWALL(size);
  RI=NB_RADIUS(size)/2+INSET_WIDTH(size)/2; //w2.6
  RO=NB_RADIUS(size); 
  RII = NB_BOTTOM_RADIUS(size);
  echo(["B:",RI,RO, RII, ABIT]);

  union()
  {
    difference(){
      doblo   (offx,   offy,   0,   1,   2,    up,  true, false, size);
      translate([x,y,-ABIT]) cylinder(ABIT+9/7*BLOCKHEIGHT,RII,RII,$fs=.001);

    }
    translate([x,y,0])
    {  union(){
                difference(){
                  cylinder(9/7*BLOCKHEIGHT,RO,RO,$fs=.001);
                  union(){
                    translate([0,0,-ABIT])
                    {
                      cylinder(2*BLOCKHEIGHT,RI,RI,$fs=.001);
                    }
                    translate([-ABIT*5,-ABIT*21,-ABIT]) cube([ABIT*10,ABIT*42,ABIT*80]);
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


module hinge2(xoff, yoff, zoff,length,width,up=3,nibbles=true,size=DOBLO ){
  BLOCKWIDTH=DOBLOWIDTH(size)/2/size;
  //sepr = BLOCKWIDTH *(sep);
  BLOCKHEIGHT = DOBLOHEIGHT(size)/(2*size);  
  ABIT =  1/40*BLOCKHEIGHT;
  //scale = .388*BLOCKWIDTH;
  echo([BLOCKWIDTH, BLOCKHEIGHT]);

    union(){
      doblo   (xoff,   yoff,   zoff,   length,   width,    up,  nibbles, false, size);
      hinge_a (xoff, yoff, zoff, width,length, up, BLOCKWIDTH, BLOCKHEIGHT);
    }
}


module hinge_a (xoff, yoff, zoff, width,length,up, BLOCKWIDTH, BLOCKHEIGHT)
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
        translate([0,0,1.05*i])sphere(r=.13);
        translate([0,0,.95+1.05*i])sphere(r=.13,$fs=.001);

      }
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

    } // end union
  }//end else
}//end module

module hinge(right,size=1/8,len=1.5){
  scale([size,size,size])model(right,len);
}



