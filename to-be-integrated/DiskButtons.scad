//24.30  x 4.3
RAD = 2430/2;//800
// OpenSCAD Variant of Lego Compatible Disc Buttons
//   http://www.thingiverse.com/thing:1005
// Copyright 2009 by Andrew Plumb
// Licensed under the Attribution - Creative Commons license
//   http://creativecommons.org/licenses/by/3.0/

// For more information about OpenSCAD, see http://www.openscad.org/

// Note 1: The dimensions are 100x larger, i.e. 100=1mm
// This is to work around some rendering issues when fractional values are used at 1=1mm.
// and 1000x (1000=1mm) has trouble rendering the whole volume.

mfgGrid_1mm=100;

// Makerbot Cupcake CNC Parameters
minXStep=0.085*mfgGrid_1mm; // 8.5 grid units
minYStep=0.085*mfgGrid_1mm; // 8.5 grid units
minZStep=0.003125*mfgGrid_1mm; // 0.3125 grid units

nozzleDiam=0.5*mfgGrid_1mm; // 50 grid units

avgZHeight=0.3725*mfgGrid_1mm; // 37.25 grid units

maxBuildX=100.0*mfgGrid_1mm; // 10000 grid units
maxBuildY=100.0*mfgGrid_1mm; // 10000 grid units
maxBuildZ=130.0*mfgGrid_1mm; // 13000 grid units

module build_volume()
{
translate([0,0,-0.5]) 
	difference() {
		scale([maxBuildX/mfgGrid_1mm+1,maxBuildY/mfgGrid_1mm+1,1]) 
			cube(size = 1, center = true);
		scale([maxBuildX/mfgGrid_1mm,maxBuildY/mfgGrid_1mm,2]) 
			cube(size = 1, center = true);
	}
translate([-0.5*maxBuildX/mfgGrid_1mm,-0.5*maxBuildY/mfgGrid_1mm,0])
	scale([1,1,maxBuildZ/mfgGrid_1mm])
		cube(size = 1, center = false);
translate([0.5*maxBuildX/mfgGrid_1mm,-0.5*maxBuildY/mfgGrid_1mm,0])
	scale([1,1,maxBuildZ/mfgGrid_1mm])
		cube(size = 1, center = false);
translate([-0.5*maxBuildX/mfgGrid_1mm,0.5*maxBuildY/mfgGrid_1mm,0])
	scale([1,1,maxBuildZ/mfgGrid_1mm])
		cube(size = 1, center = false);
translate([0.5*maxBuildX/mfgGrid_1mm,0.5*maxBuildY/mfgGrid_1mm,0])
	scale([1,1,maxBuildZ/mfgGrid_1mm])
		cube(size = 1, center = false);
translate([0,0,maxBuildZ/mfgGrid_1mm+0.5]) 
	difference() {
		scale([maxBuildX/mfgGrid_1mm+1,maxBuildY/mfgGrid_1mm+1,1]) 
			cube(size = 1, center = true);
		scale([maxBuildX/mfgGrid_1mm,maxBuildY/mfgGrid_1mm,2]) 
			cube(size = 1, center = true);
	}
}

// Build Volume
//  Uncomment the next line to see the object in build volume context.
// build_volume();

// Note 2: If you don't see the object after first compilation, try zooming out.

// To scale resulting 100=1mm STL to 1=1mm without using scale() function:
// 1. Open resulting STL file in Meshlab
// 2. Select Filters - Normals, Curvatures and Orientation - Apply Transform
// 3. Select "Scale"
// 4. Set X=0.01
// 5. Check "Uniform"
// 6. Click Apply
// 7. Click Close and Freeze
// 8. File - Save As
// 9. Select Format: STL File Format (*.stl)
// 10. Click Save
// 11. Ok the Dialog defaults
// 12. Open newly created STL file in Meshlab.
// 13. Use Tape Measure to confirm dimensions are now 1=1mm.

// The "overlap" variable is for a common amount of volume overlap to "fuse" objects.
// Set overlap=0 to see side-effects of not having overlap.
overlap=10;

module peg()
{
	union() {
		translate([0,0,320-overlap]) cylinder(h=180+overlap, r=245, center=false);
		cylinder(h=320, r=245+55, center=false);
	}
}
module peg_hole(shift_bottom=200)
{
	translate([0,0,-overlap]) union() {
		cylinder(h=180+320+2*overlap, r=150, center=false);
		translate([0,0,overlap-1+shift_bottom])
			cylinder(h=250+1, r1=250+1, r2=0, center=false);
		cylinder(h=overlap+shift_bottom, r=250, center=false);
	}
}
module thread_hole()
{
	translate([0,0,-overlap]) cylinder(h=180+320+2*overlap, r=100, center=false);
}

module disc_button()
{
	module bottom_disc_threadholes(shift_middle=5)
	{
		union() {
		translate([0,0,200+shift_middle]) cylinder(h=130+shift_middle,r=500,center=false);
		translate([400,0,0]) thread_hole();
		translate([-400,0,0]) thread_hole();
		translate([0,400,0]) thread_hole();
		translate([0,-400,0]) thread_hole();
		}
	}
	module bottom_disc()
	{
		difference() {
			#cylinder(h=320, r=RAD, center=false);
			bottom_disc_threadholes(shift_middle=0);
		}
		translate([400, 400, 0])
			peg();
		translate([400, -400, 0])
			peg();
		translate([-400, -400, 0])
			peg();
		translate([-400, 400, 0])
			peg();
	}
	module bottom_disc_holes()
	{
		translate([400, 400, 0])
			peg_hole(shift_bottom=180+overlap);
		translate([400, -400, 0])
			peg_hole(shift_bottom=180+overlap);
		translate([-400, -400, 0])
			peg_hole(shift_bottom=180+overlap);
		translate([-400, 400, 0])
			peg_hole(shift_bottom=180+overlap);
	}
	difference() {
		bottom_disc();
		bottom_disc_holes();
	}
}


module scaled_disc_button(changeScale=1/mfgGrid_1mm)
{
	scale([changeScale, changeScale, changeScale]) {
		disc_button();
	}
}



// disc_button();
//scaled_disc_button(1/100);
//translate([0,0,10])cylinder(h=4.3,r=24.3/2);
// disc_button();
 translate([0,10]) scaled_disc_button(1/100);
translate([0,40])scaled_disc_button(1/100);
translate([30,10])scaled_disc_button(1/100);
translate([30,40])scaled_disc_button(1/100);

translate([60,0,0]){
  translate([0,10])scaled_disc_button(1/100);
  translate([0,40])scaled_disc_button(1/100);
  translate([30,10])scaled_disc_button(1/100);
  translate([30,40])scaled_disc_button(1/100);
}
