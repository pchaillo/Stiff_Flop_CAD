// PARAMETRES

$fn = 100;

marge = 0.2; // écart en mm du rayon des pièces pour qu'elles puissent s'imbriquer entre elles
// ajout des marges sur les trous pour l'instant

// MODULE
rayon_module = 5.75;
hauteur = 50+15;
rayon_chambre = 0.75;
rayon_canule = 0.75 - marge; // for pressure pipes
rayon_lumen = 2.25 - marge;
dec = 6; // longueur d'un coté du triangle équilatéral
//dec_y = rayon_module/6;
e = 3; //écartement entre deux paires de trous



//rayon_canule = rayon_canule - 0.2; // Finalement elles seront déduit de la poutre centrale
//rayon_lumen = rayon_lumen - 0.2;

cylinder(hauteur,rayon_lumen,rayon_lumen);
translate([rayon_lumen,0,0])cylinder(hauteur,rayon_canule,rayon_canule);
rotate([0,0,120])translate([rayon_lumen,0,0])cylinder(hauteur,rayon_canule,rayon_canule);
rotate([0,0,240])translate([rayon_lumen,0,0])cylinder(hauteur,rayon_canule,rayon_canule);