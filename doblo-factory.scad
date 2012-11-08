/*

 Copyright (c) 2010 Daniel K. Schneider
 Copyright (c) 2012 Daniel M. Taub
 
 This file is part of DobloFactory.

 DobloFactory is free source: you can redistribute it and/or modify
    modify it under the terms of the CC BY-NC-SA 3.0 License:
    CreativeCommons Attribution-NonCommerical-ShareAlike 3.0
    as published by Creative Commons. 

    You should have received a copy of the CC BY-NC-SA 3.0 License 
    with this source package. 
    If not, see <http://creativecommons.org/licenses/by-nc-sa/3.0/>
*/

// may change this include based on printer types
include <lib/doblo-params.scad>;

// -------------------------------- DOBLO and STL merging ------------------------------

// Import an STL and place it.
// Only tested with DUPLOS !!

module merge_stl (file, col, row, up, stl_z_offset_mm, scale,shrink = 1) {
    
    // Move STOL right and forward - origin is x=leftmost and y=backmost
    x_offset_mm       =  col * PART_WIDTH(scale) + PART_WIDTH(scale) ;
    y_offset_mm       =  - (row * PART_WIDTH(scale) + PART_WIDTH(scale)) ;
    z_offset_mm       =  up * PART_HEIGHT(scale) + stl_z_offset_mm ;
    // the STL
    translate([x_offset_mm, y_offset_mm, z_offset_mm])
	{
	    scale(1/shrink) import(file);
	}
}

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

// ------------------------------------ Glyphs ----------------------------------------------

module glyph (col, row, up, height, char, scale) {
    size = 2;
    glyph_1 (col, row, up, size, height, char, scale = scale);
}

// if you want to change size. 
// size=2 fits on a 2x2 brick

module glyph_1 (col, row, up, size, height, char) {
    // source is included in this same file, but you could also download bitmap.scad from
    // http://github.com/tbuser/openscad-bitmap and include (uncomment the following line)
    // include <bitmap.scad>;
    size_mm  = size*2*scale;
    col_mm    = col    * PART_WIDTH(scale) + PART_WIDTH(scale);
    row_mm    =  - ( 0 +  row * PART_WIDTH(scale) + PART_WIDTH(scale) );
    up_mm     = up  * PART_HEIGHT(scale);
    // letters are a bit smaller thant a 2x2 brick (32mm)
    translate(v = [col_mm, row_mm, up_mm]) {
	rotate (a=270, v=[0,0,1]) {
	    8bit_char(char, size_mm, height);
	}
    }
}

module text (col, row, up, height, chars, count, scale) {
    size = 2 * scale ;
    text_1 (col, row, up, size, height, chars, count, scale = scale);
}


module text_1 (col, row, up, size, height, chars, count) {
    // source is included in this same file, but you could also download bitmap.scad from
    // http://github.com/tbuser/openscad-bitmap and include (uncomment the following line)
    // include <bitmap.scad>;
    size_mm  = size*2;
    col_mm    = col    * PART_WIDTH(scale) + PART_WIDTH(scale);
    row_mm    =  - ( 0 +  row * PART_WIDTH(scale) + PART_WIDTH(scale) );
    up_mm     = up  * PART_HEIGHT(scale);
    // letters are a bit smaller thant a 2x2 brick (32mm)
    translate(v = [col_mm, row_mm, up_mm]) {
	rotate (a=270, v=[0,0,1]) {
	    8bit_str (chars, count, size_mm, height);
	}
    }
}


// ----------------------------------- DOBLO bricks making code -------------------------------
// all of these can be used in custom modules, i.e. they respect the grid model

module doblo (col, row, up, width,length,height,nibbles_on_off,diamonds_on_off,scale) 
/* Use cases:
- typical Doblo block, use only once to create the first layer, e.g. a small or larger plate
  that can fit on top of another doblo or Duplo(TM) block.
- See also "block", it doesn't have nibbles underneath and it should be used to build 3D structures
- See also doblo_light, a more light-weight block with just "grid walls" underneath.

*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale)  + height * PART_HEIGHT(scale) / 2.0;

    N_insets_col = length /2 ;
    N_insets_row   = width /2;

    // User info
    echo(str("DOBLO brick width(x)=", width * PART_WIDTH(scale), "mm, length=", length*PART_WIDTH(scale), "mm, height=", height*PART_HEIGHT(scale), "mm" ));
    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the doblo
	union () {
	    if (diamonds_on_off && (width > 1 && length > 1)) {
		difference () {
		    difference() {
			// the cube
			cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
			// inner emptiness, a bit smaller and shifted down
			translate([0,0,-DOBLOWALL(scale)]) 	
			    cube([width*PART_WIDTH(scale) - 2*DOBLOWALL(scale), length*PART_WIDTH(scale)-2*DOBLOWALL(scale), height*PART_HEIGHT(scale)], true);
		    }
		    // diamonds
		    diamonds (width, length, height, scale=scale);
		}
	    }
	    else {
		difference() {
		    // the cube
		    cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
		    // inner emptiness, a bit smaller and shifted down
		    translate([0,0,-DOBLOWALL(scale)]) 	
			cube([width*PART_WIDTH(scale) - 2*DOBLOWALL(scale), length*PART_WIDTH(scale)-2*DOBLOWALL(scale), height*PART_HEIGHT(scale)], true);
		}
	    }
	    // nibbles on top
	    if  (nibbles_on_off)
		{
		    //           (col,  row,      up,       width, length)
		    nibbles (-width/2, -length/2, height/2, width, length, scale = scale);
		}
	    
	    // nibbles underneath - only if x or y is bigger than 1
	    if (width > 1 && length > 1)
	    {
	        // big nibbles underneath
		bottom_nibbles (width, length, height, scale = scale);
		// lattice (for low resolution printers - e.g. 0.35 layers - this is not needed)
		if (LATTICE_TYPE > 0 )
		    { 
			bottom_lattice (width, length, height, scale = scale);
		    }
	    }
	    else {
	        // big nibbles underneath
		if (USE_INSET(scale))
                  bottom_nibbles_part (width, length, height, scale = scale);
		// lattice (for low resolution printers - e.g. 0.35 layers - this is not needed)
		/*if (LATTICE_TYPE > 0 )
		    { 
			bottom_lattice (width, length, height, scale = scale);
		    }
        */
        }
            if ((scale < 0.6) && (!USE_INSET(scale)))
              {
                bottom_nibbles_thin (width, length, height,scale=scale);
              }
	    //little walls inside (insets)
          if (USE_INSET(scale))
	    difference() 
		{
		    union()
			{
			    for(j=[1:N_insets_col])
				{	
				    for (i = [1:N_insets_row])
					{
					    translate([0,j*NO(scale)+(j-1)*NO(scale),0 ])   cube([width*PART_WIDTH(scale), INSET_WIDTH(scale),           height*PART_HEIGHT(scale)],true);
					    translate([0,j*-NO(scale)+(j-1)*-NO(scale),0 ]) cube([width*PART_WIDTH(scale), INSET_WIDTH(scale),            height*PART_HEIGHT(scale)],true);
					    translate([i*NO(scale)+(i-1)*NO(scale),0,0 ])   cube([INSET_WIDTH(scale),          length*PART_WIDTH(scale), height*PART_HEIGHT(scale)],true);
					    translate([i*-NO(scale)+(i-1)*-NO(scale),0,0 ]) cube([INSET_WIDTH(scale),          length*PART_WIDTH(scale), height*PART_HEIGHT(scale)],true);	
					}
				}
			}
		    cube([width*PART_WIDTH(scale)-INSET_LENGTH(scale), length*PART_WIDTH(scale)-INSET_LENGTH(scale), height*PART_HEIGHT(scale)+2], true);
		}
	}
    }
}


module nibbles (col, row, up, width, length, scale)
/* Use cases:
- needed by the doblo and the block modules
- can also be stuck on top on parts of a nibble-less doblo or block
*/
{
    // Uses a local coordinate system left/back = 0,0
    // E.g. nibbles (-2,    -2,      0,    4,       4      );
    // echo ("PART_WIDTH(scale)", PART_WIDTH(scale), "NO(scale)", NO(scale));
    x_start =           col    * PART_WIDTH(scale) +  NO(scale) ;
    // echo ("x_start", x_start, "col", col);
    y_start =  - (  row * PART_WIDTH(scale) + NO(scale));
    // echo ("y_start", y_start, "row", row);
    z_local = up * PART_HEIGHT(scale) + NH(scale) / 2;
    translate ([x_start , y_start, z_local]) {
	// 0,0 is left/back corner. Draw to the right (x) and forward (-y)
	for(j=[1:length])
	    {
		for (i = [1:width])
		    {
			translate([(i-1) * PART_WIDTH(scale), -(1) * (j-1) * PART_WIDTH(scale), 0]) doblonibble(scale = scale);
		    }
	    }
    }
}

module diamonds (width, length, height)
{
    x_start = -width/2  * PART_WIDTH(scale) + NBO(scale);
    y_start = -length/2 * PART_WIDTH(scale) + NBO(scale);
    z_pos   = -height * PART_HEIGHT(scale)/2+DIAMOND;
    echo (str ("height = ", height, "z_pos= ", z_pos));
    translate ([0, y_start, z_pos]) {
	// holes along y-axis
	for (i = [0:length-2]) {
	    // echo (str ("diamond y offset=", i*PART_WIDTH(scale)+PART_WIDTH(scale)));
	    translate([0, i* NBO(scale), 0]) 
		rotate (a=45, v=[1,0,0]) { cube([width*PART_WIDTH(scale)+PART_WIDTH(scale),DIAMOND,DIAMOND],true); }
	}
    }
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:width-2]) {
	    // echo (str ("diamond x offset=", j*PART_WIDTH(scale)-PART_WIDTH(scale)));
	    translate([j * NBO(scale), 0, 0]) 
		rotate (a=45, v=[0,1,0]) { cube([DIAMOND,length*PART_WIDTH(scale)+PART_WIDTH(scale),DIAMOND],true); }
	}
    }
}

// produces a wider spaced lattice (not used currently)
module bottom_lattice_wide (width, length, height)
{
    x_start = -width/2  * PART_WIDTH(scale) + NBO(scale);
    y_start = -length/2 * PART_WIDTH(scale) + NBO(scale);
    z_pos   = height * PART_HEIGHT(scale)/2 - LATTICE_WIDTH(scale) - LATTICE_WIDTH(scale)/2;
    translate ([0, y_start, z_pos]) {
	// grid along y-axis
	for (i = [0:length-2]) {
	    translate([0, i* NBO(scale), 0])
		{ cube([width*PART_WIDTH(scale), LATTICE_WIDTH(scale), LATTICE_WIDTH(scale)],true); }
	}
    }
    // grid along x-axis
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:width-2]) {
	    translate([j * NBO(scale), 0, 0]) 
		{ cube([LATTICE_WIDTH(scale),length*PART_WIDTH(scale),LATTICE_WIDTH(scale)],true); }
	}
    }
}

module bottom_lattice (width, length, height)
{
    spacing = NBO(scale)/LATTICE_TYPE;
    x_start = -width/2  * PART_WIDTH(scale) + spacing;
    y_start = -length/2 * PART_WIDTH(scale) + spacing;
    z_pos   = height * PART_HEIGHT(scale)/2 - LATTICE_WIDTH(scale) - LATTICE_WIDTH(scale)/2;
    translate ([0, y_start, z_pos]) {
	// grid along y-axis
	for (i = [0:LATTICE_TYPE*length-2]) {
	    translate([0, i* spacing, 0])
		{ cube([width*PART_WIDTH(scale), LATTICE_WIDTH(scale), LATTICE_WIDTH(scale)],true); }
	}
    }
    // grid along x-axis
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:LATTICE_TYPE*width-2]) {
	    translate([j * spacing, 0, 0]) 
		{ cube([LATTICE_WIDTH(scale),length*PART_WIDTH(scale),LATTICE_WIDTH(scale)],true); }
	}
    }
}


module bottom_nibbles_thin (width, length, height)
/* Use cases:
- needed by the doblo module
- can also be stuck into the feet of an imported STL
*/
{
    x_start = -width/2 * PART_WIDTH(scale) + NBO(scale);
    y_start = -length/2 * PART_WIDTH(scale) + NBO(scale);
    z_local = 0;
    translate ([x_start , y_start, z_local]) {
        if (width == 1){
          for(j=[0:length-2])
          {
              translate([-NBO(scale)/2, j * NBO(scale), 0]) doblobottomnibble_thin(height*PART_HEIGHT(scale),scale=scale);
          }
        }
        else if (length == 1){
          for (i = [0:width-2])
          {
              translate([i * NBO(scale), -NBO(scale)/2, 0]) doblobottomnibble_thin(height*PART_HEIGHT(scale),scale=scale);
          }
        }
      }
}

module bottom_nibbles_part (width, length, height)
/* Use cases:
- needed by the doblo module for h or w == 1
*/
{
    SUPPORT_HEIGHT = height * PART_HEIGHT(scale);

    x_start = -width/2 * PART_WIDTH(scale) + NBO(scale);
    y_start = -length/2 * PART_WIDTH(scale) + NBO(scale);
    z_local = 0;
    translate ([x_start , y_start, z_local]) {
      if(width == 1){
        for(j=[0:length-1]){
          translate([0-ALONG_LEN(scale)/4,j*2*NO(scale)-NO(scale),0])
            cube([ALONG_LEN(scale)/2, INSET_WIDTH(scale), SUPPORT_HEIGHT],true);
          translate([-2*NO(scale)+ALONG_LEN(scale)/4,j*2*NO(scale)-NO(scale),0])
            cube([ALONG_LEN(scale)/2, INSET_WIDTH(scale), SUPPORT_HEIGHT],true);
          if (j!= length-1)
           translate([-NO(scale),j*2*NO(scale),0]){
            union(){
              cube([INSET_WIDTH(scale), ALONG_LEN(scale), SUPPORT_HEIGHT],true);
              cube([CROSS_LEN(scale), INSET_WIDTH(scale), SUPPORT_HEIGHT],true);
            }
          }
        }
      }
      else if (length == 1) {
        for(i=[0:width-1]) {
          translate([i*2*NO(scale)-NO(scale),0-ALONG_LEN(scale)/4,0])
            cube([INSET_WIDTH(scale), ALONG_LEN(scale)/2, SUPPORT_HEIGHT],true);
          translate([i*2*NO(scale)-NO(scale),-2*NO(scale)+ALONG_LEN(scale)/4,0])
            cube([INSET_WIDTH(scale), ALONG_LEN(scale)/2, SUPPORT_HEIGHT],true);
          if (i != width-1)
            translate([i*2*NO(scale),-NO(scale),0])
             union(){
              cube([INSET_WIDTH(scale), CROSS_LEN(scale), SUPPORT_HEIGHT],true);
              cube([ALONG_LEN(scale), INSET_WIDTH(scale), SUPPORT_HEIGHT],true);
              }
        }
      }
  }
}

module bottom_nibbles (width, length, height)
/* Use cases:
- needed by the doblo module
- can also be stuck into the feet of an imported STL
*/
{
    x_start = -width/2 * PART_WIDTH(scale) + NBO(scale);
    y_start = -length/2 * PART_WIDTH(scale) + NBO(scale);
    z_local = 0;
    translate ([x_start , y_start, z_local]) {
	    for(j=[0:length-2])
		{
		    for (i = [0:width-2])
			{
			    translate([i * NBO(scale), j * NBO(scale), 0]) doblobottomnibble(height*PART_HEIGHT(scale),scale=scale);
			}
		}
    }
}

module block (col, row, up, width,length,height,nibbles_on_off, scale) 
/* Use cases:
- building blocks for 3D structures (saves times and plastic, use a light fill in skeinforge)
- movable blocks for games (printed apart)
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale)  + height * PART_HEIGHT(scale) / 2.0;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
	// nibbles on top
	if  (nibbles_on_off)
	    {
		//      (col, row, up, width, length)
		nibbles (-width/2, -length/2, height/2, width, length, scale=scale);
	    }
    }
}



module house_lr (col, row, up, width,length,height, scale) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale)  + height * PART_HEIGHT(scale) / 2.0;
    roof_l = sqrt ( (length*PART_WIDTH(scale)*length*PART_WIDTH(scale)) + (length*PART_WIDTH(scale)*length*PART_WIDTH(scale) ) ) / 2;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
	translate ([0,0,height*PART_HEIGHT(scale)/2]) {
	    rotate ([45,0,0]) {
		cube([width*PART_WIDTH(scale), roof_l, roof_l], true);
	    }
	}
    }		
}

module house_fb (col, row, up, width,length,height, scale) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along y axis and with a min. height and length ... try ;)
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale)  + height * PART_HEIGHT(scale) / 2.0;
    // That was 40 years ago
    roof_l = sqrt ( (width*PART_WIDTH(scale)*width*PART_WIDTH(scale)) + (width*PART_WIDTH(scale)*width*PART_WIDTH(scale) ) ) / 2;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH(scale), length*PART_WIDTH(scale), height*PART_HEIGHT(scale)], true);
	translate ([0,0,height*PART_HEIGHT(scale)/2]) {
	    rotate ([0,45,0]) {
		cube([roof_l, length*PART_WIDTH(scale), roof_l], true);
	    }
	}
    }		
}

LEGO_DIV = false;
module base_plate (col, row, up, width,length,height,nibbles_on_off, scale) 
/* Use cases:
- Creating an easy to print base plate for showing off your prints. I believe that buying one in a shop is more efficient ....
- to do: an other version that has round holes allowing to stack it.
*/

{
    // construction of the grid underneath
    // spacing = (scale < 0.6) ? NBO(scale)/LATTICE_TYPE*2 : NBO(scale)/LATTICE_TYPE;
    spacing = (scale > 0.6) ? NBO(scale) : NBO(scale)*2;
    offset  = NBO(scale);
    x_start = - width/2  * PART_WIDTH(scale) + NBO(scale);
    y_start = - length/2 * PART_WIDTH(scale) + NBO(scale);
    z_pos   = (LEGO_DIV) ? height * PART_HEIGHT(scale)/2 - LATTICE_WIDTH(scale) * 2 : height * PART_HEIGHT(scale)/2 - LATTICE_WIDTH(scale) - LATTICE_WIDTH(scale)/2 ;
    n_rows  = (scale > 0.6) ? length-2 : (length-2)/2 ;  // Need less for legos
    n_cols  = (scale > 0.6) ? width-2 :  (width-2)/2;

    // positioning of the grid with respect to the cube
    x_0 = col    * PART_WIDTH(scale)  + width  * PART_WIDTH(scale) / 2.0;
    y_0 = - (row * PART_WIDTH(scale) + length * PART_WIDTH(scale) / 2.0) ;
    z_0 = up      * PART_HEIGHT(scale) ;

    difference () {
	block (col, row, up, width,length,height,nibbles_on_off, scale) ;

	union () {
	    translate ([x_0, y_0, z_0])
		{
		    translate ([0, y_start, z_pos]) {
			// grid along y-axis
			for (i = [0:n_rows]) {
			   translate([0, i* spacing, 0])
				{ cube([width*PART_WIDTH(scale)-offset*2, LATTICE_WIDTH(scale), LATTICE_WIDTH(scale)],true); }
			}
		    }
		    // grid along x-axis
		    translate ([x_start, 0, z_pos]) {
			// holes along x-axis
			for (j = [0:n_cols]) {
			    translate([j * spacing, 0, 0]) 
				{ cube([LATTICE_WIDTH(scale),length*PART_WIDTH(scale)-offset*2,LATTICE_WIDTH(scale)],true); }
			}
		    }
		}
	}
    }
}




// ------ Cylinder block

module cyl_block (col, row, up, bottom_r, top_r, height, nibbles_on_off, scale) 
{
    bottom_r_mm = bottom_r * NO(scale);
    top_r_mm    = top_r * NO(scale);
    x_0         = col    * PART_WIDTH(scale)   + bottom_r_mm;
    y_0         = - (row * PART_WIDTH(scale)   + bottom_r_mm);
    z_0         = up     * PART_HEIGHT(scale);
	
    // the cylinder is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	cylinder(h= height*PART_HEIGHT(scale), r1 = bottom_r_mm, r2 = top_r_mm, center = false, $fs = 0.2);
	if  (nibbles_on_off)
	    {
		//      (col, row,  up,  width, length)
		// circle is a bit different from cube
		nibbles (-top_r/2+0.5, -top_r/2+0.5, height, top_r-1, top_r-1, scale);
	    }
    }
}

// -------------- support block (triangle )

// Support block for building platforms
// so bad ... :(
// NOTE: make the support block stick into something, else it won't print

module support (col,row,up,height,angle,thickness, scale)
{
    if (angle == 0) {
	translate ([0, 0, 0]) {
	    support1 (col,row,up,height,angle,thickness, scale);
	}
    }
    if (angle == 90) {
	translate ([0, -PART_WIDTH(scale) , 0]) {
	    support1 (col,row,up,height,angle,thickness, scale);
	}
    }
    if (angle == 180) {
	translate ([PART_WIDTH(scale), -PART_WIDTH(scale) - PART_WIDTH(scale)* (thickness-1) , 0]) {
	    support1 (col,row,up,height,angle,thickness, scale);
	}
    }
    if (angle == 270) {
	translate ([PART_WIDTH(scale) + PART_WIDTH(scale) * (thickness-1), 0 , 0]) {
	    support1 (col,row,up,height,angle,thickness, scale);
	}
    }
}


module support1 (col,row,up,height,angle,thickness, scale)
{
    height_mm = height * PART_HEIGHT(scale) ;
    length_mm = height * PART_WIDTH(scale) / 4;
    width_mm  = PART_WIDTH(scale)*thickness; 
    x_0         = col      * PART_WIDTH(scale); 
    y_0         = - (row   * PART_WIDTH(scale)); 
    z_0         = up       * PART_HEIGHT(scale);

    translate ([x_0, y_0 , z_0]) {    		
	rotate (a=angle, v=[0,0,1]) {
	polyhedron ( points = [[0, -width_mm, height_mm], [0, 0, height_mm], [0, 0, 0], [0, -width_mm, 0], [length_mm, -width_mm, height_mm], [length_mm, 0, height_mm]], triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}
    }
}


// --------------------- ramp

module ramp (col,row,up,height,angle,scale)
{
    if (angle == 0) {
	translate ([0, -NO(scale), 0]) {
	    ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 90) {
	translate ([NO(scale), -(2*NO(scale)) , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 180) {
	translate ([(2*NO(scale)), -NO(scale) , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 270) {
	translate ([NO(scale), 0 , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
}


module ramp1 (col,row,up,height,angle)
{
    height_mm = height * PART_HEIGHT(scale);
    length_mm = height * PART_WIDTH(scale);
    x_0         = col      * PART_WIDTH(scale); 
    y_0         = - (row   * PART_WIDTH(scale)); 
    z_0         = up       * PART_HEIGHT(scale);

    translate ([x_0, y_0 , z_0]) {    		
	rotate (a=angle, v=[0,0,1]) {
	polyhedron ( points = [[0, -NO(scale), height_mm], [0, NO(scale), height_mm], [0, NO(scale), 0], [0, -NO(scale), 0], [length_mm, -NO(scale), 0], [length_mm, NO(scale), 0]], triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}
    }
}


//  ---------------------------------- Auxiliary modules ---------------------

module doblonibble() {
    // Lego size does not have holes in the nibbles
    if (scale < 0.6) {
	cylinder(r=NB_RADIUS(scale),           h=NH(scale),  center=true,  $fs = 0.2);
    } else {
	difference() {
	    cylinder(r=NB_RADIUS(scale),       h=NH(scale),  center=true,  $fs = 0.2);
	    cylinder(r=NB_RADIUS_INSIDE(scale),h=NH(scale)+1,center=true,  $fs = 0.2);
	}
    }
}

module doblobottomnibble(height_mm)
{
  difference() {
    cylinder(r=NB_BOTTOM_RADIUS(scale),        h=height_mm,  center=true,$fs = 0.2);
    cylinder(r=NB_BOTTOM_RADIUS_INSIDE(scale), h=height_mm+1,center=true,$fs = 0.2);
  }

}

module doblobottomnibble_thin(height_mm)
{
    cylinder(r=NB_BOTTOM_RADIUS_THIN(scale),        h=height_mm,  center=true,$fs = 0.2);
    //cylinder(r=NB_BOTTOM_RADIUS_INSIDE(scale)/4, h=height_mm+1,center=true,$fs = 0.2);

}
// ************************ GLYPH code ************************************************
/*
This should be replaced by 16 bit or 32 bit code some day.

Retrieved from http://github.com/tbuser/openscad-bitmap, april 8 2010.
Bitmap and 8Bit Font Module
Tony Buser <tbuser@gmail.com>
http://tonybuser.com
http://creativecommons.org/licenses/by/3.0/


http://github.com/tbuser/openscad-bitmap
*/

module bitmap(bitmap, block_size, height, row_size) {
	width = block_size * row_size;
	bitmap_size = row_size * row_size;
	
	function loc_x(loc) = floor(loc / row_size) * block_size;
	function loc_y(loc) = loc % row_size * block_size;

	translate(v = [-width/2+block_size/2,-width/2+block_size/2,height/2]) {
		for (loc = [0:bitmap_size - 1]) {
			if (bitmap[loc] == 1) {
				union() {
					translate(v = [loc_x(loc), loc_y(loc), 0]) {
						cube(size = [block_size, block_size, height], center = true);
					}
				}
			}
		}
	}
}

module 8bit_char(char, block_size, height, include_base) {
	if (char == "0") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,1,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "1") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "2") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "3") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "4") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,1,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "5") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "6") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "7") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "8") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "9") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "A") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "B") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "C") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "D") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,0,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,1,1,0,0,
			0,1,1,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "E") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "F") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "G") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "H") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "I") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "J") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,1,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "K") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,1,1,0,0,
			0,1,1,1,1,0,0,0,
			0,1,1,1,1,0,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "L") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "M") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,1,1,
			0,1,1,1,0,1,1,1,
			0,1,1,1,1,1,1,1,
			0,1,1,0,1,0,1,1,
			0,1,1,0,0,0,1,1,
			0,1,1,0,0,0,1,1,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "N") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,0,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "O") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "P") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "Q") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,0,1,1,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "R") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "S") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "T") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "U") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "V") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "W") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,1,1,
			0,1,1,0,0,0,1,1,
			0,1,1,0,1,0,1,1,
			0,1,1,1,1,1,1,1,
			0,1,1,1,0,1,1,1,
			0,1,1,0,0,0,1,1,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "X") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "Y") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "Z") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "a") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "b") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "c") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "d") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "e") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "f") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "g") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,1,1,0,
			0,1,1,1,1,1,0,0
		], block_size, height, 8);
	} else if (char == "h") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "i") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "j") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,1,1,1,1,0,0
		], block_size, height, 8);
	} else if (char == "k") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,1,1,0,0,0,
			0,1,1,0,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "l") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "m") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,1,1,
			0,1,1,1,1,1,1,1,
			0,1,1,0,1,0,1,1,
			0,1,1,0,0,0,1,1,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "n") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "o") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "p") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "q") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,1,1,0
		], block_size, height, 8);
	} else if (char == "r") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "s") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "t") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "u") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "v") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "w") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,1,1,
			0,1,1,0,1,0,1,1,
			0,1,1,1,1,1,1,1,
			0,0,1,1,1,1,1,0,
			0,0,1,1,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "x") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else if (char == "y") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,1,1,0,0,
			0,1,1,1,1,0,0,0
		], block_size, height, 8);
	} else if (char == "z") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "+") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,1,1,1,1,1,1,0,
			0,1,1,1,1,1,1,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "-") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == ":") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == ".") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == ",") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "?") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "=") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,1,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "*") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,0,1,1,1,1,0,0,
			1,1,1,1,1,1,1,1,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "!") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "''") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "#") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			1,1,1,1,1,1,1,1,
			0,1,1,0,0,1,1,0,
			0,1,1,0,0,1,1,0,
			1,1,1,1,1,1,1,1,
			0,1,1,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "$") {
		bitmap([
			0,0,0,1,1,0,0,0,
			0,0,1,1,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,1,1,1,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "%") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,1,1,0,0,
			0,0,1,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,0,0,1,1,0,
			0,1,0,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "&") {
		bitmap([
			0,0,0,1,1,1,0,0,
			0,0,1,1,0,1,1,0,
			0,0,0,1,1,1,0,0,
			0,0,1,1,1,0,0,0,
			0,1,1,0,1,1,1,1,
			0,1,1,0,1,1,1,0,
			0,0,1,1,1,0,1,1,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "@") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,1,1,0,0,1,1,0,
			0,1,1,0,1,1,1,0,
			0,1,1,0,1,1,1,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,1,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "'") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "(") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,1,1,1,0,0,
			0,0,1,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == ")") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,1,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,1,0,0,
			0,0,1,1,1,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "<") {
		bitmap([
			0,0,0,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == ">") {
		bitmap([
			0,1,1,0,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "[") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "]") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,1,1,0,0,
			0,0,1,1,1,1,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "/") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,1,1,0,0,
			0,0,0,1,1,0,0,0,
			0,0,1,1,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,1,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "\\") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,1,1,0,0,0,0,0,
			0,0,1,1,0,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,0,1,1,0,0,
			0,0,0,0,0,1,1,0,
			0,0,0,0,0,0,1,0,
			0,0,0,0,0,0,0,0
		], block_size, height, 8);
	} else 	if (char == "_") {
		bitmap([
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			0,0,0,0,0,0,0,0,
			1,1,1,1,1,1,1,1
		], block_size, height, 8);
	} else 	if (char == "|") {
		bitmap([
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0,
			0,0,0,1,1,0,0,0
		], block_size, height, 8);
	} else {
		echo("Invalid Character: ", char);
	}

}

module 8bit_str(chars, char_count, block_size, height) {
	echo(str("Total text width: ", block_size * 8 * char_count, "mm"));
	union() {
		for (count = [0:char_count-1]) {
			translate(v = [0, count * block_size * 8, 0]) {
				8bit_char(chars[count], block_size, height);
			}
		}
	}
}

// example usage code removed by DKS

//------------------------------- end OpenSCAD Bitmap Fonts Module
