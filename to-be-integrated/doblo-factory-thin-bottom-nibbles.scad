/* DOBLO: DUPLO-compatible scenery factory

Version 1.9, 1.10 and 1.11 - oct 2012
- fixed some bugs
- increased size of duplo bottom-nibbles a tiny bit
- made it somewhat 0.25 SCALE compatible

Version 1.8.1 - Sept 10 2012
- added a grid on underneath the bridges that will stabilize nibbles and maybe help printing a duplo block with a high resolution printer. If set to 0, it will not print this lattice. The result underneath will remain ugly with a lattice, but the model is easier to print.
- fixed a bug I totally missed (uneven blocks, e.g. 3x3 had missing nibbles underneath)
- Multiplied parameters for better calibration
- Added an easy to print base plate (revised for 1.8.1)

Version 1.6 - May 1 2012
- added lozenges aka diamonds (optional) to the low end of walls for ABS printing
- adapted constants for 0.25mm printing (felixprinter, fabbster)

Version 1.5 - 2011
- bugfixes

Version 1.3 - May 1 2010
- Added better Lego compatibility
- Still not fully tested
- Set the SCALE variable in your module file, else the module will exit with an error !!

Read down to understand how to use this.
Documentation (similar as here, but more readable)
 http://edutechwiki.unige.ch/en/Doblo_factory

Download:
- http://www.thingiverse.com/thing:2106

BUGS, missing pieces, other things to do:
- cyl_block nibbles can't handle top_r < 2 and rational numbers
- a pilar with both supports for bottom and top (i.e. 2x4 directions)
- replace support by triangle_forward, triangle_right, etc.
- Lego brick heights work in multiples of 3 (Duplos is multiples of 2)
- test STL merging with both Lego models

Authors:
- Daniel K. Schneider, TECFA, University of Geneva, March 2010
- based on parametric lego duplo (http://www.thingiverse.com/thing:1778) by Domonoky
- based on OpenSCAD Bitmap Fonts Module (http://www.thingiverse.com/thing:2054) by Tony Buser.

Copyright and credits:
- Attribution - Non-Commercial - Share Alike license.
  (http://creativecommons.org/licenses/by-nc-sa/3.0/)

This code is derived from two original works: 
1) Domonoky's parametric lego duplo - http://www.thingiverse.com/thing:1778. 
  I got the idea, and then kept some of the fine parts (nibbles, walls, etc,)
2) Tony Buser's OpenSCAD Bitmap Fonts Module - http://www.thingiverse.com/thing:2054

Legal disclaimer: 
- This is not Duplo(TM), it's called Doblo and it just happens to fit more or less.

Purposes:
 - Creation of 3D duplo-compatible "play" boards for various purposes from Kindergarten to Master level
 - Introduction to 3D environnment (learn about positions) and use of OpenSCAD
 - "End-user 3D programming" environment (e.g. students could add other primitives)

Coordinate system: 
 We use  a column/row/up grid, each x/y cell corresponds to a DUPLO/Lego nibble
 - col = x-axis
 - row = y-axis
 - origin is at x=0 and y=0, default bottom of bricks is z=0
 - each block module starts from left/back ("upper" left corner)

 units for col/row  and width/length:
* 1 DUPLO row (16mm, i.e. half a 2x2 block)
* 1 LEGO  row (8mm)
 units for up and height: 
* DUPLO: 4.8mm, i.e. a 1/4th of a typical duplo 19.2mm 2x2 block
* LEGO : 2.4mm, i.e. a 1/4th of a typical duplo 19.2mm 2x2 block.
  Should be rather 1/3 (3.2mm) but I can't change this easily without breaking stuff (castles)

Software needed:
- http://openscad.org/
- http://en.wikibooks.org/wiki/OpenSCAD_User_Manual
Once you installed openscad, then you may have a glance at the manual. Otherwise, just know this:
 - To compile a .scad file (see the result)
   1. Menu: File->Open
   2. menu: Design->Compile
 - To render for real and to export
   1. menu: Design-> Compile and Render (CGAL) .... this can take many minutes.
   2. menu: Design-> Export as .STL 

Usage:
 (1) Create a new .scad file or start from doblo-factory-examples.scad
 (2) Import this file:
     include doblo-factory-1-2.scad
 (3) Set the SCALE variable !!!
 (4) Then, either write custom modules to create any combinations of
 block forms and imported STL or use the merge_brick standard module
 to pile up 3 objects: a doblo, a block and one imported STL

 See examples in the file doblo-factory-examples.scad

Printing:
 - To print larger structures be aware of warping, e.g. make a fat sticky raft and/or use cooling and/or print with PLA.
 - If you need good DUPLO compatibility, you will have to print with small layers !
 - Large structures can take many hours to print. 

To create your own more complex custom shapes, there are several modules (functions). For example:

(1) The doblo brick. 
Typically, to create a DOBLO base (you also can pile them up (union) but may lead to a waste of plastic. Doblo bricks are just like Duplo bricks, however you can make the nibbles on top optional.

module doblo (col, row, up, width,length,height,nibbles_on_off) 

(2) Merge STL files
Positions an stl file, you may have to find out by trial and error what z offset to use. Tip: embed the STL into a doblo or a block.
module merge_stl (file, col, row, stl_z_offset_mm)

(3) Blocks and base plate
To create a building block for larger structures with x,y,z positioning. A block doesn't have nibbles underneath and may or may not have nibbles on top. 

A base plate will have some grid underneath, because printing large flat blocks is usually very difficult. Using "up" other than 0 doesn't make much sense.

module block (col, row, up, width,length,height,nibbles_on_off) 
module base_plate (col, row, up, width,length,height,nibbles_on_off) 

(4) Nibbles.
To insert nibbles on some spots of a nibble-less block or an imported STL. To used in larger structures.

module nibbles (col, row, up, width, length)

(5) Bottom nibbles
To insert underneath an imported STL. Not very usefull I think, I'd rather stick a doblo block to the feet of an imported object.

module bottom_nibbles (col, row, up, width, length, N_height)

(6) Support triangles
Support triangles are used in larger structures to support a roof. 
Thickness = 1 doblo width, e.g. = PART_WIDTH. Sometimes you may want rational numbers. E.g. 1.5
Height/length proportion is 4.8/4 (i.e. typical Lego proportions). Only use angle arg of 0,90,180,270 !!

WARNING: you may want to have these overlap a bit, e.g. if 2 corners are just touching, the model will be not simple and can't be exported as STL. In other words, make them a bit higher (embedded into the block that you will put on the back and the top of the triangles anyhow. See the stronghold example included.
 __
 \|

module support (col,row,up,height,rotation_angle,thickness)

(7) ramp
Is the opposite of the support triangle, but with a flatter angle. Can be used to achor a high and slim block or also to build a real ramp (then you might place 2-4 next to each other.)
Height/length proportion is 4.8/16 (i.e. typical Lego proportions)

module ramp (col,row,up,height,rotation_angle)

(8) Cylinder
Is like a block, but round, i.e. meant to used for larger structures . Can have nibbles on top.

module cyl_block (col, row, up, bottom_r, top_r, height, nibbles_on_off) 

(9) Glyph
Adds a character, based on http://www.thingiverse.com/thing:2054
Size: fits on a 2-x2 doblo unit
height_mm is height in mm. Typically between 2 and 4

module glyph (col, row, up, height_mm, char)

(10) Text
Adds a text, based on http://www.thingiverse.com/thing:2054
Size: fits on a 2-x2 doblo unit
height_mm is height in mm. Typically between 2 and 4

module text (col, row, up, height_mm, chars, count)

*/

// ---------------------------  PARAMETERS -------------------------------------

/*
These define in principle all dimensions. Close to DUPLO dimensions by default. Depending on your printer and your layer/thickness printing parameters you do want to change nibbles and walls.
The settings below are for a layer Thickness of 0.25mm

All units are mm.

Dimensions: 
* A typical small 2x2 nibbles on top DUPLO compatible brick with one nibble underneath is
32mm x 32mm x 19.2mm (plus a nibble height of 4.5mm)
* LEGO-compatible bricks are half that size in all three dimensions

*/

// !!! IMPORTANT !!!!
//  You MUST set the SCALE AND LEGO_DIV variables in the file that imports this library and not here !!!

// Normal size (DUPLO)
// SCALE = 1;
// Lego size - see also the hacks in the code for fixing wall and nibble dimensions
// SCALE = 0.5 ;

// If you plan to print 1/3 height Lego pieces set to true
// LEGO_DIV = false; 

echo (str ("SCALE=", SCALE));

// LEGO SCALE - don't change, allows to create nano legos, should be 1 if real Legos
LEGO_SCALE = 2 * SCALE;
echo (str ("LEGO_SCALE=", LEGO_SCALE));

// Doblo block size
// Real DUPLO Block = 31.7 / 2 = 15.85 (with some variations)
PART_WIDTH   = 16.0  * SCALE;

// Block height (a typical block is 4 * PART_HEIGHT)
// Real Duplo Block = 19.17 / 4 = 4.8
// we also measured 19.09, 19.16
PART_HEIGHT  = ((SCALE < 0.6) && LEGO_DIV) ? ( 3.2 * LEGO_SCALE ) : ( 4.8 * SCALE );
echo (str ("PART HEIGHT=", PART_HEIGHT));

// Diamonds - anti-warping holes - used optionally
DIAMOND = 4;

// Top nibble size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations
NO              = PART_WIDTH / 2.0;              //nibble offset
NBO             = PART_WIDTH ;                   // nibble bottom offset
NH              = (SCALE < 0.6) ? 1.75 * LEGO_SCALE : 4.55 * SCALE;  // LEGO vs. DUPLO 
NB_RADIUS       = (SCALE < 0.6) ? (4.85 / 2 * LEGO_SCALE) : (9.2 / 2.0 * SCALE);    // radius Lego vs. DUPLO
// Real DUPLO Block = 9.38 
NB_RADIUS_INSIDE = 6.8/2  * SCALE;   // was 6.9
// 6.44 = Real DUPLO block

echo (str ("Nibble RADIUS=", NB_RADIUS, " , inside =", NB_RADIUS_INSIDE));

// Bottom nibbles size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations

NB_BOTTOM_RADIUS        = (SCALE < 0.6) ? 6.6/2*LEGO_SCALE : 13.4/2*SCALE;
// Real DUPLO = 13.48  // was 6.5
NB_BOTTOM_RADIUS_INSIDE = (SCALE < 0.6) ? 4.8/2*LEGO_SCALE : 10.8/2*SCALE;
// Real DUPLO = 10.73
// rapman 10.6
// Real Lego = 4.9

echo (str ("Bottom Nibble RADIUS=", NB_BOTTOM_RADIUS, " ,inside=", NB_BOTTOM_RADIUS_INSIDE));

// walls - IMPORTANT: must be adjusted with respect to layer resolution and other slicing considerations
DOBLOWALL = (SCALE < 0.6) ? 1.2 * LEGO_SCALE: 1.55 *SCALE; // Lego vs. Duplo, Lego is not 2x smaller
echo (str ("DOBLOWALL=", DOBLOWALL));

INSET_WIDTH    = (SCALE < 0.6) ? 0.4 *LEGO_SCALE : 1.50 * SCALE; //little inset walls to make it stick
INSET_LENGTH  = (SCALE < 0.6) ? 3*DOBLOWALL : 4*DOBLOWALL; // Legos have proportionally smaller insets

echo (str ("INSET_WIDTH=", INSET_WIDTH, ", INSET_LENGTH=", INSET_LENGTH));

//lattice width and height (optional, see LATTICE_TYPE)
// A grid underneath the flat bridge, crossing through the nibbles underneath
LATTICE_WIDTH   = 1.50 * SCALE;
// 0 means none, 1 means more spacing (same as nibbles underneath),
// 2 means denser
LATTICE_TYPE    = 1; 

// Sizes of a standard 2x2 square brick, normal height
// Not used, but are practical in your custom modules
DOBLOWIDTH  = PART_WIDTH  * 2.0  * SCALE;
DOBLOHEIGHT = PART_HEIGHT * 4.0  * SCALE;
LEGOHEIGHT  = PART_HEIGHT * 3.0  * SCALE; // If LEGO_DIV == true

// -------------------------------- DOBLO and STL merging ------------------------------

// Import an STL and place it.
// Only tested with DUPLOS !!

module merge_stl (file, col, row, up, stl_z_offset_mm) {
    
    // Move STOL right and forward - origin is x=leftmost and y=backmost
    x_offset_mm       =  col * PART_WIDTH + PART_WIDTH ;
    y_offset_mm       =  - (row * PART_WIDTH + PART_WIDTH) ;
    z_offset_mm       =  up * PART_HEIGHT + stl_z_offset_mm ;
    // the STL
    translate([x_offset_mm, y_offset_mm, z_offset_mm])
	{
	    import(file);
	}
}

// --------------- modules made out of our elementary bricks ---------------------------------

// Pillars - not done yet !!

module pillar_lr ()
{
    translate ([0,0,0]) {
	difference () {
	    rotate (a=90, v=[1,0,0]) {
		scale (v=[1,1.6,1]) {
		    difference () {
			cylinder(h = DOBLOHEIGHT, r=PART_WIDTH, $fs = 0.2);
			# translate ([NO,0,-1]) {
			    cylinder(h = DOBLOHEIGHT+2, r=PART_WIDTH, $fs = 0.2);
			}
		    }
		}
	    }
	    # translate ([-DOBLOHEIGHT,-DOBLOHEIGHT-NO,- 2* DOBLOHEIGHT]) {
		cube ([DOBLOHEIGHT*2, DOBLOHEIGHT*2, DOBLOHEIGHT*2]);
	    }
	}
    }
}

// ------------------------------------ Glyphs ----------------------------------------------

module glyph (col, row, up, height, char) {
    size = 2;
    glyph_1 (col, row, up, size, height, char);
}

// if you want to change size. 
// size=2 fits on a 2x2 brick

module glyph_1 (col, row, up, size, height, char) {
    // source is included in this same file, but you could also download bitmap.scad from
    // http://github.com/tbuser/openscad-bitmap and include (uncomment the following line)
    // include <bitmap.scad>;
    size_mm  = size*2*SCALE;
    col_mm    = col    * PART_WIDTH + PART_WIDTH;
    row_mm    =  - ( 0 +  row * PART_WIDTH + PART_WIDTH );
    up_mm     = up  * PART_HEIGHT;
    // letters are a bit smaller thant a 2x2 brick (32mm)
    translate(v = [col_mm, row_mm, up_mm]) {
	rotate (a=270, v=[0,0,1]) {
	    8bit_char(char, size_mm, height);
	}
    }
}

module text (col, row, up, height, chars, count) {
    size = 2 * SCALE ;
    text_1 (col, row, up, size, height, chars, count);
}


module text_1 (col, row, up, size, height, chars, count) {
    // source is included in this same file, but you could also download bitmap.scad from
    // http://github.com/tbuser/openscad-bitmap and include (uncomment the following line)
    // include <bitmap.scad>;
    size_mm  = size*2;
    col_mm    = col    * PART_WIDTH + PART_WIDTH;
    row_mm    =  - ( 0 +  row * PART_WIDTH + PART_WIDTH );
    up_mm     = up  * PART_HEIGHT;
    // letters are a bit smaller thant a 2x2 brick (32mm)
    translate(v = [col_mm, row_mm, up_mm]) {
	rotate (a=270, v=[0,0,1]) {
	    8bit_str (chars, count, size_mm, height);
	}
    }
}


// ----------------------------------- DOBLO bricks making code -------------------------------
// all of these can be used in custom modules, i.e. they respect the grid model

module doblo (col, row, up, width,length,height,nibbles_on_off,diamonds_on_off) 
/* Use cases:
- typical Doblo block, use only once to create the first layer, e.g. a small or larger plate
  that can fit on top of another doblo or Duplo(TM) block.
- See also "block", it doesn't have nibbles underneath and it should be used to build 3D structures
- See also doblo_light, a more light-weight block with just "grid walls" underneath.

*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;

    N_insets_col = length /2 ;
    N_insets_row   = width /2;

    // User info
    echo(str("DOBLO brick width(x)=", width * PART_WIDTH, "mm, length=", length*PART_WIDTH, "mm, height=", height*PART_HEIGHT, "mm" ));
    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the doblo
	union () {
	    if (diamonds_on_off && (width > 1 && length > 1)) {
		difference () {
		    difference() {
			// the cube
			cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
			// inner emptiness, a bit smaller and shifted down
			translate([0,0,-DOBLOWALL]) 	
			    cube([width*PART_WIDTH - 2*DOBLOWALL, length*PART_WIDTH-2*DOBLOWALL, height*PART_HEIGHT], true);
		    }
		    // diamonds
		    diamonds (width, length, height);
		}
	    }
	    else {
		difference() {
		    // the cube
		    cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
		    // inner emptiness, a bit smaller and shifted down
		    translate([0,0,-DOBLOWALL]) 	
			cube([width*PART_WIDTH - 2*DOBLOWALL, length*PART_WIDTH-2*DOBLOWALL, height*PART_HEIGHT], true);
		}
	    }
	    // nibbles on top
	    if  (nibbles_on_off)
		{
		    //           (col,  row,      up,       width, length)
		    nibbles (-width/2, -length/2, height/2, width, length);
		}
	    
	    // nibbles underneath - only if x or y is bigger than 1
	    if (width > 1 && length > 1)
	    {
	        // big nibbles underneath
		bottom_nibbles (width, length, height);
		// lattice (for low resolution printers - e.g. 0.35 layers - this is not needed)
		if (LATTICE_TYPE > 0 )
		    { 
			bottom_lattice (width, length, height);
		    }
	    }
        else
          bottom_nibbles_thin (width, length, height);
	    //little walls inside (insets)
	    difference() 
		{
		    union()
			{
			    for(j=[1:N_insets_col])
				{	
				    for (i = [1:N_insets_row])
					{
					    translate([0,j*NO+(j-1)*NO,0 ])   cube([width*PART_WIDTH, INSET_WIDTH,           height*PART_HEIGHT],true);
					    translate([0,j*-NO+(j-1)*-NO,0 ]) cube([width*PART_WIDTH, INSET_WIDTH,            height*PART_HEIGHT],true);
					    translate([i*NO+(i-1)*NO,0,0 ])   cube([INSET_WIDTH,          length*PART_WIDTH, height*PART_HEIGHT],true);
					    translate([i*-NO+(i-1)*-NO,0,0 ]) cube([INSET_WIDTH,          length*PART_WIDTH, height*PART_HEIGHT],true);	
					}
				}
			}
		    cube([width*PART_WIDTH-INSET_LENGTH, length*PART_WIDTH-INSET_LENGTH, height*PART_HEIGHT+2], true);
		}
	}
    }
}


module nibbles (col, row, up, width, length)
/* Use cases:
- needed by the doblo and the block modules
- can also be stuck on top on parts of a nibble-less doblo or block
*/
{
    // Uses a local coordinate system left/back = 0,0
    // E.g. nibbles (-2,    -2,      0,    4,       4      );
    // echo ("PART_WIDTH", PART_WIDTH, "NO", NO);
    x_start =           col    * PART_WIDTH +  NO ;
    // echo ("x_start", x_start, "col", col);
    y_start =  - (  row * PART_WIDTH + NO);
    // echo ("y_start", y_start, "row", row);
    z_local = up * PART_HEIGHT + NH / 2;
    translate ([x_start , y_start, z_local]) {
	// 0,0 is left/back corner. Draw to the right (x) and forward (-y)
	for(j=[1:length])
	    {
		for (i = [1:width])
		    {
			translate([(i-1) * PART_WIDTH, -(1) * (j-1) * PART_WIDTH, 0]) doblonibble();
		    }
	    }
    }
}

module diamonds (width, length, height)
{
    x_start = -width/2  * PART_WIDTH + NBO;
    y_start = -length/2 * PART_WIDTH + NBO;
    z_pos   = -height * PART_HEIGHT/2+DIAMOND;
    echo (str ("height = ", height, "z_pos= ", z_pos));
    translate ([0, y_start, z_pos]) {
	// holes along y-axis
	for (i = [0:length-2]) {
	    // echo (str ("diamond y offset=", i*PART_WIDTH+PART_WIDTH));
	    translate([0, i* NBO, 0]) 
		rotate (a=45, v=[1,0,0]) { cube([width*PART_WIDTH+PART_WIDTH,DIAMOND,DIAMOND],true); }
	}
    }
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:width-2]) {
	    // echo (str ("diamond x offset=", j*PART_WIDTH-PART_WIDTH));
	    translate([j * NBO, 0, 0]) 
		rotate (a=45, v=[0,1,0]) { cube([DIAMOND,length*PART_WIDTH+PART_WIDTH,DIAMOND],true); }
	}
    }
}

// produces a wider spaced lattice (not used currently)
module bottom_lattice_wide (width, length, height)
{
    x_start = -width/2  * PART_WIDTH + NBO;
    y_start = -length/2 * PART_WIDTH + NBO;
    z_pos   = height * PART_HEIGHT/2 - LATTICE_WIDTH - LATTICE_WIDTH/2;
    translate ([0, y_start, z_pos]) {
	// grid along y-axis
	for (i = [0:length-2]) {
	    translate([0, i* NBO, 0])
		{ cube([width*PART_WIDTH, LATTICE_WIDTH, LATTICE_WIDTH],true); }
	}
    }
    // grid along x-axis
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:width-2]) {
	    translate([j * NBO, 0, 0]) 
		{ cube([LATTICE_WIDTH,length*PART_WIDTH,LATTICE_WIDTH],true); }
	}
    }
}

module bottom_lattice (width, length, height)
{
    spacing = NBO/LATTICE_TYPE;
    x_start = -width/2  * PART_WIDTH + spacing;
    y_start = -length/2 * PART_WIDTH + spacing;
    z_pos   = height * PART_HEIGHT/2 - LATTICE_WIDTH - LATTICE_WIDTH/2;
    translate ([0, y_start, z_pos]) {
	// grid along y-axis
	for (i = [0:LATTICE_TYPE*length-2]) {
	    translate([0, i* spacing, 0])
		{ cube([width*PART_WIDTH, LATTICE_WIDTH, LATTICE_WIDTH],true); }
	}
    }
    // grid along x-axis
    translate ([x_start, 0, z_pos]) {
	// holes along x-axis
	for (j = [0:LATTICE_TYPE*width-2]) {
	    translate([j * spacing, 0, 0]) 
		{ cube([LATTICE_WIDTH,length*PART_WIDTH,LATTICE_WIDTH],true); }
	}
    }
}


module bottom_nibbles_thin (width, length, height)
/* Use cases:
- needed by the doblo module
- can also be stuck into the feet of an imported STL
*/
{
    x_start = -width/2 * PART_WIDTH + NBO;
    y_start = -length/2 * PART_WIDTH + NBO;
    z_local = 0;
    translate ([x_start , y_start, z_local]) {
        if (width == 1){
          for(j=[0:length-2])
          {
              translate([-NBO/2, j * NBO, 0]) doblobottomnibble_thin(height*PART_HEIGHT);
          }
        }
        else if (length == 1){
          for (i = [0:width-2])
          {
              translate([i * NBO, -NBO/2, 0]) doblobottomnibble_thin(height*PART_HEIGHT);
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
    x_start = -width/2 * PART_WIDTH + NBO;
    y_start = -length/2 * PART_WIDTH + NBO;
    z_local = 0;
    translate ([x_start , y_start, z_local]) {
	    for(j=[0:length-2])
		{
		    for (i = [0:width-2])
			{
			    translate([i * NBO, j * NBO, 0]) doblobottomnibble(height*PART_HEIGHT);
			}
		}
    }
}

module block (col, row, up, width,length,height,nibbles_on_off) 
/* Use cases:
- building blocks for 3D structures (saves times and plastic, use a light fill in skeinforge)
- movable blocks for games (printed apart)
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
	// nibbles on top
	if  (nibbles_on_off)
	    {
		//      (col, row, up, width, length)
		nibbles (-width/2, -length/2, height/2, width, length);
	    }
    }
}



module house_lr (col, row, up, width,length,height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;
    roof_l = sqrt ( (length*PART_WIDTH*length*PART_WIDTH) + (length*PART_WIDTH*length*PART_WIDTH ) ) / 2;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
	translate ([0,0,height*PART_HEIGHT/2]) {
	    rotate ([45,0,0]) {
		cube([width*PART_WIDTH, roof_l, roof_l], true);
	    }
	}
    }		
}

module house_fb (col, row, up, width,length,height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along y axis and with a min. height and length ... try ;)
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;
    // That was 40 years ago
    roof_l = sqrt ( (width*PART_WIDTH*width*PART_WIDTH) + (width*PART_WIDTH*width*PART_WIDTH ) ) / 2;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
	translate ([0,0,height*PART_HEIGHT/2]) {
	    rotate ([0,45,0]) {
		cube([roof_l, length*PART_WIDTH, roof_l], true);
	    }
	}
    }		
}


module base_plate (col, row, up, width,length,height,nibbles_on_off) 
/* Use cases:
- Creating an easy to print base plate for showing off your prints. I believe that buying one in a shop is more efficient ....
- to do: an other version that has round holes allowing to stack it.
*/

{
    // construction of the grid underneath
    // spacing = (SCALE < 0.6) ? NBO/LATTICE_TYPE*2 : NBO/LATTICE_TYPE;
    spacing = (SCALE > 0.6) ? NBO : NBO*2;
    offset  = NBO;
    x_start = - width/2  * PART_WIDTH + NBO;
    y_start = - length/2 * PART_WIDTH + NBO;
    z_pos   = (LEGO_DIV) ? height * PART_HEIGHT/2 - LATTICE_WIDTH * 2 : height * PART_HEIGHT/2 - LATTICE_WIDTH - LATTICE_WIDTH/2 ;
    n_rows  = (SCALE > 0.6) ? length-2 : (length-2)/2 ;  // Need less for legos
    n_cols  = (SCALE > 0.6) ? width-2 :  (width-2)/2;

    // positioning of the grid with respect to the cube
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT ;

    difference () {
	block (col, row, up, width,length,height,nibbles_on_off) ;

	union () {
	    translate ([x_0, y_0, z_0])
		{
		    translate ([0, y_start, z_pos]) {
			// grid along y-axis
			for (i = [0:n_rows]) {
			   translate([0, i* spacing, 0])
				{ cube([width*PART_WIDTH-offset*2, LATTICE_WIDTH, LATTICE_WIDTH],true); }
			}
		    }
		    // grid along x-axis
		    translate ([x_start, 0, z_pos]) {
			// holes along x-axis
			for (j = [0:n_cols]) {
			    translate([j * spacing, 0, 0]) 
				{ cube([LATTICE_WIDTH,length*PART_WIDTH-offset*2,LATTICE_WIDTH],true); }
			}
		    }
		}
	}
    }
}


module doblo_light (col, row, up, width,length,height,nibbles_on_off) 
/* Use cases:
A more light-weight blocks with just walls underneath, e.g. ok for pieces of a game that don't really need to stick so well
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;

    N_insets_col = length /2 ;
    N_insets_row   = width /2;
    N_grid_col  = length - 1 - (length  % 2 );
    N_grid_row  = width -1 - (width  % 2 );

    // User info
    echo(str("DOBLO light brick width(x)=", width * PART_WIDTH, "mm, length=", length*PART_WIDTH, "mm, height=", height*PART_HEIGHT, "mm" ));

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	union () {
	    difference() {
		// the cube
		cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
		// inner emptiness, a bit smaller and shifted down
		translate([0,0,-DOBLOWALL]) 	
		    cube([width*PART_WIDTH - 2*DOBLOWALL, length*PART_WIDTH-2*DOBLOWALL, height*PART_HEIGHT], true);
	    }
	    
	    // nibbles on top
	    if  (nibbles_on_off)
		{
		    //             (col, row, up, width, length)
		    nibbles (-width/2, -length/2, height/2, width, length);
		}
	    
	    // criss-cross walls inside
	    union () {
	    for(j=[1:N_grid_col])
		{	
		    translate([j*NBO - width * NO, 0, 0]) cube([INSET_WIDTH,width*PART_WIDTH, height*PART_HEIGHT],true);
		}
 	    for (i = [1:N_grid_row])
 		{
 		    translate([0, (i)*NBO - length * NO ,0 ]) cube([width*PART_WIDTH, INSET_WIDTH, height*PART_HEIGHT],true);
		}
	    }
	    
	    //little walls inside (insets)
	    difference() 
		{
		    union()
			{
			    for(j=[1:N_insets_col])
				{	
				    for (i = [1:N_insets_row])
					{
					    translate([0,j*NO+(j-1)*NO,0 ])   cube([width*PART_WIDTH, INSET_WIDTH,           height*PART_HEIGHT],true);
					    translate([0,j*-NO+(j-1)*-NO,0 ]) cube([width*PART_WIDTH, INSET_WIDTH,           height*PART_HEIGHT],true);
					    translate([i*NO+(i-1)*NO,0,0 ])   cube([INSET_WIDTH,          length*PART_WIDTH, height*PART_HEIGHT],true);
					    translate([i*-NO+(i-1)*-NO,0,0 ]) cube([INSET_WIDTH,          length*PART_WIDTH, height*PART_HEIGHT],true);					}
				}
			}
		    cube([width*PART_WIDTH - INSET_LENGTH,length*PART_WIDTH-INSET_LENGTH,height*PART_HEIGHT+2],true);
		}
	}
    }
}


// ------ Cylinder block

module cyl_block (col, row, up, bottom_r, top_r, height, nibbles_on_off) 
{
    bottom_r_mm = bottom_r * NO;
    top_r_mm    = top_r * NO;
    x_0         = col    * PART_WIDTH   + bottom_r_mm;
    y_0         = - (row * PART_WIDTH   + bottom_r_mm);
    z_0         = up     * PART_HEIGHT;
	
    // the cylinder is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	cylinder(h= height*PART_HEIGHT, r1 = bottom_r_mm, r2 = top_r_mm, center = false, $fs = 0.2);
	if  (nibbles_on_off)
	    {
		//      (col, row,  up,  width, length)
		// circle is a bit different from cube
		nibbles (-top_r/2+0.5, -top_r/2+0.5, height, top_r-1, top_r-1);
	    }
    }
}

// -------------- support block (triangle )

// Support block for building platforms
// so bad ... :(
// NOTE: make the support block stick into something, else it won't print

module support (col,row,up,height,angle,thickness)
{
    if (angle == 0) {
	translate ([0, 0, 0]) {
	    support1 (col,row,up,height,angle,thickness);
	}
    }
    if (angle == 90) {
	translate ([0, -PART_WIDTH , 0]) {
	    support1 (col,row,up,height,angle,thickness);
	}
    }
    if (angle == 180) {
	translate ([PART_WIDTH, -PART_WIDTH - PART_WIDTH* (thickness-1) , 0]) {
	    support1 (col,row,up,height,angle,thickness);
	}
    }
    if (angle == 270) {
	translate ([PART_WIDTH + PART_WIDTH * (thickness-1), 0 , 0]) {
	    support1 (col,row,up,height,angle,thickness);
	}
    }
}


module support1 (col,row,up,height,angle,thickness)
{
    height_mm = height * PART_HEIGHT ;
    length_mm = height * PART_WIDTH / 4;
    width_mm  = PART_WIDTH*thickness; 
    x_0         = col      * PART_WIDTH; 
    y_0         = - (row   * PART_WIDTH); 
    z_0         = up       * PART_HEIGHT;

    translate ([x_0, y_0 , z_0]) {    		
	rotate (a=angle, v=[0,0,1]) {
	polyhedron ( points = [[0, -width_mm, height_mm], [0, 0, height_mm], [0, 0, 0], [0, -width_mm, 0], [length_mm, -width_mm, height_mm], [length_mm, 0, height_mm]], triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}
    }
}


// --------------------- ramp

module ramp (col,row,up,height,angle)
{
    if (angle == 0) {
	translate ([0, -NO, 0]) {
	    ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 90) {
	translate ([NO, -(2*NO) , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 180) {
	translate ([(2*NO), -NO , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
    if (angle == 270) {
	translate ([NO, 0 , 0]) {
	ramp1 (col,row,up,height,angle);
	}
    }
}


module ramp1 (col,row,up,height,angle)
{
    height_mm = height * PART_HEIGHT  ;
    length_mm = height * PART_WIDTH;
    x_0         = col      * PART_WIDTH; 
    y_0         = - (row   * PART_WIDTH); 
    z_0         = up       * PART_HEIGHT;

    translate ([x_0, y_0 , z_0]) {    		
	rotate (a=angle, v=[0,0,1]) {
	polyhedron ( points = [[0, -NO, height_mm], [0, NO, height_mm], [0, NO, 0], [0, -NO, 0], [length_mm, -NO, 0], [length_mm, NO, 0]], triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}
    }
}


//  ---------------------------------- Auxiliary modules ---------------------

module doblonibble() {
    // Lego size does not have holes in the nibbles
    if (SCALE < 0.6) {
	cylinder(r=NB_RADIUS,           h=NH,  center=true,  $fs = 0.2);
    } else {
	difference() {
	    cylinder(r=NB_RADIUS,       h=NH,  center=true,  $fs = 0.2);
	    cylinder(r=NB_RADIUS_INSIDE,h=NH+1,center=true,  $fs = 0.2);
	}
    }
}

module doblobottomnibble_thin(height_mm)
{
  difference() {
    cylinder(r=NB_BOTTOM_RADIUS/2,        h=height_mm,  center=true,$fs = 0.2);
    cylinder(r=NB_BOTTOM_RADIUS_INSIDE/4, h=height_mm+1,center=true,$fs = 0.2);
  }

}
module doblobottomnibble(height_mm)
{
  difference() {
    cylinder(r=NB_BOTTOM_RADIUS,        h=height_mm,  center=true,$fs = 0.2);
    cylinder(r=NB_BOTTOM_RADIUS_INSIDE, h=height_mm+1,center=true,$fs = 0.2);
  }

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

// ------------------------------- end OpenSCAD Bitmap Fonts Module
