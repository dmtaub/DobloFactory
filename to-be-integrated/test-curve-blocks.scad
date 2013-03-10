include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;

difference(){union(){
curve(3,0,0,2,2,HALF,false,true,DOBLO);
curve(-2,0,0,2,2,HALF,true,true,DOBLO);
doblo(-1,0,0,4,2,HALF,true,false,DOBLO);
nibbles(-2,0,HALF,1,2,DOBLO);
nibbles(3,0,HALF,1,2,DOBLO);
}
nibbles(3,0,0,1,2,DOBLO,filled=true,hscale=1.5);
nibbles(-2,0,0,1,2,DOBLO,filled=true,hscale=1.5);


}

difference(){union(){
curve(2,3,0,1,2,FULL,false,true,DOBLO);
curve(-2,3,0,1,2,FULL,true,true,DOBLO);
doblo(-1,3,0,3,2,FULL,false,false,DOBLO);
nibbles(-1.5,3,FULL,4,2,DOBLO);
}

nibbles(-2,3,0,1,2,DOBLO,filled=true,extra=true,hscale=2);
nibbles(2,3,0,1,2,DOBLO,filled=true,extra=true,hscale=2);
}

