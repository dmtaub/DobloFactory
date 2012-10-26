/* Castle kit, Lego and duplo compatible
Daniel.schneider@tecfa.unige.ch
sept. 2012

modified into an extension to doblo-factory v2.0 by:
dmtaub@cemi.org
oct. 2012

Version 1.9
- adapted to work with new library

Version 1.8
- round tower, using more direct openscad functions

Version 1.7
- fixed regression bug and added more elements

Version 1.6
- fixed a bug that didn't allow to generate nano size, e.g. SCALE = 0.25
- Needs doblo-factory-1-11.scad

Versions 1.4 and 1.5
- added some pieces
- needs doblo-factory-1-11.scad !! (i.e. the door/windows substraction block)

Version 1.3
- DUPLO compatible (sort of)

Version 1.2
- more stackable blocks

Version 1.1
- added stackable version of tower
- renamed all stackable bricks with "legobase" suffix

History:
- Version 1.0: first version

Instructions:
- print calibration first. If the piece doesn't fit, then act, i.e. cope with it or adjust the doblo-factory-x-y parameters
- print a chosen module by uncommenting (see below)

*/


// --------------- combi models -----------------
// that was easy :)

module corner_tower ()
{
    tower();
    corner ();
}

// if you got a really large print bed and a printer that can print for days
// Starts upper left corner (seen from top), then row by row

function BLOCK_SIZE(SCALE) = 8*PART_WIDTH(SCALE);
module large_example ()
{
    translate([-BLOCK_SIZE(SCALE), BLOCK_SIZE(SCALE), 0]) {
	rotate (a=90, v=[0,0,1]) { corner (); }};
    translate([0, BLOCK_SIZE(SCALE), 0]) { portal (); };
    translate([BLOCK_SIZE(SCALE), BLOCK_SIZE(SCALE), 0]) { wall_stairs (); };
    translate([2*BLOCK_SIZE(SCALE), BLOCK_SIZE(SCALE), 0]) { corner (); };
    // row 2
    translate([-BLOCK_SIZE(SCALE), 0, 0]) {
	rotate (a=90, v=[0,0,1]) wall_stairs (); };
    base ();	
    translate([BLOCK_SIZE(SCALE), 0 ,0]) { base (); };
    translate([2*BLOCK_SIZE(SCALE), 0, 0]) {
	rotate (a=270, v=[0,0,1]) { wall (); }};

    // row 3
    translate([-BLOCK_SIZE(SCALE), -BLOCK_SIZE(SCALE), 0]) {
	rotate (a=90, v=[0,0,1]) { wall (); }};
    translate([0, -BLOCK_SIZE(SCALE), 0]) { pool (); };
    translate([BLOCK_SIZE(SCALE), -BLOCK_SIZE(SCALE), 0]) { tower (); };
    translate([2*BLOCK_SIZE(SCALE), -BLOCK_SIZE(SCALE), 0]) {
	rotate (a=270, v=[0,0,1]) { wall (); }};
	
    // row 4
    translate([-BLOCK_SIZE(SCALE), -2*BLOCK_SIZE(SCALE), 0]) {
	rotate (a=180, v=[0,0,1]) { corner (); }};
    translate([0, -2*BLOCK_SIZE(SCALE), 0]) {
	rotate (a=180, v=[0,0,1]) wall_stairs (); };
    translate([BLOCK_SIZE(SCALE), -2*BLOCK_SIZE(SCALE), 0]) {
	rotate (a=180, v=[0,0,1]) wall (); };
    // merge
    # translate([2*BLOCK_SIZE(SCALE), -2*BLOCK_SIZE(SCALE), 0]) {
	rotate (a=270, v=[0,0,1]) corner (); };
    # translate([2*BLOCK_SIZE(SCALE), -2*BLOCK_SIZE(SCALE), 0]) {
	rotate (a=270, v=[0,0,1]) tower (); };

}

// ---------------- Models ----------------------


module calibration ()
{
    doblo   (0,   0,   0,   4,   2,    3,  true, false, scale=SCALE );
}

module base ()
{
    base_plate  (-4,  -4,   0,  8,   8,   1 ,     false, scale=SCALE);
    nibbles  (-4,  -4,   1,  8,   2, scale=SCALE);
    nibbles  (-4,  -2,   1,  2,   4, scale=SCALE);
    nibbles  (-4,  2,   1,  8,   2, scale=SCALE);
    nibbles  (2,  -2,   1,  2,   4, scale=SCALE);
}

module base_legobase ()
{
    doblo  (-4,  -4,   0,  8,   8,   2 ,     false, scale=SCALE);
    nibbles  (-4,  -4,  2,  8,   2, scale=SCALE);
    nibbles  (-4,  -2,  2,  2,   4, scale=SCALE);
    nibbles  (-4,  2,   2,  8,   2, scale=SCALE);
    nibbles  (2,  -2,   2,  2,   4, scale=SCALE);
    nibbles  (-1,  -1,   2,  2,   2, scale=SCALE);
}


module base_24 ()
{
    base_plate (-12,  -12,   0,  24,   24,    1,     true, scale=SCALE);
}

module base_16 ()
{
    base_plate  (-8,  -8,   0,  16,   16,    1,     false, scale=SCALE);
    nibbles  (-8,  -8,   1,  16,   2, scale=SCALE);
    nibbles  (-8,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-8,  6,   1,  16,   2, scale=SCALE);
    nibbles  (6,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-4,  -4,   1,  8,   8, scale=SCALE);
}

// --- tower, best within walls
// The roof design is as ugly as it could get, but the printed result is fairly nice ;)

module tower ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2, 1,  8,   4, scale=SCALE);

    // corner towers
    cyl_block   (-4, -4,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (2,  -4,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (-4,  2,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (2,   2,  1,  2,     2,     32,   true, scale=SCALE) ;

    // platform on top
    block       (-3,  -3, 23,  6,   6,    1,     false, scale=SCALE);
    nibbles     (-2,  -2, 24,  4,   4, scale=SCALE);

    // walls on top and support underneath
    block       (-4,  -3, 23,  1,   6,    5,     false, scale=SCALE);
    support     (-4.5,-3, 21,  2,    180, 6, scale=SCALE);
    nibbles     (-4,  -2, 28,  1,   4, scale=SCALE);

    block       (3,  -3, 23,  1,   6,    5,     false, scale=SCALE);
    support     (3.5,  -3, 21,  2,    0, 6, scale=SCALE);
    nibbles     (3,  -2, 28,  1,   4, scale=SCALE);

    block       (-3, -4, 23,  6,  1,    5,     false, scale=SCALE);
    support   (-3, -4.5, 21,  2,  90, 6, scale=SCALE);
    nibbles     (-2, -4, 28,  4,   1, scale=SCALE);

    block       (-3, 3, 23,  6,  1,    5,     false, scale=SCALE);
    support   (-3, 3.5, 21,  2,  270, 6, scale=SCALE);
    nibbles     (-2, 3, 28,  4,   1, scale=SCALE);

    // towers for 2 walls
    cyl_block  (-1, 2, 1,  2,  2,    22,     false, scale=SCALE);
    cyl_block  (-1, -4, 1,  2,  2,    22,     false, scale=SCALE);

    // support for the platform on top
    //        (col, row, up, height,degrees) 

    // support along y axis, more for DUPLOS

    if (SCALE < 0.6)
	{
	    support (-3.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (-3.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	    support (-0.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (-0.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	    support (2.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (2.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	} else
	{
	    support (-3.75, -2.5,  13.5,   10,   270, 1.5, scale=SCALE)	;
	    support (-3.75, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;		
	    support (-0.75, -2.5,  13.5,   10,   270, 1.5, scale=SCALE) ;
	    support (-0.75, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;
	    support (2.25, -2.5,  13.5,   10,   270, 1.5, scale=SCALE) ;
	    support (2.25, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;
	}

    // diagonal support
    if (SCALE < 0.6)
	{
	    support1 (-2.25, -3,  10.5,   13,   315, 1, scale=SCALE) ;
	    support1 (-3,   2.25, 10.5,   13,   45, 1, scale=SCALE) ;
	    support1 (3.0, -2.25, 10.5,   13,   225, 1, scale=SCALE) ;
	    support1 (2.25, 3.0,  10.5,   13,   135, 1, scale=SCALE) ;
	} else
	{
	    support1 (-2, -3,  10.5,   13,   315, 1.5, scale=SCALE) ;
	    support1 (-3.25,   2.25, 10.5,   13,   45, 1.5, scale=SCALE) ;
	    support1 (3.25, -2.25, 10.5,   13,   225, 1.5, scale=SCALE) ;
	    support1 (2.0, 3.0,  10.5,   13,   135, 1.5, scale=SCALE) ;
	}

    // support along x-axis
    if (SCALE < 0.6)
	{
	    support1 (-2.5, -3.5, 16,   7,   0, 1, scale=SCALE) ;
	    support1 (-2.5, 2.5, 16,   7,   0, 1, scale=SCALE) ;
	    support1 (2.5, -2.5, 16,   7,   180, 1, scale=SCALE) ;
	    support1 (2.5, 3.5, 16,   7,   180, 1, scale=SCALE) ;
	} else
	{
	    support1 (-2.5, -3.75, 15,   8,   0, 1.5, scale=SCALE) ;
	    support1 (-2.5, 2.25, 15,   8,   0, 1.5, scale=SCALE) ;
	    support1 (2.5, -2.25, 15,   8,   180, 1.5, scale=SCALE) ;
	    support1 (2.5, 3.75, 15,   8,   180, 1.5, scale=SCALE) ;
	}
}


// --- tower, best within walls
// The roof design is as ugly as it could get

module tower_16 ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-8,  -8,   0,  16,   16,    1,     false, scale=SCALE);
    nibbles  (-8,  -8,   1,  16,   2, scale=SCALE);
    nibbles  (-8,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-8,  6,   1,  16,   2, scale=SCALE);
    nibbles  (6,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-6,  -2,   1,  2,   4, scale=SCALE);
    nibbles  (4,  -2,   1,  2,   4, scale=SCALE);

    // corner towers
    cyl_block   (-4, -4,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (2,  -4,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (-4,  2,  1,  2,    2,     32,   true, scale=SCALE) ;
    cyl_block   (2,   2,  1,  2,     2,     32,   true, scale=SCALE) ;

    // platform on top
    block       (-3,  -3, 23,  6,   6,    1,     false, scale=SCALE);
    nibbles     (-2,  -2, 24,  4,   4, scale=SCALE);

    // walls on top and support underneath
    block       (-4,  -3, 23,  1,   6,    5,     false, scale=SCALE);
    support     (-4.5,-3, 21,  2,    180, 6, scale=SCALE);
    nibbles     (-4,  -2, 28,  1,   4, scale=SCALE);

    block       (3,  -3, 23,  1,   6,    5,     false, scale=SCALE);
    support     (3.5,  -3, 21,  2,    0, 6, scale=SCALE);
    nibbles     (3,  -2, 28,  1,   4, scale=SCALE);

    block       (-3, -4, 23,  6,  1,    5,     false, scale=SCALE);
    support   (-3, -4.5, 21,  2,  90, 6, scale=SCALE);
    nibbles     (-2, -4, 28,  4,   1, scale=SCALE);

    block       (-3, 3, 23,  6,  1,    5,     false, scale=SCALE);
    support   (-3, 3.5, 21,  2,  270, 6, scale=SCALE);
    nibbles     (-2, 3, 28,  4,   1, scale=SCALE);

    // towers for 2 walls
    cyl_block  (-1, 2, 1,  2,  2,    22,     false, scale=SCALE);
    cyl_block  (-1, -4, 1,  2,  2,    22,     false, scale=SCALE);

    // support for the platform on top
    //        (col, row, up, height,degrees) 

    // support along y axis, more for DUPLOS

    if (SCALE < 0.6)
	{
	    support (-3.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (-3.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	    support (-0.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (-0.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	    support (2.5, -2.5,  13.5,   10,   270, 1, scale=SCALE) ;
	    support (2.5, 1.5,  13.5,   10,   90, 1, scale=SCALE) ;
	} else
	{
	    support (-3.75, -2.5,  13.5,   10,   270, 1.5, scale=SCALE)	;
	    support (-3.75, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;		
	    support (-0.75, -2.5,  13.5,   10,   270, 1.5, scale=SCALE) ;
	    support (-0.75, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;
	    support (2.25, -2.5,  13.5,   10,   270, 1.5, scale=SCALE) ;
	    support (2.25, 1.5,  13.5,   10,   90, 1.5, scale=SCALE) ;
	}

    // diagonal support
    if (SCALE < 0.6)
	{
	    support1 (-2.25, -3,  10.5,   13,   315, 1, scale=SCALE) ;
	    support1 (-3,   2.25, 10.5,   13,   45, 1, scale=SCALE) ;
	    support1 (3.0, -2.25, 10.5,   13,   225, 1, scale=SCALE) ;
	    support1 (2.25, 3.0,  10.5,   13,   135, 1, scale=SCALE) ;
	} else
	{
	    support1 (-2, -3,  10.5,   13,   315, 1.5, scale=SCALE) ;
	    support1 (-3.25,   2.25, 10.5,   13,   45, 1.5, scale=SCALE) ;
	    support1 (3.25, -2.25, 10.5,   13,   225, 1.5, scale=SCALE) ;
	    support1 (2.0, 3.0,  10.5,   13,   135, 1.5, scale=SCALE) ;
	}

    // support along x-axis
    if (SCALE < 0.6)
	{
	    support1 (-2.5, -3.5, 16,   7,   0, 1, scale=SCALE) ;
	    support1 (-2.5, 2.5, 16,   7,   0, 1, scale=SCALE) ;
	    support1 (2.5, -2.5, 16,   7,   180, 1, scale=SCALE) ;
	    support1 (2.5, 3.5, 16,   7,   180, 1, scale=SCALE) ;
	} else
	{
	    support1 (-2.5, -3.75, 15,   8,   0, 1.5, scale=SCALE) ;
	    support1 (-2.5, 2.25, 15,   8,   0, 1.5, scale=SCALE) ;
	    support1 (2.5, -2.25, 15,   8,   180, 1.5, scale=SCALE) ;
	    support1 (2.5, 3.75, 15,   8,   180, 1.5, scale=SCALE) ;
	}
}



// --- round tower, best within walls
// The roof design is as ugly as it could get

module tower_round ()
{
    $fs = 0.1;
    $fa = 4;
    //          (col, row, up, width,length,height,nibbles_on_off) 

    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles (-4,  -1, 1,  8,   2, scale=SCALE);
    nibbles (-4,  -4, 1,  1,   1, scale=SCALE);
    nibbles (-4,  3, 1,  1,   1, scale=SCALE);
    nibbles (3,  3, 1,  1,   1, scale=SCALE);
    nibbles (3,  -4, 1,  1,   1, scale=SCALE);

    difference () {
	// tower structure
	union () {
	    difference () {
		cyl_block   (-4,    -4,   1,  8,    8,     32,   false, scale=SCALE) ;
		// carve it out
		cyl_block (-3,    -3,   0,  6,    6,     34,   false, scale=SCALE) ;
		// doors, uses a "house form"
		house_lr   (-5, -1,  0,  10,    2,     10, scale=SCALE) ;
		// holes in the wall on top
		block   (-6, -1,  28,  10,    2,     8,   false, scale=SCALE) ;
		block   (-1, -6,  28,  2,    10,     8,   false, scale=SCALE) ;
	    }
	    // platform on top
	    difference () {
		cyl_block (-3,  -3,   14,  6,    6,     14,   false, scale=SCALE) ;
		cyl_block (-3,  -3,   13.99,  6,    1,  13,   false, scale=SCALE) ;
	    }
	}
	// windows
	house_fb   (-0.5, -5,  16,  1,    10,     6, scale=SCALE) ;
    }
    nibbles (-2,  -2, 28,  4,   4, scale=SCALE);
}

// --- round tower, best within walls
// The roof design is as ugly as it could get
// with respect to the base plate version, this has thinner walls

module tower_round_legobase ()
{
    $fs = 0.1;
    $fa = 4;
    //          (col, row, up, width,length,height,nibbles_on_off) 
    doblo  (-4,  -4,   0,  8,   8,    2,     false, scale=SCALE);
    nibbles (-4,  -1, 2,  8,   2, scale=SCALE);

	union () {
	    // corner towers
	    cyl_block   (-4, -4,  2,  2,    2,     31,   true, scale=SCALE) ;
	    cyl_block   (2,  -4,  2,  2,    2,     31,   true, scale=SCALE) ;
	    cyl_block   (-4,  2,  2,  2,    2,     31,   true, scale=SCALE) ;
	    cyl_block   (2,   2,  2,  2,     2,     31,   true, scale=SCALE) ;
	 	    
	    difference () {
		// tower structure
		union () {
		    difference () {
			cyl_block   (-4,  -4,   2,  8,    8,     31,   false, scale=SCALE) ;
			// carve it out
			cyl_block (-3.5, -3.5,   0,  7,    7,     34,   false, scale=SCALE) ;
			// doors, uses a "house form"
			house_lr   (-5, -1.5,  0,  10,    3,     10, scale=SCALE) ;
			// holes in the wall on top
			block   (-6, -1,  28,  10,    2,     8,   false, scale=SCALE) ;
			block   (-1, -6,  28,  2,    10,     8,   false, scale=SCALE) ;
		    }
		    // platform on top
		    difference () {
			cyl_block (-3.5,  -3.5,   14,     7,    7,  14,   false, scale=SCALE) ;
			cyl_block (-3.5,  -3.5,   13.99,  7,    1,  13,   false, scale=SCALE) ;
		    }
		}
		// windows
		house_fb   (-0.5, -5,  16,  1,    10,     6, scale=SCALE) ;
		house_lr   (-5, -0.5,  16,  10,   1,     6, scale=SCALE) ;
	    }
	    nibbles (-2,  -2, 28,  4,   4, scale=SCALE);
    }
}

// ----- wizard tower (old version, persona will not fit inside)

module wizard_tower_small ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -1,   1,  8,   2, scale=SCALE);
    // bottom nibbles
    nibbles  (-4,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  2,   1,  2,   2, scale=SCALE);
    nibbles  (-4,  2,   1,  2,   2, scale=SCALE);

    // 2nd floor nibbles
    nibbles     (-3,  -1,  21,  6,   2, scale=SCALE);

    // top nibbles
    nibbles     (-2,  -1,  32,  4,  2, scale=SCALE);
    nibbles     (-1,  -2,  32,  2,  1, scale=SCALE);
    nibbles     (-1,  1,  32,  2,  1, scale=SCALE);

    // tower geometry
    length = 5*PART_WIDTH(SCALE);
    width  = 4*PART_WIDTH(SCALE);
    height_top = 37 * PART_HEIGHT(SCALE);
    up     = PART_HEIGHT(SCALE);
    radius = 3*PART_WIDTH(SCALE);

    difference () {
	translate ([0,0,up]) {
	    linear_extrude(height=height_top, center = false, convexity = 5, twist = 360, slices=12) {
		// square ([length,width], center=true);
		circle (r=radius, center=true);
	    }   
	}
	//         (col, row,      up, width,length,height) 
	// bottom
	house_lr   (-5.5, -1.5,     1,  10,    3,    6, scale=SCALE) ;
	house_fb   (-1.5, -2,     1,  3,     4,    6 , scale=SCALE);
	// 1st floor
	house_lr   (-5.5, -0.75,  12,  10,    1.5,    5, scale=SCALE) ;
	house_fb   (-0.5, -5.75,  12,  1,    10,    5, scale=SCALE) ;
	// 2nd floor
	house_lr   (-5.5, -1.5,   21,  10,   3,    6, scale=SCALE) ;
	house_fb (-0.5, -5.75,  21,  1,    10,   6, scale=SCALE) ;
	// top
	cyl_block (-2.25, -2.25,   32,  4.5,    4.5,     8,   false, scale=SCALE) ;
	house_lr   (-5.5, -0.75,  35,  10,    1.5,    5, scale=SCALE) ;
	house_fb (-0.5, -5.75,  35,  1,    10,    5, scale=SCALE) ;
    }
}



// ----- wizard tower

module wizard_tower ()
// revised oct 15 2002
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -1,   1,  8,   2, scale=SCALE);
    // bottom nibbles
    nibbles  (-4,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  2,   1,  2,   2, scale=SCALE);
    nibbles  (-4,  2,   1,  2,   2, scale=SCALE);

    // 2nd floor nibbles
    nibbles     (-3,  -1,  25,  6,   2, scale=SCALE);

    // top nibbles
    nibbles     (-2,  -1,  42,  4,  2, scale=SCALE);
    nibbles     (-1,  -2,  42,  2,  1, scale=SCALE);
    nibbles     (-1,  1,  42,  2,  1, scale=SCALE);

    // tower geometry
    height_top = 47 * PART_HEIGHT(SCALE);
    up     = PART_HEIGHT(SCALE);
    radius = 3*PART_WIDTH(SCALE);

    difference () {
	translate ([0,0,up]) {
	    linear_extrude(height=height_top, center = false, convexity = 5, twist = 360, slices=12) {
		// square ([length,width], center=true);
		circle (r=radius, center=true);
	    }   
	}
	//         (col, row,    up, width,length,height) 
	// bottom
	house_lr   (-5.5, -1.5,   1,  10,    3,    12, scale=SCALE) ;
	house_fb   (-1.5, -2,     1,  3,     4,    12 , scale=SCALE); // inside
	// 1st floor
	house_lr   (-5.5, -0.75,  18,  10,    1.5,    3, scale=SCALE) ;
	house_fb   (-0.5, -5.75,  18,  1,    10,    3, scale=SCALE) ;
	house_fb   (-1.5, -2,     18,  3,     4,    3 , scale=SCALE); // inside
	// 2nd floor
	house_lr   (-5.5, -1.5,   25,  10,   3,    12, scale=SCALE) ;
	house_fb   (-0.5, -5.75,  29,  1,    10,   8, scale=SCALE) ;
	house_fb   (-1.5, -2,     25,  3,     4,    12 , scale=SCALE); // inside
	// top
	cyl_block (-2.25, -2.25,  42,  4.5,    4.5,     8,   false, scale=SCALE) ;
	house_lr   (-5.5, -0.75,  45,  10,    1.5,    5, scale=SCALE) ;
	house_fb (-0.5, -5.75,    45,  1,    10,    5, scale=SCALE) ;
    }
}

// similar but not same tower with legobase
module wizard_tower_legobase ()
// revised oct 15 2002
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    doblo       (-3,  -3,   0,  6,   6,    2,     false, scale=SCALE);
    nibbles     (-3,  -1,   2,  6,   2, scale=SCALE);
    // bottom nibbles
    nibbles  (-3,  -3,   2,  1,   1, scale=SCALE);
    nibbles  (2,  -3,  2,  1,   1, scale=SCALE);
    nibbles  (2,  2,   2,  1,   1, scale=SCALE);
    nibbles  (-3,  2,  2,  1,   1, scale=SCALE);

    // 2nd floor nibbles
    nibbles     (-3,  -1,  22,  6,   2, scale=SCALE);

    // top nibbles
    nibbles     (-2,  -1,  38,  4,  2, scale=SCALE);
    nibbles     (-1,  -2,  38,  2,  1, scale=SCALE);
    nibbles     (-1,  1,  38,  2,  1, scale=SCALE);

    // tower geometry
    height_top = 41 * PART_HEIGHT(SCALE);
    up     = 2*PART_HEIGHT(SCALE);
    radius = 3*PART_WIDTH(SCALE);

    difference () {
	translate ([0,0,up]) {
	    linear_extrude(height=height_top, center = false, convexity = 5, twist = 360, slices=12) {
		// square ([length,width], center=true);
		circle (r=radius, center=true);
	    }   
	}
	//         (col, row,      up, width,length,height) 
	// bottom
	house_lr   (-5.5, -1.5,   2,  10,    3,    12, scale=SCALE) ;
	house_fb   (-1.5, -2,     2,  3,     4,    10 , scale=SCALE);
	// 1st floor
	// house_lr   (-5.5, -0.75,  13,  10,    1.5,    5, scale=SCALE) ;
	house_fb   (-0.5, -5.75,  13,  1,    10,    5, scale=SCALE) ;
	// 2nd floor
	house_lr   (-5.5, -1.5,   22,  10,   3,    10, scale=SCALE) ;
	house_fb   (-0.5, -5.75,  22,  1,    10,   12, scale=SCALE) ;
	// top
	# cyl_block (-2.25, -2.25,   38,  4.5,    4.5,     8,   false, scale=SCALE) ;
	house_lr   (-5.5, -0.75,  40,  10,    1.5,    5, scale=SCALE) ;
	house_fb (-0.5, -5.75,  40,  1,    10,    5, scale=SCALE) ;
    }
}


// ----- wizard tower wide - double wall

module wizard_tower_wide ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-8,  -8,   0,  16,   16,    1,     false, scale=SCALE);
    block       (-1,  0.75,    1,  2,    2,     2,   true, scale=SCALE) ; // stairs
    nibbles  (-8,  -8,   1,  16,   2, scale=SCALE);
    nibbles  (-8,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-8,  6,   1,  16,   2, scale=SCALE);
    nibbles  (6,  -6,   1,  2,   14, scale=SCALE);

    nibbles  (-1, -6, 1,  2,  3, scale=SCALE);
    nibbles  (-1, 3, 1,  2,  2, scale=SCALE);
    nibbles  (-5, -1, 1,  2,  2, scale=SCALE);
    nibbles  (3, -1, 1,  2,  2, scale=SCALE);

    // 1st floor nibbles
    nibbles     (-3,  -1,   6,  6,   2, scale=SCALE);
    // 2nd floor nibbles
    nibbles     (-3,  -1,  25,  6,   2, scale=SCALE);
    // top nibbles
    nibbles     (-2,  -1,  42,  4,  2, scale=SCALE);
    nibbles     (-1,  -2,  42,  2,  1, scale=SCALE);
    nibbles     (-1,  1,  42,  2,  1, scale=SCALE);

    // tower geometry
    length = 5*PART_WIDTH(SCALE);
    width  = 4*PART_WIDTH(SCALE);
    height_top = 48 * PART_HEIGHT(SCALE);
    up     = PART_HEIGHT(SCALE);
    radius = 3*PART_WIDTH(SCALE);

    difference () {
	translate ([0,0,up]) {
	    linear_extrude(height=height_top, center = false, convexity = 5, twist = 360, slices=12) {
		// square ([length,width], center=true);
		circle (r=radius, center=true);
	    }   
	}
	//         (col, row,  up, width,length,height, scale=SCALE) 
	// Bottom
	house_fb   (-1, 1,  1,  2,    3,    12, scale=SCALE) ;
	
	// 1st floor
	house_lr   (-5.5, -1.5,   6,  10,    3,    12, scale=SCALE) ;
	house_fb   (-1.5, -2,     6,  3,     4,    12 , scale=SCALE);
	// 2rd floor
	house_fb   (-1.5, -2,     25,  3,     4,    12 , scale=SCALE); // room
	house_lr   (-5.5, -1.5,   25,  10,   3,    12, scale=SCALE) ; // small windows
	house_fb (-0.5, -5.75,  25,  1,    10,   10, scale=SCALE) ;
	// top
	cyl_block (-2.25, -2.25,   42,  4.5,    4.5,     12,   false, scale=SCALE) ;
	house_lr   (-5.5, -0.75,  45,  10,    1.5,    5, scale=SCALE) ;
	house_fb (-0.5, -5.75,  45,  1,    10,    5, scale=SCALE) ;
    }

    // outerwall
    difference () {
	translate ([0,0,up]) {
	    linear_extrude(height=height_top/4, center = false, convexity = 3, twist = 70, slices=3) {
		// square ([length,width], center=true);
		circle (r=radius*2, center=true);
	    }   
	}
	//         (col, row, up, width,length,height) 
	// Bottom
	house_fb   (-1, -7,  1,  2,    3,    12, scale=SCALE) ;
	// inside
	translate ([0,0,up]) {
	    linear_extrude(height=height_top/4+1, center = false, convexity = 3, twist = 90, slices=3) {
		// square ([length,width], center=true);
		circle (r=radius*2- 0.75 *PART_WIDTH(SCALE), center=true);
	    }   
	}
    }
}



// ---- Stackable tower, more difficult to print correctly

module tower_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    doblo  (-4,  -4,   0,  8,   8,    2,     false, scale=SCALE);
    nibbles     (-4,  -2, 2,  8,   4, scale=SCALE);

    // corner towers
    block   (-4, -4,  2,  2,    2,     31,   true, scale=SCALE) ;
    block   (2,  -4,  2,  2,    2,     31,   true, scale=SCALE) ;
    block   (-4,  2,  2,  2,    2,     31,   true, scale=SCALE) ;
    block   (2,   2,  2,  2,    2,     31,   true, scale=SCALE) ;

    // platform on top
    block       (-3,  -3, 23,  6,   6,    1,     false, scale=SCALE);
    nibbles     (-2,  -2, 24,  4,   4, scale=SCALE);

    // walls on top and support underneath
    block       (-4,  -2, 23,  1,   4,    5,     false, scale=SCALE);
    nibbles     (-4,  -2, 28,  1,   4, scale=SCALE);

    block       (3,  -2, 23,  1,   4,    5,     false, scale=SCALE);
    nibbles     (3,  -2, 28,  1,   4, scale=SCALE);

    block       (-2, -4, 23,  4,  1,    5,     false, scale=SCALE);
    nibbles     (-2, -4, 28,  4,   1, scale=SCALE);

    block       (-2, 3, 23,  4,  1,    5,     false, scale=SCALE);
    nibbles     (-2, 3, 28,  4,   1, scale=SCALE);

    // towers for 2 walls
    block  (-1, 2,  2,  2,  2,    21,     false, scale=SCALE);
    block  (-1, -4, 2,  2,  2,    21,     false, scale=SCALE);

    // support for the platform on top
    //        (col, row, up, height,degrees) 

    // support along y axis
    support (-4, -2,  15,   8,   270, 2, scale=SCALE) ;
    support (-4, 1,  15,   8,   90, 2, scale=SCALE) ;

    support (-1, -2,  15,   8,   270, 2, scale=SCALE) ;
    support (-1, 1,  15,   8,   90, 2, scale=SCALE) ;

    support (2, -2,  15,   8,   270, 2, scale=SCALE) ;
    support (2, 1,  15,   8,   90, 2, scale=SCALE) ;

    // support along x-axis
    support (-2, -4, 18,  5,   0,   2, scale=SCALE) ;
    support (-2, 2, 18,   5,   0,   2, scale=SCALE) ;
    support (1, -4, 18,   5,   180, 2, scale=SCALE) ;
    support (1,  2, 18,   5,   180,   2, scale=SCALE) ;
}



// --- tower floor module, can be stacked, also on base

module tower_floor_legobase ()
{
    //       (col, row, up, width,length,height,nibbles_on_off) 
    block    (-4,  -4, 19,  8,   8,    1,     false, scale=SCALE);
    nibbles  (-4,  -2, 20,  8,   4, scale=SCALE);

    // towers, 3 on two sides
    block   (-4, -4,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (-4, -4,  0,  2,    2,     2,   true, scale=SCALE) ;

    block   (-1, -4,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (-1, -4,  0,  2,    2,     2,   true, scale=SCALE) ;

    block   (2,  -4,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (2,  -4,  0,  2,    2,     2,   true, scale=SCALE) ;

    block   (-4,  2,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (-4,  2,  0,  2,    2,     2,   true, scale=SCALE) ;

    block   (-1,  2,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (-1,  2,  0,  2,    2,     2,   true, scale=SCALE) ;

    block   (2,   2,  2,  2,    2,     22,   true, scale=SCALE) ;
    doblo   (2,   2,  0,  2,    2,     2,   true, scale=SCALE) ;

    // support
    support (-4, 1, 11,  8,    90, 2, scale=SCALE);
    support (-1, 1, 11,  8,    90, 2, scale=SCALE);
    support (2, 1, 11,  8,     90, 2, scale=SCALE);
    support (-4, -2, 11,  8,    270, 2, scale=SCALE);
    support (-1, -2, 11,  8,    270, 2, scale=SCALE);
    support (2, -2, 11,  8,     270, 2, scale=SCALE);

    // small supports
    support1 (-2.5, -4, 12,   7,   0, 2, scale=SCALE) ;
    support1 (-2.5, 2, 12,   7,   0, 2, scale=SCALE) ;
    support1 (2.5, -2, 12,   7,   180, 2, scale=SCALE) ;
    support1 (2.5, 4, 12,   7,   180, 2, scale=SCALE) ;

}

// --- tower floor module, can be stacked, also on base

module tower_roof_legobase ()
{
    //       (col, row, up, width,length,height,nibbles_on_off) 

    // towers, 3 on two sides
    doblo   (-4, -4,  0,  8,    2,     2,   true, scale=SCALE) ;
    block   (-4, -4,  2,  2,    1,     6,   false, scale=SCALE) ;
    block   (-1, -4,  2,  2,    1,     6,   false, scale=SCALE) ;
    block   (2,  -4,  2,  2,    1,     6,   false, scale=SCALE) ;

    doblo   (-4,  2,  0,  8,    2,     2,   true, scale=SCALE) ;
    block   (-4,  3,  2,  2,    1,     6,   false, scale=SCALE) ;
    block   (-1,  3,  2,  2,    1,     6,   false, scale=SCALE) ;
    block   (2,  3,  2,  2,    1,     6,   false, scale=SCALE) ;

    // house on top
    difference () {
	//         (col, row, up, width,length,height) 
	house_lr  (-4, -4,  8,  8,    8,  10, scale=SCALE) ;
	house_lr  (-5, -3,  7,  10,    6,  9, scale=SCALE) ;
	house_fb  (-2, -5,  7.5,  1,  10,    3 , scale=SCALE);
	house_fb  (1, -5,  7.5,  1,  10,    3 , scale=SCALE);
    }
    // pillar in the middle
    doblo   (-1,  -1,  0 ,  2,   2,  2,   true, scale=SCALE) ;
    support (-1,  1 , 11,  8,     270, 2, scale=SCALE);
    support (-1,  -2 , 11,  8,     90, 2, scale=SCALE);
    block   (-1,  -1,  2 ,  2,   2,  26,   true, scale=SCALE) ;
}

// --- floor_pillars, stackable plate with pillars
// print the first layer real slow and calibrate openscad first !

module pillars_legobase ()
{
    //       (col, row, up, width,length,height,nibbles_on_off) 
    doblo    (-4,  -4, 0,  8,   8,    2,     false, scale=SCALE);
    nibbles  (-4,  -2, 2,  8,   4, scale=SCALE);
    nibbles  (-2,  -4, 2,  4,   2, scale=SCALE);
    nibbles  (-2,  2, 2,  4,   2, scale=SCALE);

    // towers, 3 on two sides
    block   (-4, -4,  2,  2,    2,     22,   true, scale=SCALE) ;
    block   (2,  -4,  2,  2,    2,     22,   true, scale=SCALE) ;
    block   (-4,  2,  2,  2,    2,     22,   true, scale=SCALE) ;
    block   (2,   2,  2,  2,    2,     22,   true, scale=SCALE) ;

}


// ----------------- Simple wall

module wall ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2,   1,  8,   6, scale=SCALE);
    // the wall
    block       (-4,  -4,   1,  8,   2,   23 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  8,   1, scale=SCALE);
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
}

// ----------------- wall

module wall_thin ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2,   1,  8,   6, scale=SCALE);
    // the wall
    block       (-4,  -4,   1,  8,   1,   23 ,     false, scale=SCALE);
    block       (-4,  -3,   23,  8,   1,   1 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  8,   1, scale=SCALE);
    // pillars for the wall
    block       (-4,  -3,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-1,  -3,   1,  2,   1,   22 ,     false, scale=SCALE);
    block       (3,  -3,   1,  1,   1,   22 ,     false, scale=SCALE);
    support     (-3,  -3,   19,  4,   270,   2, scale=SCALE) ;
    support     (1,  -3,   19,  4,   270,   2, scale=SCALE) ;
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
}

// ----------------- wall on a 16x16 base

module wall_thin_16 ()
{
    //          (col, row, up, width,length,height,nibbles_on_off, scale=SCALE) 
    base_plate  (-8,  -8,   0,  16,   16,    1,     false, scale=SCALE);

    // the wall
    block       (-8,  -8,   1,   16,   1,   23 ,     false, scale=SCALE);
    // inner block on top
    block       (-8,  -7,   23,  16,   1,   1 ,     false, scale=SCALE);
    nibbles     (-8,  -7,   24,  16,   1, scale=SCALE);
    // pillars for the wall
    block       (-8,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-5,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-2,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (1,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (4,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (7,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);

    support     (-7.5,  -7,   19,  4,   270,   15.5, scale=SCALE) ;
    // small blocks on top
    block       (-8,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-5,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-2,  -8,   24,  4,   1,   4 ,     true, scale=SCALE);
    block       ( 3,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 6,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    // nibbles on the plate

    nibbles  (-8,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-8,  6,   1,  16,   2, scale=SCALE);
    nibbles  (6,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-4,  -4,   1,  8,   8, scale=SCALE);
}

module wall_stairs_16_8 ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-8,  -4,   0,  16,   8,    1,     false, scale=SCALE);

    // the wall
    block       (-8,  -4,   1,   16,   1,   23 ,     false, scale=SCALE);
    // inner block on top
    block       (-8,  -3,   23,  16,   1,   1 ,     false, scale=SCALE);
    nibbles     (-8,  -3,   24,  16,   1, scale=SCALE);

    // stairs
    // 1
    block       (-6,  -3,   1,  2,   2,   3 ,     true, scale=SCALE);

    //2
    block       (-4,  -3,   5,  2,   2,   2 ,     true, scale=SCALE);
    block       (-4,  -2,   1,  2,   1,   4 ,     false, scale=SCALE);
    //          col  row   up  height, deg, width
    support     (-4,  -3,   2.01,  3,   270,   2, scale=SCALE) ;

    // 3
    block       (-2,  -3,   8,  2,   2,  2  ,     true, scale=SCALE);
    block       (-2,  -2,   1,  2,   1,   8 ,     false, scale=SCALE);
    support     (-2,  -3,   5.01,  3,   270,   2, scale=SCALE) ;

    // 4
    block       (0,  -3,   11,  2,   2,   2 ,     true, scale=SCALE);
    block       (0,  -2,   1,  2,   1,   11 ,     false, scale=SCALE);
    support     (0,  -3,   8.01,  3,   270,   2, scale=SCALE) ;

    block       (2,  -3,   14,  2,   3,   2 ,     true, scale=SCALE);
    block       (2,  -2,   1,  2,   1,   14 ,     false, scale=SCALE);
    support     (2,  -3,   11.01,  3,   270,   2, scale=SCALE) ;
    support     (2,  -1,   10.01,  4,   270,   2, scale=SCALE) ;

    // that should get me into architecture school
    block       (4,  -3,   17,  2,   3,   2 ,     true, scale=SCALE);
    block       (4,  -2,   1,   2,   1,   17 ,     false, scale=SCALE);
    support     (4,  -3,   14.01,  3,   270,   2, scale=SCALE) ;
    support     (4,  -1,   13.01,  4,   270,   2, scale=SCALE) ;

    // last step
    block       (6,  -3,   20,  2,   3,   2 ,     true, scale=SCALE);
    block       (6,  -2,   1,   2,   1,   20 ,     false, scale=SCALE);
    support     (6,  -3,   17.01,  3,   270,   2, scale=SCALE) ;
    support     (6,  -1,   16.01,  4,   270,   2, scale=SCALE) ;


    // pillars for the wall
    block       (-8,  -3,   1,  1,   1,   22 ,     false, scale=SCALE);

    support     (-7.5,  -3,   19.01,  4,   270,   15.5, scale=SCALE) ;
    // small blocks on top
    block       (-8,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-5,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-2,  -4,   24,  4,   1,   4 ,     true, scale=SCALE);
    block       ( 3,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 6,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    // nibbles on the plate

    nibbles  (-8,  -2,   1,  2,   6, scale=SCALE);

    nibbles  (6,  -2,   1,  2,   6, scale=SCALE);
    nibbles  (-6,  2,   1,  12,   2, scale=SCALE);
}


// ---- Wall that is stackable

module wall_thin_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    doblo       (-4,  -4,   0,  8,   2,    2,     false, scale=SCALE);

    // the wall
    block       (-4,  -4,   2,  8,   1,   22 ,     false, scale=SCALE);
    block       (-4,  -3,   22,  8,   1,   1 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   23,  8,   1, scale=SCALE);
    // pillars for the wall
    block       (-4,  -3,   2,  1,   1,   21 ,     false, scale=SCALE);
    block       (-1,  -3,   2,  2,   1,   21 ,     false, scale=SCALE);
    block       (3,  -3,   2,  1,   1,   21 ,     false, scale=SCALE);
    support     (-3,  -3,   18,  4,   270,   2, scale=SCALE) ;
    support     (1,  -3,   18,  4,   270,   2, scale=SCALE) ;
    // small blocks on top
    block       (-4,  -4,   23,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   23,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   23,  2,   1,   4 ,     true, scale=SCALE);
}

module wall_connector ()
{
    doblo       (-4,  -4,   0,  8,   1,    4,     true, scale=SCALE);
}

// ----------------- portal

module portal ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2,   1,  2,   6, scale=SCALE);
    nibbles     (2,  -2,   1,  2,   6, scale=SCALE);
    nibbles     (-2,  -4,   1,  4,   2, scale=SCALE);
    nibbles     (-2,  2,   1,  4,   2, scale=SCALE);
    // the wall
    block       (-4,  -4,   20,  8,   2,   4 ,     false, scale=SCALE);
    block       (-4,  -4,   1,  2,   2,   19 ,     false, scale=SCALE);
    block       (2,  -4,   1,  2,   2,   19 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  8,   1, scale=SCALE);
    // top of door - 8.5 to avoid manifold
    support     (1,  -4,   12,  8.5,   180,   2, scale=SCALE) ;
    support     (-2,  -4,   12,  8.5,   0,   2, scale=SCALE) ;
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
}



// ----------------- A wall with stairs

module wall_stairs ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  0,   1,  8,   4, scale=SCALE);
    // the wall
    block       (-4,  -4,   1,  8,   2,   23 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  8,   1, scale=SCALE);
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // stairs
    block       (-4,  -2,   4,  2,   2,   2 ,     true, scale=SCALE);
    block       (-4,  -1,   1,  2,   1,   3 ,     false, scale=SCALE);
    //          col  row   up  height, deg, width
    support     (-4,  -2,   1,  3,   270,   2, scale=SCALE) ;

    block       (-2,  -2,   9,  2,   2,  2  ,     true, scale=SCALE);
    block       (-2,  -1,   1,  2,   1,   8 ,     false, scale=SCALE);
    support     (-2,  -2,   6,  3,   270,   2, scale=SCALE) ;

    block       (0,  -2,   14,  2,   2,   2 ,     true, scale=SCALE);
    block       (0,  -1,   1,  2,   1,   13 ,     false, scale=SCALE);
    support     (0,  -2,   11,  3,   270,   2, scale=SCALE) ;

    block       (2,  -2,   19,  2,   2,   2 ,     true, scale=SCALE);
    block       (2,  -1,   1,  2,   1,   18 ,     false, scale=SCALE);
    support     (2,  -2,   16,  3,   270,   2, scale=SCALE) ;
}

// ----------------- A wall with stairs, stackable

module wall_stairs_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    // the wall
    doblo       (-4,  -4,   0,  8,   4,   2 ,     false, scale=SCALE);
    block       (-4,  -4,   2,  8,   2,   22 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  8,   1, scale=SCALE);
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // stairs
    block       (-4,  -2,   4,  2,   2,   2 ,     true, scale=SCALE);
    block       (-4,  -1,   2,  2,   1,   2 ,     false, scale=SCALE);
    //          col  row   up  height, deg, width
    # support     (-4,  -2,   1.9,  3.1,   270,   2.0, scale=SCALE) ;

    block       (-2,  -2,   9,  2,   2,  2  ,     true, scale=SCALE);
    block       (-2,  -1,   2,  2,   1,   7 ,     false, scale=SCALE);
    support     (-2,  -2,   5.9,  3.1,   270,   2, scale=SCALE) ;

    block       (0,  -2,   14,  2,   2,   2 ,     true, scale=SCALE);
    block       (0,  -1,   2,  2,   1,   12 ,     false, scale=SCALE);
    support     (0,  -2,   10.9,  3.1,   270,   2, scale=SCALE) ;

    block       (2,  -2,   19,  2,   2,   2 ,     true, scale=SCALE);
    block       (2,  -1,   2,  2,   1,   17 ,     false, scale=SCALE);
    support     (2,  -2,   15.9,  3.1,   270,   2, scale=SCALE) ;
}



// ------------------ corner, just two walls

module corner ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2,   1,  6,   6, scale=SCALE);
    // the wall
    block       (-4,  -4,   1,  8,   2,   23 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  7,   1, scale=SCALE);
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // the wall
    block       (2,  -2,   1,  2,   6,   23 ,     false, scale=SCALE);
    nibbles     (2,  -3,   24,  1,   7, scale=SCALE);
    // small blocks on top
    block       (3,  -3,   24,  1,   1,   4 ,     true, scale=SCALE);
    block       (3,  -1,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (3,  2,   24,  1,   2,   4 ,     true, scale=SCALE);

}

// ------------------ corner, just two walls

module corner_thin ()
{
    //          (col, row, up, width,length,height,nibbles_on_off, scale=SCALE) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles     (-4,  -2,   1,  6,   6, scale=SCALE);
    // the wall
    block       (-4,  -4,   1,  8,   1,   23 ,     false, scale=SCALE);
    block       (-4,  -3,   23,  8,   1,   1 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  7,   1, scale=SCALE);
    // pillars for the wall
    block       (-4,  -3,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-1,  -3,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (2,   -3,   1,  2,   1,   22 ,     false, scale=SCALE);
    support     (-3,  -3,   19,  4,   270,   6, scale=SCALE) ;

    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // the wall
    block       (3,  -2,   1,  1,   6,   23 ,     false, scale=SCALE);
    block       (2,  -2,   23,  1,   6,   1 ,     false, scale=SCALE);
    nibbles     (2,  -3,   24,  1,   7, scale=SCALE);
    // pillars for the wall
    block       (2,  0,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (2,  3,   1,  1,   1,   22 ,     false, scale=SCALE);
    support     (2,  -3,   19,  4,   180,   6, scale=SCALE) ;
    // small blocks on top
    block       (3,  -3,   24,  1,   1,   4 ,     true, scale=SCALE);
    block       (3,  -1,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (3,  2,   24,  1,   2,   4 ,     true, scale=SCALE);

}

// ----------------- thin corner on a 16x16 base

module corner_thin_16 ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-8,  -8,   0,  16,   16,    1,     false, scale=SCALE);

    // the wall
    block       (-8,  -8,   1,   16,   1,   23 ,     false, scale=SCALE);
    // inner block on top
    block       (-8,  -7,   23,  16,   1,   1 ,     false, scale=SCALE);
    nibbles     (-8,  -7,   24,  15,   1, scale=SCALE);
    // pillars for the wall
    block       (-8,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-5,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (-2,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (1,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (4,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (7,  -7,   1,  1,   1,   22 ,     false, scale=SCALE);

    support     (-7,  -7,   19,  4,   270,   14, scale=SCALE) ;
    // small blocks on top
    block       (-8,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-5,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-2,  -8,   24,  4,   1,   4 ,     true, scale=SCALE);
    block       ( 3,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 6,  -8,   24,  2,   1,   4 ,     true, scale=SCALE);

    // the other wall
    block       (7,  -6,   1,   1,   14,   23 ,     false, scale=SCALE);
    nibbles     (6,  -6,   24,  1,   14, scale=SCALE);    
    block       (6,  -6,   23,  1,   14,   1 ,     false, scale=SCALE);
    // pillars for the wall
    block       (6,  -5,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (6,  -2,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (6,   1,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (6,   4,   1,  1,   1,   22 ,     false, scale=SCALE);
    block       (6,   7,   1,  1,   1,   22 ,     false, scale=SCALE);
    // small blocks on top
    block       (7,  -7,   24,  1,   1,   4 ,     true, scale=SCALE);
    block       (7,  -5,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (7,  -2,   24,  1,   4,   4 ,     true, scale=SCALE);
    block       (7,  3,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (7,  6,   24,  1,   2,   4 ,     true, scale=SCALE);
    // support
    support     (6,  -7,   19,  4,   180,   15, scale=SCALE) ;
    // nibbles on the plate

    nibbles  (-8,  -6,   1,  2,   14, scale=SCALE);
    nibbles  (-8,  6,   1,  14,   2, scale=SCALE);
    nibbles  (-4,  -4,   1,  8,   8, scale=SCALE);

}

// ------------------ corner, just two thinner walls

module corner_thin_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    // duplo base
    doblo       (-4,  -4,   0,  8,   2,    2,     false, scale=SCALE);
    doblo       (2,   -2,   0,  2,   6,    2,     false, scale=SCALE);
    // the wall
    block       (-4,  -4,   2,  8,   1,   22 ,     false, scale=SCALE);
    block       (-4,  -3,   23,  8,   1,   1 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  7,   1, scale=SCALE);
    // pillars for the wall
    block       (-4,  -3,   2,  1,   1,   21 ,     false, scale=SCALE);
    block       (-1,  -3,   2,  1,   1,   21 ,     false, scale=SCALE);
    block       (2,   -3,   2,  2,   1,   21 ,     false, scale=SCALE);
    support     (-3,  -3,   19,  4,   270,   6, scale=SCALE) ;

    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // the wall
    block       (3,  -2,   2,  1,   6,   23 ,     false, scale=SCALE);
    block       (2,  -2,   23,  1,   6,   1 ,     false, scale=SCALE);
    nibbles     (2,  -3,   24,  1,   7, scale=SCALE);
    // pillars for the wall
    block       (2,  0,   2,  1,   1,   21 ,     false, scale=SCALE);
    block       (2,  3,   2,  1,   1,   21 ,     false, scale=SCALE);
    support     (2,  -3,   19,  4,   180,   6, scale=SCALE) ;
    // small blocks on top
    block       (3,  -3,   24,  1,   1,   4 ,     true, scale=SCALE);
    block       (3,  -1,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (3,  2,   24,  1,   2,   4 ,     true, scale=SCALE);
}


// ------------------ corner, just two walls

module corner_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    // the wall
    doblo       (-4,  -4,   0,  8,   2,   24 ,     false, scale=SCALE);
    nibbles     (-4,  -3,   24,  7,   1, scale=SCALE);
    // small blocks on top
    block       (-4,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       (-1,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);
    block       ( 2,  -4,   24,  2,   1,   4 ,     true, scale=SCALE);

    // the wall
    doblo       (2,  -2,   0,  2,   6,   24 ,     false, scale=SCALE);
    nibbles     (2,  -3,   24,  1,   7, scale=SCALE);
    // small blocks on top
    block       (3,  -3,   24,  1,   1,   4 ,     true, scale=SCALE);
    block       (3,  -1,   24,  1,   2,   4 ,     true, scale=SCALE);
    block       (3,  2,   24,  1,   2,   4 ,     true, scale=SCALE);

}



// ---------------------- pool, any castly must have one
// includes some openscad code

module pool ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    base_plate  (-4,  -4,   0,  8,   8,    1,     false, scale=SCALE);
    nibbles  (-4,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  -4,   1,  2,   2, scale=SCALE);
    nibbles  (2,  2,   1,  2,   2, scale=SCALE);
    nibbles  (-4,  2,   1,  2,   2, scale=SCALE);

    difference () {
	hull () {
	    cyl_block   (-3, -2,  1,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (-0.5,   -3,  1,    2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1,  -2,  1,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (-2,    1,  1,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1.5,   0,  1,  2,    2,   6,   false, scale=SCALE) ;   
	}
	hull () {
	    cyl_block   (-2, -1.5,  1,  1,    2,   6,   false, scale=SCALE) ;   
	    cyl_block  (-0.5,  -2,  1,    1,    2,   6,   false, scale=SCALE) ;   
	    # cyl_block   (-1.5,    0.5,  1,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1,   -0.5,  1,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (0.5,  -1.5,  1,  1,    2,   6,   false, scale=SCALE) ;   
	}
    }
}

// ---------------------- pool, stackable any castly must have one
// includes some openscad code

module pool_legobase ()
{
    //          (col, row, up, width,length,height,nibbles_on_off) 
    doblo  (-4,  -4,   0,  8,   8,    2,     false, scale=SCALE);
    nibbles  (-4,  -4,   2,  2,   2, scale=SCALE);
    nibbles  (2,  -4,   2,  2,   2, scale=SCALE);
    nibbles  (2,  2,   2,  2,   2, scale=SCALE);
    nibbles  (-4,  2,   2,  2,   2, scale=SCALE);

    difference () {
	hull () {
	    cyl_block   (-3, -2,  2,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (-0.5,   -3,  2,    2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1,  -2,  2,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (-2,    1,  2,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1.5,   0,  2,  2,    2,   6,   false, scale=SCALE) ;   
	}
	hull () {
	    cyl_block   (-2, -1.5,  2,  1,    2,   6,   false, scale=SCALE) ;   
	    cyl_block  (-0.5,  -2,  2,    1,    2,   6,   false, scale=SCALE) ;   
	    # cyl_block   (-1.5,    0.5,  2,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (1,   -0.5,  2,  2,    2,   6,   false, scale=SCALE) ;   
	    cyl_block   (0.5,  -1.5,  2,  1,    2,   6,   false, scale=SCALE) ;   
	}
    }
}

// ---- some legos/duplos

module bricks () {
    if (LEGO_DIV && (SCALE < 0.6))
	{
	    //    (col, row, up, width,length,height,nibbles_on_off, diamonds) 
	    doblo (0,   0,   0,   4,   2,    3,  true, false , scale=SCALE);
	    doblo (5,   0,   0,   1,   2,    3,  true, false , scale=SCALE);
	    doblo (7,   0,   0,   1,   2,    3,  true, false , scale=SCALE);
	    doblo (0,   3,   0,   2,   2,    3,  true, false , scale=SCALE);
	    doblo (-3,   3,   0,   2,   2,    3,  true, false , scale=SCALE);
	    doblo (3,   3,   0,   2,   2,    2,  false, false , scale=SCALE);
	    block (3,   3,   2,   2,   2,    4,  true, false , scale=SCALE);
	    doblo (6,   3,   0,   2,   2,    2,  false, false , scale=SCALE);
	    block (6,   3,   2,   2,   2,    4,  true, false , scale=SCALE);
	    doblo (0,   -3,   0,  8,  2,    3,  true, false , scale=SCALE);
	    doblo (-5,   -3,   0,  4,  4,    2,  true, false , scale=SCALE);
	} else
	{
	    doblo (0,   0,   0,   4,   2,    4,  true, false , scale=SCALE);
	    doblo (0,   3,   0,   2,   2,    4,  true, false , scale=SCALE);
	    doblo (3,   3,   0,   2,   2,    8,  true, false , scale=SCALE);
	    doblo (0,   -3,   0,  8,  2,    4,  true, false , scale=SCALE);
	    doblo (-5,   -3,   0,  4,  4,    2,  true, false , scale=SCALE);
	}
}

// for connecting base plates
module bricks_flat () {
    if (LEGO_DIV && (SCALE < 0.6))
	{
	    //    (col, row, up, width,length,height,nibbles_on_off, diamonds) 
	    doblo (0,   3,   0,   2,   4,    1,  false, false , scale=SCALE);
	    doblo (3,   3,   0,   2,   4,    1,  true, false , scale=SCALE);
	    doblo (0,   0,  0,    8,   2,    1,  true, false , scale=SCALE);
	    doblo (0,  -3,  0,    8,   2,    1,  false, false , scale=SCALE);
	    doblo (6,  3,  0,     2,   4,    1,  true, false , scale=SCALE);
	} else
	{
	    //    (col, row, up, width,length,height,nibbles_on_off, diamonds, scale=SCALE) 
	    doblo (0,   3,   0,   2,   4,    1,  false, false , scale=SCALE);
	    doblo (3,   3,   0,   2,   4,    1,  true, false , scale=SCALE);
	    doblo (0,   0,  0,    8,   2,    1,  true, false , scale=SCALE);
	    doblo (0,  -3,  0,    8,   2,    1,  false, false , scale=SCALE);
	    doblo (6,  3,  0,     2,   4,    1,  true, false , scale=SCALE);
	}
}
