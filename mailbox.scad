include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

doblo   (0,   0,   0,   2,   2,    HALF,  false, true, DOBLO);
cyl_block(.5,.5, HALF,  1,  .5,    10,     false, DOBLO);
 support     (1,.75,12,  3,    0, .5, scale=DOBLO);
 support     (0,.75,12,  3,    180, .5, scale=DOBLO);
 support     (.3,-.22,14.5,  1,    90, 1.4, scale=DOBLO);
 support     (.3,1.22,14.5,  1,    270, 1.4, scale=DOBLO);
 block       (.6,  1.06,   32,   2.8,   .25,   5 ,  false, scale=LUGO);
 block       (.6,  2.69,   32,   2.8,   .25,   5 ,  false, scale=LUGO);
 block       (3.2,  1.5,   31,   .3,   1,   5 ,  false, scale=LUGO);

 block       (.6,  1.06,   35,   2.8,   .25,   5 ,  false, scale=LUGO);
 block       (.6,  2.69,   35,   2.8,   .25,   5 ,  false, scale=LUGO);
 block       (3.2,  1.5,   35,   .3,   1,   5 ,  false, scale=LUGO);


 doblo(.5,1,39,3,2,1,true,false,LUGO);
// x,y,z,depth,theta,length

