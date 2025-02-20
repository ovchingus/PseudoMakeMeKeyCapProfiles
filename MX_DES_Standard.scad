use <scad-utils/morphology.scad> //for cheaper minwoski
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/trajectory.scad>
use <scad-utils/trajectory_path.scad>
use <sweep.scad>
use <skin.scad>  

/*DES (Distorted Elliptical Saddle) Sculpted Profile for 6x3 and corne thumb 
Version 2: Eliptical Rectangle
*/

mirror([0,0,0])keycap(
  keyID  = 1, //change profile refer to KeyParameters Struct
  cutLen = 0, //Don't change. for chopped caps
  Stem   = true, //tusn on shell and stems
  Dish   = true, //turn on dish cut
  Stab   = 0, 
  visualizeDish = false, // turn on debug visual of Dish 
  crossSection  = false, // center cut to check internal
  homeDot = false, //turn on homedots
  Legends = false
 );
 
//Parameters
wallthickness = 1.5; // 1.5 for norm, 1.25 for cast master
topthickness  = 2.5;   // 3 for norm, 2.5 for cast master
stepsize      = 40;  //resolution of Trajectory
step          = 6;   //resolution of ellipes 
fn            = 16;  //resolution of Rounded Rectangles: 60 for output
layers        = 40;  //resolution of vertical Sweep: 50 for output
dotRadius     = 0.55;   //home dot size
//---Stem param
Tol    = 0.03;
stemRot = 0;
StemBrimDep     = 0.00;

keyParameters = //keyParameters[KeyID][ParameterID]
[
//  BotWid, BotLen, TWDif, TLDif, keyh, WSft, LSft  XSkew, YSkew, ZSkew, WEx, LEx, CapR0i, CapR0f, CapR1i, CapR1f, CapREx, StemEx
//Column high sculpt 3 row system 
    //0~5
    [17.16,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4 8
    [17.16,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [17.16,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [17.16,  17.16,   6.5, 	 6.5, 8.75,    0,    0,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 deepdish
    [17.16,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 mod 
    [17.16,  17.16,   6.5, 	 6.5, 15.0,    0,  -.5,    20,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R1 num
   
    //1.25u 6~9
    [21.86,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [21.86,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4  // neuron 3 deg  
    [21.86,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [21.86,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //1.5u 10~13
    [26.66,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [26.66,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [26.66,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [26.66,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //1.75u 14~17
    [31.40,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [31.40,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [31.40,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [31.40,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //2.0u  18~22
    [36.26,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [36.26,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [36.26,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [36.26,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    [36.26,  17.16,   6.5, 	 6.5,   15,    0,  -.5,    20,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R1
    //2.25u 23~26
    [40.96,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [40.96,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [40.96,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [40.96,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //2.50u 27~30  
    [45.66,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5  // neuron 2deg height to 10.5 
    [45.66,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [45.66,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [45.66,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //2.75u 31~34
    [50.66,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [50.66,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [50.66,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,    -4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [50.66,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //3.00u 34~37
    [55.36,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    [55.36,  17.16,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4
    [55.36,  17.16,   6.5, 	 6.5, 8.75,    0,   .5,     4,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R3 Home
    [55.36,  17.16,   6.5, 	 6.5, 9.75,    0,    0,   -13,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R2
    //6.25u 39
    [117.1,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    //7.00u 40
    [131.4,  17.16,   6.5, 	 6.5, 11.5,    0,    0,    -3,    -0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R5 
    //num pad vert  2u 41
    [17.16,  36.26,   6.5, 	 6.5,10.00,    0,    0,    -5,     0,     0,   2,   2,      1,      6,      1,    3.5,     2,       2], //R4
    [17.16,  36.26,   6.5, 	 6.5,10.55,    0,    0,     9,     0,     0,   2,   2,      1,      5,      1,    3.5,     2,       2], //R4

];

dishParameters = //dishParameter[keyID][ParameteID]
[ 
//FFwd1 FFwd2 FPit1 FPit2  DshDep DshHDif FArcIn FArcFn FArcEx     BFwd1 BFwd2 BPit1 BPit2  BArcIn BArcFn BArcEx
  // low pro 3 row system
  [   6,    3,   18,  -50,      5,    1.8,   8.8,    15,     2,        5,  4.4,    5,  -55,    8.8,    15,     2], //R4
  [   5,  3.5,   10,  -55,      5,    1.8,   8.5,    15,     2,        5,  3.7,   10,  -55,    8.5,    15,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,   8.8,    15,     2,        6,    4,   13,   30,    8.8,    16,     2], //R2
  [ 4.8,  3.3,   18,  -55,      5,    2.0,   8.5,    15,     2,      4.8,  3.3,   18,  -55,    8.5,    15,     2], //R3 deep
  [   6,    3,   -5,  -50,      5,    1.8,   8.8,    15,     2,        6,  3.5,   13,  -50,    8.8,    15,     2], //R5 mod 
  [   6,    3,   13,   30,      5,    1.9,   8.9,    15,     2,        5,  4.4,   10,  -50,    8.9,    16,     2], //R1 
  //1.25
  [   6,    3,   -5,  -50,      5,    1.8,  12.4,    18,     2,        6,  3.5,   13,  -50,   12.4,    19,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,  12.4,    21,     2,        5,  4.4,    5,  -55,   12.4,    19,     2], //R4
  [   5,  3.5,   10,  -55,      5,    1.8,  12.4,    18,     2,        5,  3.7,   10,  -55,   12.4,    19,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  12.4,    18,     2,        6,    4,    13,  30,   12.4,    19,     2], //R2
  //1.5
  [   6,    3,   -5,  -50,      5,    1.8,  15.6,    22,     2,        6,  3.5,   13,  -50,   15.6,    22,     2], //R5
  [   6,    3,   18,  -50,      5,    1.8,  15.6,  27.2,     2,        5,  4.4,    5,  -55,   15.6,    22,     2], //R4
  [   5,  3.5,   10,  -55,      5,    1.8,  15.5,    22,     2,        5,  3.7,   10,  -55,   15.5,    22,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  15.7,    22,     2,        6,    4,   13,   30,   15.7,    23,     2], //R2
  //1.75
  [   6,    3,   -5,  -50,      5,    1.8,  18.7,    25,     2,        6,  3.5,   13,  -50,   18.7,    26,     2], //R5
  [   6,    3,   17,  -50,      5,    1.8,  18.7,    32,     2,        5,  4.4,    5,  -55,   18.7,    25,     2], //R4
  [   5,  3.5,   10,  -55,      5,    1.8,  18.7,    27,     2,        5,  3.8,   10,  -55,   18.7,    25,     2], //R3 
  [   6,    3,   10,  -50,      5,    1.8,  18.7,    25,     2,        6,    4,   13,   30,   18.7,    28,     2], //R2
  //2
  [   6,    3,   -5,  -50,      5,    1.8,  22.3,    30,     2,        6,  3.5,   13,  -50,   22.3,    31,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,  22.3,    35,     2,        5,  4.4,    5,  -55,   22.3,    31,     2], //R4
  [   6,    3,   17,  -55,      5,    1.8,  22.3,  32.5,     2,        5,  3.7,    8,  -55,   22.3,    31,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  22.3,    30,     2,        5,    4, 11.5,  -55,   22.3,    33,     2], //R2
  [ 6.4,  3.2,   13,   30,      5,    1.9,  23.1,    38,     2,        5,  4.4,   10,  -50,   23.1,    34,     2], //R1
  //2.25
  [   6,    3,   -5,  -50,      5,    1.8,  25.6,    30,     2,        6,  3.5,   13,  -50,   25.6,    40,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,  25.6,    41,     2,        5,  4.4,    5,  -55,   25.6,    34,     2], //R4
  [   6,    3,   17,  -55,      5,    1.8,  25.6,  32.5,     2,        5,  3.7,    8,  -55,   21.9,    31,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  21.9,    30,     2,        5,    4, 11.5,  -55,   21.9,    33,     2], //R2
  //2.50
  [   6,    3,   -5,  -50,      5,    1.8,  29.0,    40,     2,        6,  3.5,   13,  -50,   29.0,    43,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,  21.9,    34,     2,        5,  4.4,    5,  -55,   21.9,    31,     2], //R4
  [   6,    3,   17,  -55,      5,    1.8,  21.9,  32.5,     2,        5,  3.7,    8,  -55,   21.9,    31,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  21.9,    30,     2,        5,    4, 11.5,  -55,   21.9,    33,     2], //R2
  //2.75
  [   6,    3,   -5,  -50,      5,    1.8,  33.1,    38,     2,        6,  3.5,   13,  -50,   33.1,    50,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,  21.9,    34,     2,        5,  4.4,    5,  -55,   21.9,    31,     2], //R4
  [   6,    3,   17,  -55,      5,    1.8,  21.9,  32.5,     2,        5,  3.7,    8,  -55,   21.9,    31,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  21.9,    30,     2,        5,    4, 11.5,  -55,   21.9,    33,     2], //R2
  //3
  [   6,    3,   -5,  -50,      5,    1.8, 35.85,    46,     2,        6,  3.5,   13,  -50,  35.85,    55,     2], //R5
  [   6,    3,   15,  -50,      5,    1.8,  21.9,    34,     2,        5,  4.4,    5,  -55,   21.9,    31,     2], //R4
  [   6,    3,   17,  -55,      5,    1.8,  21.9,  32.5,     2,        5,  3.7,    8,  -55,   21.9,    31,     2], //R3
  [   6,    3,   10,  -50,      5,    1.8,  21.9,    30,     2,        5,    4, 11.5,  -55,   21.9,    33,     2], //R2
  //6.25u
  [   6,    3,   -5,  -50,      5,    1.8,  79.1,    95,     2,        6,  3.5,   13,  -50,   79.1,    127,     2], //R5
  //7.00u
  [   6,    3,   -5,  -50,      5,    1.8,  89.7,   105,     2,        6,  3.5,   13,  -50,   89.7,    143,     2], //R5
  //2.00u vert
  [  13,  5.5,    5,  -30,      4,    1.8,   8.5,    12,   1.5,       10,    8,    7,  -10,    8.5,     12,   1.5], //R5
  [   6,    3,   -5,  -50,      5,    1.8,  79.1,    95,     2,        6,  3.5,   13,  -50,   79.1,    127,     2], //R5


];
 
function FrontForward1(keyID) = dishParameters[keyID][0];  //
function FrontForward2(keyID) = dishParameters[keyID][1];  // 
function FrontPitch1(keyID)   = dishParameters[keyID][2];  //
function FrontPitch2(keyID)   = dishParameters[keyID][3];  //
function DishDepth(keyID)     = dishParameters[keyID][4];  //
function DishHeightDif(keyID) = dishParameters[keyID][5];  //
function FrontInitArc(keyID)  = dishParameters[keyID][6];
function FrontFinArc(keyID)   = dishParameters[keyID][7];
function FrontArcExpo(keyID)  = dishParameters[keyID][8];
function BackForward1(keyID)  = dishParameters[keyID][9];  //
function BackForward2(keyID)  = dishParameters[keyID][10];  // 
function BackPitch1(keyID)    = dishParameters[keyID][11];  //
function BackPitch2(keyID)    = dishParameters[keyID][12];  //
function BackInitArc(keyID)   = dishParameters[keyID][13];
function BackFinArc(keyID)    = dishParameters[keyID][14];
function BackArcExpo(keyID)   = dishParameters[keyID][15];

function BottomWidth(keyID)  = keyParameters[keyID][0];  //
function BottomLength(keyID) = keyParameters[keyID][1];  // 
function TopWidthDiff(keyID) = keyParameters[keyID][2];  //
function TopLenDiff(keyID)   = keyParameters[keyID][3];  //
function KeyHeight(keyID)    = keyParameters[keyID][4];  //
function TopWidShift(keyID)  = keyParameters[keyID][5];
function TopLenShift(keyID)  = keyParameters[keyID][6];
function XAngleSkew(keyID)   = keyParameters[keyID][7];
function YAngleSkew(keyID)   = keyParameters[keyID][8];
function ZAngleSkew(keyID)   = keyParameters[keyID][9];
function WidExponent(keyID)  = keyParameters[keyID][10];
function LenExponent(keyID)  = keyParameters[keyID][11];
function CapRound0i(keyID)   = keyParameters[keyID][12];
function CapRound0f(keyID)   = keyParameters[keyID][13];
function CapRound1i(keyID)   = keyParameters[keyID][14];
function CapRound1f(keyID)   = keyParameters[keyID][15];
function ChamExponent(keyID) = keyParameters[keyID][16];
function StemExponent(keyID) = keyParameters[keyID][17];

function FrontTrajectory(keyID) = 
  [
    trajectory(forward = FrontForward1(keyID), pitch =  FrontPitch1(keyID)), //more param available: yaw, roll, scale
    trajectory(forward = FrontForward2(keyID), pitch =  FrontPitch2(keyID))  //You can add more traj if you wish 
  ];

function BackTrajectory (keyID) = 
  [
    trajectory(forward = BackForward1(keyID), pitch =  BackPitch1(keyID)),
    trajectory(forward = BackForward2(keyID), pitch =  BackPitch2(keyID)),
  ];

//------- function defining Dish Shapes

function ellipse(a, b, d = 0, rot1 = 0, rot2 = 360) = [for (t = [rot1:step:rot2]) [a*cos(t)+a, b*sin(t)*(1+d*cos(t))]]; //Centered at a apex to avoid inverted face

function DishShape (a,b,c,d) = 
  concat(
//   [[c+a,b]],
    ellipse(a, b, d = 0,rot1 = 90, rot2 = 270)
//   [[c+a,-b]]
  );

function oval_path(theta, phi, a, b, c, deform = 0) = [
 a*cos(theta)*cos(phi), //x
 c*sin(theta)*(1+deform*cos(theta)) , // 
 b*sin(phi),
]; 
  
path_trans2 = [for (t=[0:step:180])   translation(oval_path(t,0,10,15,2,0))*rotation([0,90,0])];


//--------------Function definng Cap 
function CapTranslation(t, keyID) = 
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*KeyHeight(keyID))    //Z shift
  ];

function InnerTranslation(t, keyID) =
  [
    ((1-t)/layers*TopWidShift(keyID)),   //X shift
    ((1-t)/layers*TopLenShift(keyID)),   //Y shift
    (t/layers*(KeyHeight(keyID)-topthickness))    //Z shift
  ];

function CapRotation(t, keyID) =
  [
    ((1-t)/layers*XAngleSkew(keyID)),   //X shift
    ((1-t)/layers*YAngleSkew(keyID)),   //Y shift
    ((1-t)/layers*ZAngleSkew(keyID))    //Z shift
  ];

function CapTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopWidthDiff(keyID)) + (1-pow(t/layers, WidExponent(keyID)))*BottomWidth(keyID),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)) + (1-pow(t/layers, LenExponent(keyID)))*BottomLength(keyID)
  ];
function CapRoundness(t, keyID) = 
  [
    pow(t/layers, ChamExponent(keyID))*(CapRound0f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound0i(keyID),
    pow(t/layers, ChamExponent(keyID))*(CapRound1f(keyID)) + (1-pow(t/layers, ChamExponent(keyID)))*CapRound1i(keyID)
  ];
  
function InnerTransform(t, keyID) = 
  [
    pow(t/layers, WidExponent(keyID))*(BottomWidth(keyID) -TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, WidExponent(keyID)))*(BottomWidth(keyID) -wallthickness*2),
    pow(t/layers, LenExponent(keyID))*(BottomLength(keyID)-TopLenDiff(keyID)-wallthickness*2) + (1-pow(t/layers, LenExponent(keyID)))*(BottomLength(keyID)-wallthickness*2)
  ];
  

///----- KEY Builder Module
module stem_only(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, crossSection = true,Legends = false, homeDot = false, Stab = 0) {
    difference(){
        keycap(
          keyID  = keyID, //change profile refer to KeyParameters Struct
          cutLen = cutLen, //Don't change. for chopped caps
          Stem   = true, //tusn on shell and stems
          Dish   = Dish, //turn on dish cut
          Stab   = Stab,
          visualizeDish = visualizeDish, // turn on debug visual of Dish
          crossSection  = crossSection, // center cut to check internal
          homeDot = homeDot, //turn on homedots
          Legends = Legends
         );
        keycap(
          keyID  = keyID, //change profile refer to KeyParameters Struct
          cutLen = cutLen, //Don't change. for chopped caps
          Stem   = false, //tusn on shell and stems
          Dish   = Dish, //turn on dish cut
          Stab   = Stab,
          visualizeDish = visualizeDish, // turn on debug visual of Dish
          crossSection  = crossSection, // center cut to check internal
          homeDot = homeDot, //turn on homedots
          Legends = Legends
         );
    }
}

module keycap(keyID = 0, cutLen = 0, visualizeDish = false, rossSection = false, Dish = true, Stem = false, crossSection = true,Legends = false, homeDot = false, Stab = 0) {
  
  //Set Parameters for dish shape
  FrontPath = quantize_trajectories(FrontTrajectory(keyID), steps = stepsize, loop=false, start_position= $t*4);
  BackPath  = quantize_trajectories(BackTrajectory(keyID),  steps = stepsize, loop=false, start_position= $t*4);
  
  //Scaling initial and final dim tranformation by exponents
  function FrontDishArc(t) =  pow((t)/(len(FrontPath)),FrontArcExpo(keyID))*FrontFinArc(keyID) + (1-pow(t/(len(FrontPath)),FrontArcExpo(keyID)))*FrontInitArc(keyID); 
  function BackDishArc(t)  =  pow((t)/(len(FrontPath)),BackArcExpo(keyID))*BackFinArc(keyID) + (1-pow(t/(len(FrontPath)),BackArcExpo(keyID)))*BackInitArc(keyID); 

  FrontCurve = [ for(i=[0:len(FrontPath)-1]) transform(FrontPath[i], DishShape(DishDepth(keyID), FrontDishArc(i), 1, d = 0)) ];  
  BackCurve  = [ for(i=[0:len(BackPath)-1])  transform(BackPath[i],  DishShape(DishDepth(keyID),  BackDishArc(i), 1, d = 0)) ];
  
  //builds
  difference(){
    union(){
      difference(){
        skin([for (i=[-1:layers-1]) transform(translation(CapTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(CapTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]); //outer shell
        
        //Cut inner shell
        if(Stem == true){ 
          translate([0,0,-.1])skin([for (i=[-1:layers-7]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
        }else{
          translate([0,0,-.1])skin([for (i=[-1:layers-1]) transform(translation(InnerTranslation(i, keyID)) * rotation(CapRotation(i, keyID)), elliptical_rectangle(InnerTransform(i, keyID), b = CapRoundness(i,keyID),fn=fn))]);
         }
        // Cut off the extra bottom due to starting at layer -1
        translate ([-50,-50,-10]) cube ([100,100,10], center=false);
      }
      if(Stem == true){
         translate([0,0,StemBrimDep])rotate(stemRot)difference(){   
          cylinder(d=5.75,KeyHeight(keyID)-StemBrimDep, $fn= 32);
          skin(StemCurve);
          skin(StemCurve2);
        }
      }
      //cut for fonts and extra pattern for light?
      // Add bridges for better plate adhesion, these can easily be snipped off
      //for (i=[35:90:360]) { rotate(i)translate([-0.3,2,0])cube([0.6,7,0.3]); rotate(i)translate([-0.4,3,0])cube([0.8,7,0.3]); }
    }
    
    //Cuts
    
    //Fonts
    if(Legends ==  true){
//          #rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])
      translate([0,0,KeyHeight(keyID)-5])linear_extrude(height =5)text( text = "A", font = "Calibri:style=Bold", size = 4, valign = "center", halign = "center" );
      }
   //Dish Shape 
    if(Dish == true){
     if(visualizeDish == false){
      translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } else {
      #translate([-TopWidShift(keyID),.00001-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)]) rotate([0,-YAngleSkew(keyID),0])rotate([0,-90+XAngleSkew(keyID),90-ZAngleSkew(keyID)])skin(FrontCurve);
      #translate([-TopWidShift(keyID),-TopLenShift(keyID),KeyHeight(keyID)-DishHeightDif(keyID)])rotate([0,-YAngleSkew(keyID),0])rotate([0,-90-XAngleSkew(keyID),270-ZAngleSkew(keyID)])skin(BackCurve);
     } 
   }
     if(crossSection == true) {
       translate([0,-15,-.1])cube([15,30,20]); 
//      translate([-15.1,-15,-.1])cube([15,30,20]); 
     }
    if(homeDot == true){
      // center dot
      #translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-0.1])sphere(r = dotRadius); // center dot
      // double bar dots
//      rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([.75,-4.5,KeyHeight(keyID)-DishHeightDif(keyID)+0.5])sphere(r = dotRadius); // center dot
//      rotate([-XAngleSkew(keyID),YAngleSkew(keyID),ZAngleSkew(keyID)])translate([-.75,-4.5,KeyHeight(keyID)-DishHeightDif(keyID)+0.5])sphere(r = dotRadius); // center dot
      //tri center dots
//     #rotate([0,YAngleSkew(keyID),ZAngleSkew(keyID)])translate([0,0,KeyHeight(keyID)-DishHeightDif(keyID)-0.1]){
//        rotate([0,0,0])translate([0,.75,0])sphere(r = dotRadius); // center dot
//        rotate([0,0,120])translate([0,.75,0])sphere(r = dotRadius); // center dot
//        rotate([0,0,240])translate([0,.75,0])sphere(r = dotRadius); // center dot
//      }
    }
  }
  //Homing dot
  
}
//------------------stems 

MXWid = 4.03/2+Tol; //horizontal lenght
MXLen = 4.23/2+Tol; //vertical length

MXWidT = 1.15/2+Tol; //horizontal thickness
MXLenT = 1.25/2+Tol; //vertical thickness

function stem_internal(sc=1) = sc*[
[MXLenT, MXLen],[MXLenT, MXWidT],[MXWid, MXWidT],
[MXWid, -MXWidT],[MXLenT, -MXWidT],[MXLenT, -MXLen],
[-MXLenT, -MXLen],[-MXLenT, -MXWidT],[-MXWid, -MXWidT],
[-MXWid,MXWidT],[-MXLenT, MXWidT],[-MXLenT, MXLen]
];  //2D stem cross with tolance offset and additonal transformation via jog 
//trajectory();
function StemTrajectory() = 
  [ trajectory(forward = 5.25) ];
  
  StemPath  = quantize_trajectories(StemTrajectory(),  steps = 1 , loop=false, start_position= $t*4);
  StemCurve  = [ for(i=[0:len(StemPath)-1])  transform(StemPath[i],  stem_internal()) ];


function StemTrajectory2() = 
  [trajectory(forward = .5)];

StemPath2  = quantize_trajectories(StemTrajectory2(),  steps = 10, loop=false, start_position= $t*4);
StemCurve2  = [for(i=[0:len(StemPath2)-1])  transform(StemPath2[i]*scaling([(1.1-.1*i/(len(StemPath2)-1)),(1.1-.1*i/(len(StemPath2)-1)),1]), stem_internal())]; 

/// ----- helper functions 
function elliptical_rectangle(a = [1,1], b =[1,1], fn=32) = [
    for (index = [0:fn-1]) // section right
     let(theta1 = -atan(a[1]/b[1])+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta1), a[1]*sin(theta1)]
    + [a[0]*cos(atan(b[0]/a[0])) , 0]
    - [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    - [0, b[0]*sin(atan(b[0]/a[0]))]
    + [0, a[1]*sin(atan(a[1]/b[1]))],

    for(index = [0:fn-1]) // section left
     let(theta2 = -atan(a[1]/b[1])+180+ 2*atan(a[1]/b[1])*index/fn) 
      [b[1]*cos(theta2), a[1]*sin(theta2)]
    - [a[0]*cos(atan(b[0]/a[0])) , 0]
    + [b[1]*cos(atan(a[1]/b[1])) , 0],
    
    for(index = [0:fn-1]) // section Top
     let(theta2 = atan(b[0]/a[0]) + 180 + (180 -2*atan(b[0]/a[0]))*index/fn) 
      [a[0]*cos(theta2), b[0]*sin(theta2)]
    + [0, b[0]*sin(atan(b[0]/a[0]))]
    - [0, a[1]*sin(atan(a[1]/b[1]))]
]/2;
