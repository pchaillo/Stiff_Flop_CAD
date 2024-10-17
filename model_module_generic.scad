// // // PARAMETERS : // // //
module_radius = 5;
height = 45;
chamber_radius = 0.75;
cannula_radius = 0.75;
lumen_radius = 2;
dec = 5; // length of one side of the equilateral triangle
//dec_y = module_radius/6;
spacing = 3; // distance between two pairs of holes
num_chambers = 6;
num_cannula = 3; // = num_chambers // if needed
cannula_placement_radius = lumen_radius; // inner cannula
sealing_thickness = 1; // thickness of the closure (sealing) of the cavities
$fn = 20; // determines the number of faces, and thus the resolution of the rounded surfaces!

visible = 0; // 10 = visible // 0 = integrated


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

cannula_angle_positions = [ for (i=[1:num_cannula]) 
        each [i*360/num_cannula]
];

chamber_angle_positions = [ for (i=[1:num_chambers]) 
        each [i*360/num_chambers+180/num_chambers]
];

t_z = sealing_thickness;
t_z_l = -sealing_thickness; // initial translation of the lumen


difference(){ //#002
//color([1,0,0],alpha=0.2){
cylinder(height, module_radius, module_radius); //}
 for ($chamber_angle = chamber_angle_positions){ // # 001
    rotate([0,0,$chamber_angle])translate([(2/3) *module_radius,0, t_z+visible]) cylinder(height-2, chamber_radius, chamber_radius);}

   translate([0, 0, t_z_l ]) cylinder(height+2, lumen_radius, lumen_radius); // subtraction of the central lumen
 for ($cannula_angle = cannula_angle_positions){ // # 001
    rotate([0,0,$cannula_angle])translate([cannula_placement_radius ,0, t_z_l]) cylinder(height+2, cannula_radius, cannula_radius);
} // #001
} // #002
