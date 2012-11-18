include <doblo-factory.scad>;
include <lib/doblo-params-repl.scad>;
include <ext/connectors.scad>;

//ball_doblo   (0,   1,   0,   2,   2,size=LUGO);
//socket_doblo   (4,   1,   0,   2,   2,size=LUGO);

socket_doblo   (4,   4,   0,   3,   2,size=DOBLO);
ball_doblo   (0,   4,   0,   3,   2,size=DOBLO);

ball_doblo   (1,   7,   0,   8,   2,size=DOBLO);
socket_doblo   (1,   7,   0,   8,   2,size=DOBLO);

ball_doblo   (1,   1,   0,   2,   2,size=DOBLO);
socket_doblo   (1,   1,   0,   2,   2,size=DOBLO);

ball_doblo   (5,   1,   0,   2,   2,size=DOBLO);
socket_doblo   (5,   1,   0,   2,   2,size=DOBLO);

ball_doblo   (9,   1,   0,   2,   2,size=DOBLO);
socket_doblo   (9,   1,   0,   2,   2,size=DOBLO);

socket_doblo   (9,   4,   0,   2,   2,6,size=DOBLO);

top_ball_doblo   (10,   7,   0,   2,   2,size=DOBLO);
 