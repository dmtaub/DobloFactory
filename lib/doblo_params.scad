/*

This file is part of LibDoblo
DOBLO: DUPLO-compatible scenery factory

-------------------------
PARAMETERS              -
-------------------------

These define in principle all dimensions. 

Close to DUPLO dimensions by default. Depending on your printer and your layer/thickness printing parameters you do want to change nibbles and walls.
The settings below are for a layer Thickness of 0.25mm

All units are mm.

Dimensions: 
* A typical small 2x2 nibbles on top DUPLO compatible brick with one nibble underneath is
32mm x 32mm x 19.2mm (plus a nibble height of 4.5mm)
* LEGO-compatible bricks are half that size in all three dimensions

*/

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

// DATA FOR QUATRO (DMT)
// nibble outter diam: 18.45 
// nibble inner diam: 14.45 
// nibble inner nub(for duplo) diam: 13.25 


// Top nibble size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations
NO              = PART_WIDTH / 2.0;              //nibble offset
NBO             = PART_WIDTH ;                   // nibble bottom offset
NH              = (SCALE < 0.6) ? 1.75 * LEGO_SCALE : 4.55 * SCALE;  // LEGO vs. DUPLO 
NB_RADIUS       = (SCALE < 0.6) ? (4.9 / 2 * LEGO_SCALE) : (9.2 / 2.0 * SCALE);    // radius Lego vs. DUPLO
// Real DUPLO Block = 9.38 
NB_RADIUS_INSIDE = 6.8/2  * SCALE;  
// 6.44 = Real DUPLO block

NB_THICKNESS=NB_RADIUS-NB_RADIUS_INSIDE;

// For square nibble supports in 1xM or Nx1 blocks
ALONG_LEN  = (PART_WIDTH-NB_RADIUS)/1.7; //tighter fit than 1.8
CROSS_LEN  = (PART_WIDTH-NB_RADIUS/2);

echo (str ("Nibble RADIUS=", NB_RADIUS, " , inside =", NB_RADIUS_INSIDE));

// Bottom nibbles size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations

NB_BOTTOM_RADIUS        = (SCALE < 0.6) ? 6.5/2*LEGO_SCALE : 13.4/2*SCALE;
// Real DUPLO = 13.48
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

