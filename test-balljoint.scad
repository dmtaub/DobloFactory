include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

ball_doblo   (0,   1,   0,   2,   2,size=LUGO);
ball_doblo   (0,   2,   0,   3,   1,size=DOBLO);
ball_doblo   (0,   4,   0,   3,   2,size=DOBLO);

socket_doblo   (4,   1,   0,   2,   2,size=LUGO);
socket_doblo   (5,   2,   0,   3,   1,size=DOBLO);
socket_doblo   (5,   4,   0,   3,   2,size=DOBLO);


ball_doblo   (1,   8,   0,   8,   2,size=DOBLO);
socket_doblo   (1,   8,   0,   8,   2,size=DOBLO);
