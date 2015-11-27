include <doblo-factory.scad>;
include <lib/doblo-params-repl5.scad>;

$fa=0.01;
//cyl_block (0,0,0, 3, 1, FULL, true, DOBLO);
//doblo   (2,   2,   0,   2,   2,    THIRD,  true, false, DOBLO);

%nibbles   (0,   0,   0,   2,   2, DOBLO);
spire (0, 0, 0, 2, FULL*3, true, DOBLO);

module spire( col, row, up, side, height, nibbles_on_off, scale){
  //fudge factor ... pla makerbot
  spacing = DOBLOWALL(scale)/2;//NB_RADIUS(scale) -NB_RADIUS_INSIDE(scale) ;
    
  inner_rad = side*PART_WIDTH(scale)/2+spacing;//-INSET_WIDTH(scale);
  outer_rad = side*PART_WIDTH(scale)/2+spacing+DOBLOWALL(scale);//-INSET_WIDTH(scale)
    
  high = height * PART_HEIGHT(scale);
  d_high = DOBLOWALL(scale);
  lesshigh = high-d_high;
  echo(high,lesshigh, up);
    
  x_0 = col    * PART_WIDTH(scale)  + side  * PART_WIDTH(scale) / 2.0;
  y_0 = - (row * PART_WIDTH(scale) + side * PART_WIDTH(scale) / 2.0) ;
  z_0 = up      * PART_HEIGHT(scale)  + high / 2.0;
   
  ratio = 1/8;
  c_h = high*(1-ratio);
  s_h = high*ratio;
    
  translate ([x_0, y_0, z_0]) {
      //the doblo
     union () {
        translate([0,0,-high/2+s_h/2])bottom_nibbles (side, side, height*ratio, scale = scale);
      
        translate([0,0,s_h+c_h/2-high/2])curved(outer_rad,c_h);
        translate([0,0,-high/2+s_h/2])
          difference(){
            cylinder(h=s_h,r=outer_rad,center=true);
            translate([0,0,-d_high/2])
              cylinder(h=s_h,r=inner_rad,center=true);
          }

        // nibbles on top
        if  (nibbles_on_off)
        {
            //           (col,    row,        up,  width, length)
            nibbles (0.5-side/2, 0.5-side/2, height/2, 1, 1, scale = scale);
        }

     }
  }
 
}

//module curved(outer_rad,top_h, factor = 1.1, fraction = 0.81){
module curved(outer_rad,top_h, factor = 0.8, fraction = .45){
  rotate_extrude($fn = 100,convexity=2) 
    translate([outer_rad,top_h/2])scale([-1,-1])difference(){
        square([outer_rad,top_h]);
            scale([outer_rad/factor,top_h/fraction])circle(r=fraction,$fs=0.01);
    }

}


