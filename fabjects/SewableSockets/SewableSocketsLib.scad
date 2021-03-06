// SewableSockets Library
// Version 20100421

// Copyright 2010, by Andrew Plumb
// Licensed under the Attribution - Creative Commons license
//   http://creativecommons.org/licenses/by/3.0/

// For more information about OpenSCAD:
//   - see http://www.openscad.org/

$fa=9;
$fs=0.1;

scale_1in=25.4;

// render_part=1; // DIP Socket Holes
// render_part=2; // DIP Socket Body
// render_part=3; // DIP Socket
// render_part=4; // pin_hole
// render_part=5; // pin_hole_odd
// render_part=6; // pin_hole_even
// render_part=7; // DIP Socket Holes Alternating
// render_part=8; // DIP Socket Alternating
// render_part=9; // SIP Socket Holes Alternating
 render_part=10; // ATmega168_w_16MHz

module nut_blank(
        nut_w=5.5
        , nut_h=2.5
        ) {
  scale([nut_w,nut_w,nut_h]) import_stl("../libraries/primitives/unit_hexagon.stl");
}

module pin_hole(
	rotAngle=0
	, holeHeight=5.0
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/4
	, pinHoleDepth=0.15*scale_1in
	) {
  rotate([0,0,rotAngle]) union () {
    translate([0,0,-pinSpace/2])
	cylinder(r2=pinSpace
	  , r1=0
	  , h=pinSpace
	  , center=false);
    translate([0,0,-holeHeight]) {
	rotate([0,0,0])
	 scale([sqrt(2)*pinHoleWidth,sqrt(2)*pinHoleWidth,holeHeight])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	rotate([90,0,0]) rotate([0,0,45]) {
	 scale([pinHoleWidth,pinHoleWidth,holeHeight])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
	translate([0,0,-pinHoleWidth/2]) {
	  cylinder(r1=2*pinHoleWidth
		, r2=0
		, h=2*pinHoleWidth
		, center=false);
	  translate([0,-holeHeight+pinHoleWidth/2,0])
	    cylinder(r1=2*pinHoleWidth
		, r2=0
		, h=2*pinHoleWidth
		, center=false);
	}
	translate([0,-holeHeight,0]) {
	   rotate([-45,0,0]) rotate([0,0,0]) 
	    scale([sqrt(2)*pinHoleWidth,sqrt(2)*pinHoleWidth,sqrt(2)*holeHeight])
	     translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
    }
  }
}

module pin_hole_odd(
	rotAngle=0
	, holeHeight=5.0
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/4
	, pinHoleDepth=0.15*scale_1in
	) {
  rotate([0,0,rotAngle]) union () {
    translate([0,pinSpace,-1.5])
	rotate([0,0,30]) nut_blank(nut_w=3.2, nut_h=1.3+pinSpace);
    translate([0,pinSpace,-holeHeight-pinHoleWidth]) {
	rotate([0,0,90+30]) nut_blank(nut_w=1.6,nut_h=holeHeight+2*pinHoleWidth);
    }	
    translate([0,0,-holeHeight-pinHoleWidth]) {
	rotate([0,0,90]) nut_blank(nut_w=1.6,nut_h=holeHeight+2*pinHoleWidth);
	translate([0,pinSpace+sqrt(2)*pinHoleWidth,1.5*pinHoleWidth]) rotate([90,0,0]) rotate([0,0,45]) {
	 scale([2*pinHoleWidth,2*pinHoleWidth,holeHeight+3*pinSpace+pinHoleWidth])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
    }
    translate([0,-pinSpace/2,-sqrt(2)*pinHoleWidth]) {
	translate([0,pinSpace+sqrt(2)*pinHoleWidth,1.5*pinHoleWidth]) rotate([90,0,0]) rotate([0,0,45]) {
	 scale([1.6/2,1.6/2,holeHeight+2*pinSpace+pinHoleWidth])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
    }  }
}

module pin_hole_even(
	rotAngle=0
	, holeHeight=5.0
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/4
	, pinHoleDepth=0.15*scale_1in
	) {
  rotate([0,0,rotAngle]) union () {
    translate([0,-pinSpace,-1.5])
	rotate([0,0,30]) nut_blank(nut_w=3.2, nut_h=1.3+pinSpace);
    translate([0,-pinSpace,-holeHeight-pinHoleWidth]) {
	rotate([0,0,90+30]) nut_blank(nut_w=1.6,nut_h=holeHeight+2*pinHoleWidth);
    }	
    translate([0,0,-holeHeight-pinHoleWidth]) {
	rotate([0,0,90]) nut_blank(nut_w=1.6,nut_h=holeHeight+2*pinHoleWidth);
	translate([0,sqrt(2)*pinHoleWidth,1.5*pinHoleWidth]) rotate([90,0,0]) rotate([0,0,45]) {
	 scale([2*pinHoleWidth,2*pinHoleWidth,holeHeight+2*pinSpace+pinHoleWidth])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
    }
    translate([0,-1.6/2,-sqrt(2)*pinHoleWidth]) {
	translate([0,sqrt(2)*pinHoleWidth,1.5*pinHoleWidth]) rotate([90,0,0]) rotate([0,0,45]) {
	 scale([1.6/2,1.6/2,holeHeight+pinSpace+pinHoleWidth])
	  translate([-0.5,-0.5,0]) cube(size=1.0, center=false);
	}
    }
  }
}


module dip_socket_holes(
	socketHeight=5.0
	, pinCount=28
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/3
	, pinHoleDepth=0.15*scale_1in
	, pinRowSpace=3.25*0.1*scale_1in
	, pkgLength=14.0*0.1*scale_1in
	, pkgWidth=3.0*0.1*scale_1in
	) {
  union () {
    translate([0,0,-socketHeight-pinHoleWidth]) rotate([0,0,-135]) {
	cylinder(r=pinRowSpace/8,h=socketHeight+2*pinHoleWidth,center=false);
	scale([pinRowSpace/8,pinRowSpace/8,socketHeight+2*pinHoleWidth]) cube(size=1.0);
    }
    for( i=[0:(pinCount/2-1)] ) {
      assign(pinPos=pinSpace*i) {
	  echo("dip_socket_holes: Pin ",i+1,"X:",pinPos," Y:",pinRowSpace/2);
	  translate([pinPos,pinRowSpace/2,0])
	    pin_hole(rotAngle=180);
	  echo("dip_socket_holes: Pin ",pinCount-i,"X:",pinPos," Y:",-pinRowSpace/2);
	  translate([pinPos,-pinRowSpace/2,0])
	    pin_hole(rotAngle=0);
	 }
    }
  }
}

module dip_socket_holes_alternating(
	, debug=0
	, pinRotAngle=0
	, socketHeight=5.0
	, pinCount=28
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/3
	, pinHoleDepth=0.15*scale_1in
	, pinRowSpace=3.25*0.1*scale_1in
	, pkgLength=14.0*0.1*scale_1in
	, pkgWidth=3.0*0.1*scale_1in
	) {
  if(debug!=0) echo("dip_socket_holes_alternating: debug",debug);
  union () {
    translate([-1.5*pinSpace,0,-socketHeight-pinHoleWidth]) rotate([0,0,-135])
	cylinder(r2=1.6,r1=1.6/2,h=socketHeight+2*pinHoleWidth,center=false);
    for( i=[0:(pinCount/2-1)] ) {
      assign(pinPos=pinSpace*i) {
	  if(debug==1) echo("  dip_socket_holes_alternating: Pin ",i+1,"X:",pinPos," Y:",pinRowSpace/2);
	  translate([pinPos,pinRowSpace/2,0]) {
	    if (i%2==0) pin_hole_even(rotAngle=180+pinRotAngle);
	    if (i%2==1) pin_hole_odd(rotAngle=180+pinRotAngle);
	  }
	  if(debug==1) echo("  dip_socket_holes_alternating: Pin ",pinCount-i,"X:",pinPos," Y:",-pinRowSpace/2);
	  translate([pinPos,-pinRowSpace/2,0]) {
	    if (i%2==0) pin_hole_odd(rotAngle=0+pinRotAngle);
	    if (i%2==1) pin_hole_even(rotAngle=0+pinRotAngle);
	  }
	 }
    }
  }
}

module sip_socket_holes_alternating(
	, debug=0
	, pinRotAngle=0
	, socketHeight=5.0
	, pinCount=3
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/3
	, pinHoleDepth=0.15*scale_1in
//	, pinRowSpace=3.25*0.1*scale_1in
	, pkgLength=14.0*0.1*scale_1in
	, pkgWidth=3.0*0.1*scale_1in
	) {
  if(debug!=0) echo("sip_socket_holes_alternating: debug",debug);
  union () {
    translate([-1.5*pinSpace,0,-socketHeight-pinHoleWidth]) rotate([0,0,-135])
	cylinder(r2=1.6,r1=1.6/2,h=socketHeight+2*pinHoleWidth,center=false);
    for( i=[0:(pinCount-1)] ) {
      assign(pinPos=pinSpace*i) {
	  if(debug==1) echo("  sip_socket_holes_alternating: Pin ",i+1,"X:",pinPos," Y:",0.0);
	  translate([pinPos,0,0]) {
	    if (i%2==0) pin_hole_even(rotAngle=pinRotAngle);
	    if (i%2==1) pin_hole_odd(rotAngle=pinRotAngle);
	  }
	 }
    }
  }
}


module dip_socket_body(
	socketHeight=5.0
	, pinCount=28
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/4
	, pinHoleDepth=0.15*scale_1in
	, pinRowSpace=3.25*0.1*scale_1in
	, pkgLength=14.0*0.1*scale_1in
	, pkgWidth=sqrt(2)*3.0*0.1*scale_1in
	) {
  union () {
    translate([-1.5*pinSpace,-(pinRowSpace+2*sqrt(2)*socketHeight)/2,-socketHeight])
      scale([(pinCount+4)*pinSpace/2,pinRowSpace+2*sqrt(2)*socketHeight,socketHeight])
	   cube(size=1.0, center=false);
  }
}

module sip_socket_body(
	socketHeight=5.0
	, pinCount=3
	, pinSpace=0.1*scale_1in
	, pinHoleWidth=0.1*scale_1in/4
	, pinHoleDepth=0.15*scale_1in
//	, pinRowSpace=3.25*0.1*scale_1in
	, pkgLength=14.0*0.1*scale_1in
	, pkgWidth=sqrt(2)*3.0*0.1*scale_1in
	) {
  union () {
    translate([-1.5*pinSpace,-(2*sqrt(2)*socketHeight)/2,-socketHeight])
      scale([(pinCount+2)*pinSpace,2*sqrt(2)*socketHeight,socketHeight])
	   cube(size=1.0, center=false);
  }
}

module dip_socket() {
  difference () {
	dip_socket_body();
	dip_socket_holes();
  }
}

module dip_socket_alternating() {
  difference () {
	dip_socket_body();
	dip_socket_holes_alternating(debug=1);
  }
}

module ATmega168_w_16MHz(debug=0) {
  difference () {
    union () {
	dip_socket_body();
	translate([20.32,4.1275+5*0.1*scale_1in,0]) sip_socket_body(pinCount=3);
    }
	dip_socket_holes_alternating(debug=debug,pinCount=28);
     translate([20.32,4.1275+5*0.1*scale_1in,0]) sip_socket_holes_alternating(pinCount=3);
  }
}

if( render_part==1 ) {
  echo("Rendering dip_socket_holes()...");
  dip_socket_holes();
}

if( render_part==2 ) {
  echo("Rendering dip_socket_body()...");
  dip_socket_body();
}

if( render_part==3 ) {
  echo("Rendering dip_socket()...");
  dip_socket();
}

if( render_part==4 ) {
  echo("Rendering pin_hole()...");
  pin_hole();
}

if( render_part==5 ) {
  echo("Rendering pin_hole_odd()...");
  translate([0,-10,0]) pin_hole_odd(rotAngle=0);
  translate([0,10,0])  pin_hole_odd(rotAngle=180);
}

if( render_part==6 ) {
  echo("Rendering pin_hole_even()...");
  translate([0,-10,0]) pin_hole_even(rotAngle=0);
  translate([0,10,0])  pin_hole_even(rotAngle=180);

}

if( render_part==7 ) {
  echo("Rendering dip_socket_holes_alternating()...");
  dip_socket_holes_alternating();
}

if( render_part==8 ) {
  echo("Rendering dip_socket_alternating()...");
  translate([0,0,5.0]) dip_socket_alternating();
}

if( render_part==9 ) {
  echo("Rendering sip_socket_holes_alternating()...");
  sip_socket_holes_alternating();
}

if( render_part==10 ) {
  echo("Rendering ATmega168_w_16MHz()...");
  ATmega168_w_16MHz();
}