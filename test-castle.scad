/* Castle kit, Lego and Duplo compatible-- examples
Daniel.schneider@tecfa.unige.ch
sept. 2012

modified as an extension to doblo-factory v2.0 by dmtaub@cemi.org
*/

// setting LEGO_DIV to true will make Lego models higher, i.e. height units will be use "Lego heights" 3.2mm instead of the 2.4mm/4.8mm Duplo proportions. This param will not affect DUPLOs (scale > 0.6)

LEGO_DIV = true;     // height units = 3.2mm, use for true Lego height divisions
// LEGO_DIV = false; // height units = 2.4mm. 

// LOAD doblo factory
include <doblo-factory.scad>;
// LOAD castle kit extension
include <ext/castle-kit-1-9.scad>;

// SCALE=1;   // DUPLO Size (not fully tested)
SCALE =0.5;   // Lego size (same as SCALE = LUGO;)
// SCALE=0.25; // Half lego size (1/8 volume)

// can override global scale for a single model, thus combining scales.
// uncomment the following 2 lines for an example: 
// large_example (SCALE=.5);          
// tower_legobase(SCALE=.25);           


// ----------------  Execute models. Uncomment only one


// calibration (); // simple brick for calibrating doblo-factory params

// --- simple plates
// base ();                    // --- simple base with partly empty floor
// base_16 ();                 // --- simple 16x16 base with partly empty floor, must have
// base_24 ();                 // --- For the ambitious

// --- tower on base plates
// tower();                     // --- 8x8 Tower
// tower_16();                  // --- 8x8 Tower sitting on a 16x16 base plate
// wizard_tower ();             // --- 6x6 small round tower with texture
// tower_round();               // --- 8x8 round Tower
// wizard_tower_wide();         // --- 12x12 round tower on a 16x16 base plate

// --- stackable towers and houses
// tower_legobase();            // --- tower, must have
// tower_round_legobase();      // --- round tower, must have
// wizard_tower_legobase ();    // --- tower, must have

// --- stackable tower/house elements
// tower_floor_legobase ();     // --- stackable floor with pillars underneath
// pillars_legobase ();         // --- stackable floor with pillars on top
// tower_roof_legobase ();      // --- anti-rain measures, lots of overhangs

// --- walls and corners on base plates
// wall ();                     // --- Simple wall, ugly
// wall_thin ();                // --- Simple wall, nicer to look at
// wall_thin_16 ();             // --- Simple wall on a 16x16 plate
// wall_stairs ();              // --- Walls with stairs 
// wall_stairs_16_8 ();         // --- Wall and stairs on a 16x8 plate
// portal ();                   // --- Portal, a wall with a "door"
// corner ();                   // --- Corner, two simple walls, ugly
// corner_thin ();              // --- Corner, two walls, thinner and nicer
// corner_thin_16 ();           // --- Corner on 16x16 basis
// corner_tower ();             // --- Corner with tower inside - ugly

// --- stackable walls and corners
// wall_thin_legobase ();       // --- stackable wall

// wall_stairs_legobase ();     // --- Walls with stairs, stackable
// corner_legobase ();          // --- Corner, two walls, stackable, ugly
// corner_thin_legobase ();     // --- Corner, two walls, thinner

// --- other on base plate
// pool ();                     // --- pool, jacuzzi-style on base plate
// large_example ();            // --- a large glued layout

// --- other, stackable
// base_legobase ();            // --- simple stackable base with partly empty floor
// pool_legobase ();            // --- stackable pool, jacuzzi-style, must have 
// bricks ();                   // --- collection of bricks 1
// bricks_flat ();              // --- collection of bricks 2    
// wall_connector () ;          // --- connect towers on top or for stacking


// --------------- simple bricks and tests -------------

// house_lr   (-5, -1,  0,  10,    4,     10, SCALE) ;
// house_fb   (-5, -1,  0,  4,    10,     10, SCALE) ;
// doblo   (0,   0,   0,   4,   2,    3,  false, false, SCALE );	
// doblo   (0,   0,   0,   2,   2,    2,  false, false, SCALE );	
