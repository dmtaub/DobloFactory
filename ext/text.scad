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
