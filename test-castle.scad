/* Castle kit, Lego and Duplo compatible-- examples
Daniel.schneider@tecfa.unige.ch
sept./dec 2012

modified as an extension to doblo-factory v2.0 by dmtaub@cemi.org
*/

// LOAD doblo factory
include <doblo-factory.scad>;
// LOAD castle kit extension
include <ext/castle-kit-1-11.scad>;

// SCALE=1;   // DUPLO Size (not fully tested)
SCALE =0.5;   // Lego size (same as SCALE = LUGO;)
// SCALE=0.25; // Half lego size (1/8 volume)

// can override global scale for a single model, thus combining scales.
// uncomment the following 2 lines for an example: 
// large_example (SCALE=.5);          
// tower_legobase(SCALE=.25);  

echo (str ("LATTICE-WIDTH = ", LATTICE_WIDTH(SCALE)));	
echo (str ("SCALE = ", SCALE));

// ----------------  Execute models. Uncomment only one



// --- vertical scale - get an idea how heights are working
// vert_scale ();
// --- simple brick for calibrating doblo-factory params
// calibration (); 
// --- reference model for height
// translate([100,0,0]) { tower (); }

// --- simple plates
// base ();                    // --- simple 8x8 base with partly empty floor
// base_16 ();                 // --- simple 16x16 base with partly empty floor, must have
// base_24 ();                 // --- For the ambitious, full 24x25
// base_legobase ();            // --- simple 8x8 stackable base with partly empty floor

// --- square tower
// tower();                     // --- 8x8 Tower
// tower_16();                  // --- 8x8 Tower sitting on a 16x16 base plate, must have
// tower_legobase();            // --- tower, must have

// --- fairly ugly corner tower 
// corner_tower ();             // --- Corner with tower inside
// corner_tower_legobase ();      // --- Corner with tower inside

// --- round tower
// tower_round();               // --- 8x8 round Tower
// tower_round_16();            // --- 8x8 round Tower  on 16x16 plate
// tower_round_legobase();      // --- round tower, must have

// --- round tower square
// tower_round_square();        // --- 8x8 round Tower
// tower_round_square_16();        // --- 8x8 round Tower on 16x16 plate
// tower_round_square_legobase();  // --- 8x8 round Tower

// --- wizard tower
// wizard_tower ();             // --- 6x6 small round tower with texture
// wizard_tower_legobase ();    // --- tower, must have

// --- stackable tower/house elements

// tower_floor_legobase ();     // --- stackable floor with pillars underneath
// pillars_legobase ();         // --- stackable floor with pillars on top
// tower_roof_legobase ();      // --- anti-rain measures, lots of overhangs

// --- walls 
// wall ();                     // --- Very simple wall, sturdy
// wall_legobase ();            // --- Very simple wall, sturdy
// wall_thin ();                // --- Simple wall, nicer to look at
// wall_thin_legobase ();       // --- Simple wall, nicer to look at
// wall_thin_16 ();             // --- Simple wall on a 16x16 plate
// wall_stairs_16_8 ();         // --- Wall and stairs on a 16x8 plate
// wall_stairs_legobase ();     // --- Wall and stairs 16 long
// wall_stairs_16_16 ();        // --- Wall and stairs on a 16x8 plate
// portal ();                   // --- Portal, a wall with a "door"

// ---- corners
// corner ();                   // --- Corner, two simple walls, ugly
// corner_legobase ();          // --- Corner, two simple walls, ugly
// corner_thin ();              // --- Corner, two walls, thinner and nicer
// corner_thin_legobase ();     // --- Corner, two walls, thinner
// corner_thin_16 ();           // --- Corner on 16x16 basis

// --- other on base plate

// pool ();                     // --- pool, jacuzzi-style on base plate
// pool_legobase ();            // --- stackable pool, jacuzzi-style, must have 
// large_example ();            // --- a large glued layout

// --- other, stackable
// bricks ();                   // --- collection of bricks 1
// bricks_flat ();              // --- collection of bricks 2    
// wall_connector () ;          // --- connect towers on top or for stacking


// --------------- simple bricks and tests -------------

// house_lr   (-5, -1,  0,  10,    4,     10, SCALE) ;
// house_fb   (-5, -1,  0,  4,    10,     10, SCALE) ;
// doblo   (0,   0,   0,   4,   2,    FULL,  false, false, SCALE );	
// doblo   (0,   0,   0,   2,   2,    2*THIRD,  false, false, SCALE );	
