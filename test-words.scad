include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/text.scad>;

doblo   (0,   0,   0,   2,   2,    FULL,  false, false, DOBLO);
glyph(0,0,FULL,NH(DOBLO)/2,"a",DOBLO);

doblo   (0,   3,   0,   3,   2,    HALF,  false, false, DOBLO);
tScale = 2;
text(0,3*tScale,tScale*HALF,NH(DOBLO)/2,"123",3,DOBLO/tScale);
text(0,(3+2*DOBLO/tScale)*tScale,tScale*HALF,NH(DOBLO)/2,"456",3,DOBLO/tScale);
