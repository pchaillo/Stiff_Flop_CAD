
// PARAMETRES

// MODULE
rayon_module = 5.75;
hauteur = 50+5;
rayon_chambre = 0.75;
rayon_canule = 0.75;
rayon_lumen = 2.25;
dec = 6; // longueur d'un coté du triangle équilatéral
//dec_y = rayon_module/6;
e = 3.5; //écartement entre deux paires de trous

// MOULE
e_mold = 2; // epaisseur du moule en mm
mold_radius = rayon_module + e_mold;
mold_canula = 0.5; // pour coincer les pièces entre elles (rayon)
mold_support = 1; // pour coincer le moule dans le support (rayon)

marge = 0.2; // écart en mm du rayon des pièces pour qu'elles puissent s'imbriquer entre elles
// ajout des marges sur les trous pour l'instant

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

// FIN DES PARAME7TRES

//cylinder(hauteur, rayon_module, rayon_module); // Crée la forme générale du robot



/*
translate([0,mold_radius-e_mold/2,0]){
cylinder(hauteur,mold_canula,mold_canula);
}*/



//rotate([0,0,0]){ // pour le 1er # 003
//rotate([0,0,120]){ // pour le 2nd # 003
rotate([0,0,240]){ // pour le 2nd # 003

union(){ // #002

difference(){ // #001

intersection(){

difference(){
    cylinder(hauteur, mold_radius, mold_radius);
    translate([0,0,t_z_l]){
cylinder(hauteur+2, rayon_module, rayon_module); // Crée la forme //générale du robot
    }
} // Cree le moule cylindrique, avant découpage // difference
;

// rotate([0,0,0]){// rien pour le 1er # jamais utilisé mtn #444
//rotate([0,0,120]){ // pour le 2nd
//rotate([0,0,240]){ // pour le 2nd
union(){
rotate([0,0,120]) cube([hauteur/3,hauteur/3,hauteur]);
rotate([0,0,90]) cube([hauteur/3,hauteur/3,hauteur]);
}
// } // #444
};// intersection

translate([0,mold_radius-e_mold/2,t_z_l]){
cylinder(hauteur+2,mold_canula+marge,mold_canula+marge);
} // canule soustraite

} // difference #001

rotate([0,0,120]){
translate([0,mold_radius-e_mold/2,0]){
cylinder(hauteur,mold_canula,mold_canula);
}
} // canule ajoutée 

rotate([0,0,60]){
translate([0,mold_radius,0]){
cylinder(hauteur,mold_support,mold_support);
}
} // cannule pour le support

} // #002

}; // #003
/*
translate([0,mold_radius-e_mold/2,0]){
cylinder(hauteur,mold_canula,mold_canula);
}
*/
