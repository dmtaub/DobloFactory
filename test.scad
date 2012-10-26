include <doblo-factory.scad>;
LEGO_DIV = false;
doblo   (0,   0,   0,   2,   2,    4,  true, false, LUGO);

doblo   (-1,   -1,   -4,   2,   2,    4,  false, false, DOBLO);
nibbles  (-1,  -1,   0,  1,   2, DOBLO);	
nibbles  (0,  -2,   0,  2,   2, LUGO);											