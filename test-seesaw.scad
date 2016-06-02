include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

rotate([90,0,0])doblo   (-1,   -1,   -7.9,   2,   2,    HALF,  false, false, DOBLO);

rotate([90,0,0])nibbles   (1,   -1,   0.5,   2,   2,    DOBLO);
rotate([90,0,0])nibbles   (-3,   -1,   0.5,   2,   2,    DOBLO);

//doblo   (0,   0,   0,   2,   2,    FULL,  true, false, LUGO);
//doblo   (0,   0,   0,   4,   1,    FULL,  true, false, LUGO);


sw= DOBLOWIDTH(DOBLO); // seesaw width
sl=95; // seesaw length
st=3; // seesaw thickness

xw=0.4; // extrude width


rotate([0,0,180]){
	difference(){
		linear_extrude(height=sw, center=true)
			polygon([[-sw/2,-sw/2],[-st,-st],[-st,st*3],[st,st*3],[st,-st],[sw/2,-sw/2]]);
		cube([st*2+xw,st*4,(st+xw)*2], center=true);
	}
	
	translate([0,st/2,0]) {
		difference(){
			cube([sl,st,sw], center=true);
			for(r = [90,270]){
					rotate([r,0,0]) linear_extrude(height=sl, center=true)
						polygon([[st,st],[0,st],[-st,st],[-sw/2-xw,sw/2+xw],[sw/2+xw,sw/2+xw]]);
			}
		}
		translate([0,-st*1.25,0]) cylinder(r=st/2, h=sw, center=true, $fn=20);
		translate([0,st*1.25,0]) cylinder(r=st/2, h=sw, center=true, $fn=20);
	}
}