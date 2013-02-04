include <doblo-factory.scad>;

doblo   (0,   0,   FULL/LUGO,   2,   2,    6,  true, false, LUGO);
doblo   (-1,   -1,   0,   2,   2,    6,  false, false, DOBLO);
nibbles  (-1,  -1,   FULL,  1,   2, DOBLO);	
nibbles  (0,  -2,   FULL/LUGO,  2,   2, LUGO);											


base_plate (4, -14, 0, 12,12,THIRD,true, LUGO);
base_plate (2, 0, 0, 6,6,THIRD,true, DOBLO);
