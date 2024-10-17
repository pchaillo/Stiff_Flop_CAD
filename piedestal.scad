// Parameters:
$fn = 100;
length = 50;
width = 25;
height = 4;

margin = 0.2; // 0.2 for 10mm // 0.4 // 0.6 => perfect for 14mm
 
module_radius = 5.75 + margin;
thickness = 3;
outer_radius = module_radius + thickness;

support_height = 30; // height of the support
 
screw_hole_radius = 2; // radius of the screw holes in mm
screw_spacing = 35; // this spacing is important, as it will determine the holes in the board
 
stop_size = 1;
 
// end of parameters

union(){
    difference(){
        cube([length, width, height]);
        translate([(length - screw_spacing) / 2, width / 2, -1]) cylinder(height + 2, screw_hole_radius, screw_hole_radius);
        translate([(length - screw_spacing) / 2 + screw_spacing, width / 2, -1]) cylinder(height + 2, screw_hole_radius, screw_hole_radius);
    }
    translate([length / 2, width / 2, 0]) cylindrical_stop_leg();
    //translate([length / 2, width / 2, 0]) cylindrical_leg();
}

module cylindrical_leg(){
    rotate([0, 0, 45])
    difference() {
        cylinder(support_height, outer_radius, outer_radius);
        translate([0, 0, -1]) cylinder(support_height + 2, module_radius, module_radius);
        cube([outer_radius, outer_radius, support_height * 0.75]);
        rotate([0, 0, 180]) cube([outer_radius, outer_radius, support_height * 0.75]);
    }
}

module cylindrical_stop_leg(){
    rotate([0, 0, 45])
    difference() {
        cylinder(support_height, outer_radius, outer_radius);
        translate([0, 0, support_height * 0.87]) cylinder(support_height + 2, module_radius, module_radius);
        cube([outer_radius, outer_radius, support_height * 0.75]);
        translate([0, 0, -1]) cylinder(support_height + 2, module_radius - stop_size, module_radius - stop_size);
        cube([outer_radius, outer_radius, support_height * 0.75]);
        rotate([0, 0, 180]) cube([outer_radius, outer_radius, support_height * 0.75]);
    }
}
