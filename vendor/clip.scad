module xhole(radius, length) {
	rotate(a=[0,90,0]) cylinder(r=radius,h=length+1,center=true, $fn=10);
}

module batteryClip(width, length, thickness) {
	difference() {
		union() {
			rotate([0,90,0]) cylinder(r=thickness+width/2,h=2*thickness+length,$fn=30,center=true);
			translate([0,0,-thickness/2-width/4]) cube([2*thickness+length,2*thickness+width,thickness+width/2], center=true);
		}
		rotate([0,90,0]) cylinder(r=width/2,h=length,$fn=30,center=true);
		translate([0,0,width/1.5]) cube([length,width+2*thickness+1,width],center=true);
		translate([0,1.5,0]) xhole(.75,length+2*thickness+1);
		translate([0,-1.5,0]) xhole(.75,length+2*thickness+1);
		translate([length/3.5,0,0]) cube([length/3.5,width+2*thickness+1,width], center=true);
		translate([-length/3.5,0,0]) cube([length/3.5,width+2*thickness+1,width], center=true);
	}
}

// Dsize
*translate([0,-60,0]) batteryClip(34.2, 61.5, 2);
// C size
*translate([0,-25,0]) batteryClip(26.2, 50, 2);
// AA size
batteryClip(14.5,50.5,2);
// AAA size
*translate([0,20,0]) batteryClip(10.5,44.5,2);