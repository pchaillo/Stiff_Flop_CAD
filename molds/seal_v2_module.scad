
// PARAMETRES

// MODULE
rayon_module = 5.75;
hauteur = 50;
rayon_chambre = 0.75;
rayon_canule = 0.75; // for pressure pipes
rayon_lumen = 2.25;
dec = 6; // longueur d'un coté du triangle équilatéral
//dec_y = rayon_module/6;
e = 3; //écartement entre deux paires de trous

marge = 0.2; // écart en mm du rayon des pièces pour qu'elles puissent s'imbriquer entre elles
// ajout des marges sur les trous pour l'instant

// MOULE
e_mold = 2; // epaisseur du moule en mm
mold_radius = rayon_module + e_mold + marge; // rayon ext du moule
mold_canula = 0.5; // pour coincer les pièces entre elles (rayon)
mold_support = 1 + marge; // pour coincer le moule dans le support (rayon)

// SUPPORT
e_support = 6; //epaisseur des bords du support en mm
support_radius = mold_radius + e_support;
h_support = 6;
e_fond = 2; // epaisseur du fond du support

// SEAL 
l_seal = 3; // largeur du carré pour le seal
seal_radius = mold_radius+2;
radius_picot = 1 ; // rayon des picots en mm
h_picot = 2 ; // hauteur des picots en mm

$fn = 100; // permet de déterminer le nb de face, et donc la résolution des surfaces arrondies !

dec_x = dec*sin(60);  // décalage appliqués pour qu'ils soient bien placé en triangle
dec_y = dec*cos(60);

A_x = dec_x;
A_y = 0;

B_x = 0;
B_y = dec_y;

C_x = 0;
C_y = -dec_y;

A1_x = A_x;
A2_x = A_x;
A1_y = A_y - e/2;
A2_y = A_y + e/2;

B1_x = B_x - (e/2)*sin(60);
B2_x = B_x + (e/2)*sin(60);
B1_y = B_y - (e/2)*cos(60);
B2_y = B_y + (e/2)*cos(60);

C1_x = C_x + (e/2)*sin(60);
C2_x = C_x - (e/2)*sin(60);
C1_y = C_y - (e/2)*cos(60);
C2_y = C_y + (e/2)*cos(60);
// determine la valeur de la translation appliqué de bas à tous les trous
t_x = -(dec/2)*tan(30); // décalage pour centrer le triangle dans le cercle
t_y = 0;
t_z = 1;

t_z_l = -1; // translation initiale du lumen

// FIN DES PARAMETRES

//intersection(){ // #006
module ext(){ // # 007

difference(){ // #003

union(){ // # 002

difference(){ // # 001
    
cylinder(h_support,support_radius,support_radius); // forme ext du support

translate([0,0,e_fond]){
cylinder(h_support,mold_radius,mold_radius); 
}// cylindre a soustraire à l'interieur

} // #001

//cylinder(h_support,rayon_module,rayon_module); // forme ext du module

} // #002
;

translate([0,0,t_z_l]){
cylinder(h_support+2,rayon_lumen,rayon_lumen); // lumen central
}

translate([0,rayon_lumen,t_z_l])cylinder(h_support+2,rayon_canule,rayon_canule); // 1ere canule pression
rotate([0,0,120])translate([0,rayon_lumen,t_z_l])cylinder(h_support+2,rayon_canule,rayon_canule); // 1ere canule pression
rotate([0,0,240])translate([0,rayon_lumen,t_z_l])cylinder(h_support+2,rayon_canule,rayon_canule); // 1ere canule pression

translate([0,0,-2])rotate([0,0,30])
union(){ // # 004
   translate([A1_x + t_x , A1_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
 //  translate([A2_x + t_x , A2_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
 //  translate([B1_x + t_x , B1_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
   translate([B2_x + t_x , B2_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
 //  translate([C1_x + t_x , C1_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
   translate([C2_x + t_x , C2_y + t_y , t_z ]) cylinder(hauteur-2, rayon_chambre,rayon_chambre);
} // #004 les paires de chambres pneumatiques

union(){ // #005
rotate([0,0,60])translate([0,mold_radius,e_fond])cylinder(hauteur,mold_support,mold_support); 
rotate([0,0,60+120])translate([0,mold_radius,e_fond])cylinder(hauteur,mold_support,mold_support); 
rotate([0,0,60+240])translate([0,mold_radius,e_fond])cylinder(hauteur,mold_support,mold_support); 
} // #005 // cylindres a soustraitre pour inserer le moule (canule pour le coincer)

} // #003

}// #007

//translate([-l_seal/2,-mold_radius-e_mold,0])cube([l_seal,l_seal,l_seal]);
//rotate([0,0,120])translate([-l_seal/2,-mold_radius-e_mold,0])cube([l_seal,l_seal,l_seal]);
//rotate([0,0,240])translate([-l_seal/2,-mold_radius-e_mold,0])cube([l_seal,l_seal,l_seal]);

union(){ // # 009

intersection(){
ext();
translate([-l_seal/2,-mold_radius-e_mold*2,0])cube([l_seal,l_seal*2,h_support]);
}

intersection(){
ext();
rotate([0,0,120])translate([-l_seal/2,-mold_radius-e_mold*2,0])cube([l_seal,l_seal*2,h_support]);
}

intersection(){
ext();
rotate([0,0,240])translate([-l_seal/2,-mold_radius-e_mold*2,0])cube([l_seal,l_seal*2,h_support]);
}

difference(){
ext();
translate([0,0,e_fond]){
cylinder(h_support,seal_radius,seal_radius); 
}// cylindre a soustraire à l'interieur
}

translate([0,mold_radius-l_seal/3,0])cylinder(e_fond+h_picot,radius_picot,radius_picot); // 1ere canule pression
rotate([0,0,120])translate([0,mold_radius-l_seal/3,0])cylinder(e_fond+h_picot,radius_picot,radius_picot); // 1ere canule pression
rotate([0,0,240])translate([0,mold_radius-l_seal/3,0])cylinder(e_fond+h_picot,radius_picot,radius_picot); // 1ere canule pression

} // # 009


//} // # 006

/*translate([0,0,t_z_l]){
cylinder(h_support+2,rayon_lumen,rayon_lumen); // lumen central
}*/



