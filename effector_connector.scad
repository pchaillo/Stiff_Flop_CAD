// Parameters
module_radius = 5.75;
height = 2;
pin_height = 2;
female_pin_radius = 1.1;
male_pin_radius = 0.9;
lumen_radius = 1;
pin_placement_radius = 4.1;
side_length = 7; // length of one side of the equilateral triangle

$fn = 100; // determines the number of faces and thus the resolution of rounded surfaces!

num_pins = 3;

IS_FEMALE = 1;
IS_MALE = 1;

IS_VL6180X = 0;
spacing = 14;
width = 20;
depth = 5;

// End of parameters

angles = [ for (i=[1:num_pins]) 
        each [i * 360 / num_pins]
];

t_z = -1;

difference(){
    cylinder(height, module_radius, module_radius);

    translate([0, 0, -0.5]) cylinder(11, lumen_radius, lumen_radius);

    if (IS_FEMALE)
    for ($pin_angle = angles){ 
        rotate([0, 0, $pin_angle]) translate([pin_placement_radius, 0, t_z]) 
            cylinder(pin_height - 0.01, female_pin_radius, female_pin_radius); // subtracting the pins
    }
}

if (IS_MALE)
    translate([0, 0, height]){
        for ($pin_angle = angles){ 
            rotate([0, 0, $pin_angle]) translate([pin_placement_radius, 0, t_z]) 
                cylinder(pin_height - 0.1, male_pin_radius, male_pin_radius); // subtracting the pins
        }
}

if (IS_VL6180X)
    translate([0, module_radius, 0])
    union(){
        translate([-width / 2, -depth / 2, 0]) cube([width, depth, height]);
        translate([spacing / 2, 0, 0]) cylinder(height + 1.5, pin_radius, pin_radius);
        translate([-spacing / 2, 0, 0]) cylinder(height + 1.5, pin_radius, pin_radius);
    }
