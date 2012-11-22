
// --------------- modules made out of our elementary bricks ---------------------------------

// Pillars - not done yet !!

module pillar_lr (scale)
{
    translate ([0,0,0]) {
	difference () {
	    rotate (a=90, v=[1,0,0]) {
		scale (v=[1,1.6,1]) {
		    difference () {
			cylinder(h = DOBLOHEIGHT(scale), r=PART_WIDTH(scale), $fs = 0.2);
			# translate ([NO(scale),0,-1]) {
			    cylinder(h = DOBLOHEIGHT(scale)+2, r=PART_WIDTH(scale), $fs = 0.2);
			}
		    }
		}
	    }
	    # translate ([-DOBLOHEIGHT(scale),-DOBLOHEIGHT(scale)-NO(scale),- 2* DOBLOHEIGHT(scale)]) {
		cube ([DOBLOHEIGHT(scale)*2, DOBLOHEIGHT(scale)*2, DOBLOHEIGHT(scale)*2]);
	    }
	}
    }
}

module doblo_light (col, row, up, width,length,height,nibbles_on_off,scale) 
/* Use cases:
A more light-weight blocks with just walls underneath, e.g. ok for pieces of a game that don't really need to stick so well
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale)  + height * PART_HEIGHT(scale) / 2.0;

    N_insets_col = length /2 ;
    N_insets_row   = width /2;
    N_grid_col  = length - 1 - (length  % 2 );
    N_grid_row  = width -1 - (width  % 2 );

    // User info
    echo(str("DOBLO light brick width(x)=", width * PART_WIDTH(scale), "mm, length=", length*PART_WIDTH(scale), "mm, height=", height*PART_HEIGHT(scale), "mm" ));

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	union () {
	    difference() {
		// the cube
		cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
		// inner emptiness, a bit smaller and shifted down
		translate([0,0,-DOBLOWALL(scale)]) 	
		    cube([width*PART_WIDTH(scale) - 2*DOBLOWALL(scale), length*PART_WIDTH(scale)-2*DOBLOWALL(scale), height*PART_HEIGHT(scale)], true);
	    }
	    
	    // nibbles on top
	    if  (nibbles_on_off)
		{
		    //             (col, row, up, width, length)
		    nibbles (-width/2, -length/2, height/2, width, length, scale);
		}
	    
	    // criss-cross walls inside
	    union () {
	    for(j=[1:N_grid_col])
		{	
		    translate([j*NBO(scale) - width * NO(scale), 0, 0]) cube([INSET_WIDTH(scale),width*PART_WIDTH(scale), height*PART_HEIGHT(scale)],true);
		}
 	    for (i = [1:N_grid_row])
 		{
 		    translate([0, (i)*NBO(scale) - length * NO(scale) ,0 ]) cube([width*PART_WIDTH(scale), INSET_WIDTH(scale), height*PART_HEIGHT(scale)],true);
		}
	    }
	    
	    //little walls inside (insets)
