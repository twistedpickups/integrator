pole_rad = 2.5;
flange_z = 2.4;
flange_y = 18;
bobbin_z = 10;
pole_x = 52;
cover_rad = 10;
eye_z = pole_x + cover_rad*2+2;
$fn=32;

difference() {
  translate([-bobbin_z/2-flange_z,-flange_y/2,0])
    cube([flange_z,flange_y,pole_x+pole_rad*2+32]);
  // eyelet holes
    translate([0,-5,eye_z])
      rotate([0,-90,0])
        cylinder(20,r=1.5);
    translate([0,5,eye_z])
      rotate([0,-90,0])
        cylinder(20,r=1.5);

  // zip tie holes
    translate([-bobbin_z/2-4,-9,eye_z+5])
        cube([5,2,5]);
    translate([-bobbin_z/2-4,8-1,eye_z+5])
      cube([5,2,5]);
}


translate([-bobbin_z/2,-pole_rad,6+pole_rad])
  cube([bobbin_z,pole_rad*2,pole_x]);
translate([-bobbin_z/2,0,6+pole_rad])
  rotate([0,90,0]) cylinder(bobbin_z,r=pole_rad);
translate([-bobbin_z/2,0,pole_x+6+pole_rad])
  rotate([0,90,0]) cylinder(bobbin_z,r=pole_rad);
difference() {
  translate([bobbin_z/2,-(cover_rad+2),0])
    cube([7,cover_rad*2+4,pole_x+pole_rad*2+12]);

  translate([bobbin_z/2+flange_z+2,0,pole_x+6+pole_rad])
    rotate([0,90,0]) cylinder(10,r=cover_rad);
  translate([bobbin_z/2+flange_z+2,0,6+pole_rad])
    rotate([0,90,0]) cylinder(10,r=cover_rad);

  translate([bobbin_z/2+flange_z+2,-cover_rad,6+pole_rad])
    cube([bobbin_z,cover_rad*2,pole_x]);

  hull() {
    translate([bobbin_z/2+2,0,6+pole_rad])
      rotate([0,90,0]) cylinder(bobbin_z,r=pole_rad+1);
    translate([bobbin_z/2+2,0,6+pole_rad+pole_x])
      rotate([0,90,0]) cylinder(bobbin_z,r=pole_rad+1);
  }
  
  translate([bobbin_z/2+3,-15,eye_z-2])
    cube([5,30,20]);
}

