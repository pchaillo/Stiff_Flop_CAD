
// // // PARAMETERS : // // //
rayon_module = 5;
hauteur = 45;
rayon_chambre = 0.75;
rayon_canule = 0.75;
rayon_lumen = 2;
dec = 5; // longueur d'un coté du triangle équilatéral
//dec_y = rayon_module/6;
e = 3; //écartement entre deux paires de trous
nb_chambre = 6;
nb_cannule = 3; // = nb_chambre // si nécessaire
r_placement_canule = rayon_lumen; // canule intérieure
off_set = 1; // épaisseur de la fermeture (scellage) des cavités 
$fn = 20; // permet de déterminer le nb de face, et donc la résolution des surfaces arrondies !

visible = 0; // 10 = visible // 0 = intégré


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pos_ang_can = [ for (i=[1:nb_cannule]) 
        each [i*360/nb_cannule]
];

pos_ang_ch = [ for (i=[1:nb_chambre]) 
        each [i*360/nb_chambre+180/nb_chambre]
];

t_z = off_set;
t_z_l = - off_set; // translation initiale du lumen


difference(){ //#002
//color([1,0,0],alpha=0.2){
cylinder(hauteur, rayon_module, rayon_module); //}
 for ($ang_ch = pos_ang_ch){ // # 001
    rotate([0,0,$ang_ch])translate([(2/3) *rayon_module  ,0, t_z+visible]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);}

   translate([0, 0, t_z_l ]) cylinder(hauteur+2, rayon_lumen,rayon_lumen); // soustraction du lumen central
 for ($ang_can = pos_ang_can){ // # 001
    rotate([0,0,$ang_can])translate([r_placement_canule ,0, t_z_l]) cylinder(hauteur+2, rayon_canule,rayon_canule);
} // #001
} // # 002
