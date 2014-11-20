/*

 Copyright (c) 2013 Daniel M. Taub
 Copyright (c) 2010 Daniel K. Schneider
 
 This file is part of DobloFactory.

 DobloFactory is free source: you can redistribute it and/or modify
    modify it under the terms of the CC BY-NC-SA 3.0 License:
    CreativeCommons Attribution-NonCommerical-ShareAlike 3.0
    as published by Creative Commons. 

    You should have received a copy of the CC BY-NC-SA 3.0 License 
    with this source package. 
    If not, see <http://creativecommons.org/licenses/by-nc-sa/3.0/>

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

// replicator is 12 x 7 duplo-sized units

// DATA FOR QUATRO (DMT)
// nibble outter diam: 18.45 
// nibble inner diam: 14.45 
// nibble inner nub(for duplo) diam: 13.25 

// Normal size (DUPLO)
// SCALE = 1;
// Lego size - see also the hacks in the code for fixing wall and nibble dimensions
// SCALE = 0.5 ;
// Mini Lego size 
// SCALE = 0.25

CADRO = 2; // not yet tested
DOBLO = 1;
LUGO = 0.5;
MINI = 0.25;

HALF=3;
THIRD=2;
FULL=6;

// LEGO SCALE - don't change, allows to create nano legos, should be 1 if real Legos
function LEGO_SCALE(SCALE) = 2 * SCALE;

// Doblo block size
// Real DUPLO Block = 31.7 / 2 = 15.85 (with some variations)
function PART_WIDTH(SCALE)  = 15.9  * SCALE;

// Block height (a typical block is 4 * PART_HEIGHT)
// Real Duplo Block = 19.17 / 4 = 4.8
// we also measured 19.09, 19.16
//function PART_HEIGHT(SCALE)  = ((SCALE < 0.6) && LEGO_DIV) ? ( 3.2 * LEGO_SCALE(SCALE) ) : ( 4.8 * SCALE );
function PART_HEIGHT(SCALE)  = (SCALE < 0.6) ? ( 1.55 * LEGO_SCALE(SCALE) ) : ( 3.2 * SCALE );

// Diamonds - anti-warping holes - used optionally
DIAMOND = 4;



// Top nibble size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations
function NO(SCALE)         = PART_WIDTH(SCALE) / 2.0;              //nibble offset
function NBO(SCALE)        = PART_WIDTH(SCALE);                   // nibble bottom offset
function NH(SCALE)         = (SCALE < 0.6) ? 1.75 * LEGO_SCALE(SCALE) : 4.55 * SCALE;  // LEGO vs. DUPLO 


function NB_RADIUS(SCALE)  = (SCALE < 0.6) ? (4.7 / 2 * LEGO_SCALE(SCALE)) : (9.7 / 2.0 * SCALE);    // radius Lego vs. DUPLO
// Real DUPLO Block = 9.38 

function NB_RADIUS_INSIDE(SCALE) = 7.0/2  * SCALE;  
// 6.44 = Real DUPLO block

function NB_THICKNESS(SCALE)=NB_RADIUS(SCALE)-NB_RADIUS_INSIDE(SCALE);

// For square nibble supports in 1xM or Nx1 blocks
function ALONG_LEN(SCALE)  = (PART_WIDTH(SCALE)-NB_RADIUS(SCALE))/1.7; //tighter fit than 1.8
function CROSS_LEN(SCALE)  = (PART_WIDTH(SCALE)-NB_RADIUS(SCALE)/2);

// Bottom nibbles size definitions
// Must be adjusted with respect to layer resolution and other slicing considerations
function NB_BOTTOM_RADIUS(SCALE)        = (SCALE < 0.6) ? 6.6/2*LEGO_SCALE(SCALE) : 13.2/2*SCALE; //was 13.4(3)
function NB_BOTTOM_RADIUS_THIN(SCALE)        = (SCALE < 0.6) ? 3.2/2*LEGO_SCALE(SCALE) : 7.0/2*SCALE;
// Real DUPLO = 13.48
function NB_BOTTOM_RADIUS_INSIDE(SCALE) = (SCALE < 0.6) ? 4.8/2*LEGO_SCALE(SCALE) : 10.9/2*SCALE; //was 10.8
// Real DUPLO = 10.73
// rapman 10.6
// Real Lego = 4.9

// walls - IMPORTANT: must be adjusted with respect to layer resolution and other slicing considerations

function DOBLOWALL(SCALE) = (SCALE < 0.6) ? 1.1 * LEGO_SCALE(SCALE): 1.6 *SCALE; // Lego vs. Duplo, Lego is not 2x smaller

function USE_INSET(SCALE) = true;//(SCALE < 0.6) ? false : true;
function INSET_WIDTH(SCALE)    = (SCALE < 0.6) ? 0.6 *LEGO_SCALE(SCALE) : 1.52 * SCALE; //little inset walls to make it stick
function INSET_LENGTH(SCALE)  = (SCALE < 0.6) ? 3*DOBLOWALL(SCALE) : 4.1*DOBLOWALL(SCALE); // Legos have proportionally smaller insets

//lattice width and height (optional, see LATTICE_TYPE)
// A grid underneath the flat bridge, crossing through the nibbles underneath
function LATTICE_WIDTH(SCALE)   = 1.50 * SCALE;

// 0 means none, 1 means more spacing (same as nibbles underneath),
// 2 means denser
LATTICE_TYPE    = 1; 

// Sizes of a standard 2x2 square brick, normal height
// Not used, but are practical in your custom modules
function DOBLOWIDTH(SCALE)  = PART_WIDTH(SCALE)  * 2.0  * SCALE;
function DOBLOHEIGHT(SCALE) = PART_HEIGHT(SCALE) * 6.0  * SCALE;
function LEGOHEIGHT(SCALE)  = PART_HEIGHT(SCALE) * 6.0  * SCALE; // If LEGO_DIV == true

