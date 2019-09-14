// integrator 

inch = 25.4;

b1590a_y = 40;
b1590a_x = 92;
b1590a_z = 31;

b1590b_y = 65;
b1590b_x = 115;
b1590b_z = 35;

wall = 3;

pcb_x = 3.35*inch;
pcb_y = 2 * inch;
pcb_z = 1.6;

switch_x = 12.7;
spdt_y = 6.86;
dpdt_y = 11.43;
switch_z = 8.89;
lever = 10.41;

banana_z = 31;
b_out = 6.35;
b_in = banana_z - b_out;

module bananaJack() {
  translate([0,0,-b_in])
    cylinder(1,r=3.81/2);
  translate([0,0,-b_in+1])
    cylinder(3.3,r=2.29/2);
  translate([0,0,-b_in+4.3])
    cylinder(b_in-4.3,r=9.5/2);
  difference() {
    cylinder(b_out,r=6.35);
    cylinder(b_out+1,r=6.35/2);
  }
}

module phoneJack() {
  color("gray")
  rotate([-90,0,0]) {
    translate([0,0,-0.55*inch]) {
      difference() {
        cylinder(1.2*inch,r=6.35);
        translate([0,0,1.1548*inch])
          cylinder(50,r=6.35/2);
      }
      translate([-0.4*inch,-6.35,0])
        cube([0.8*inch,6.35,0.95*inch]);
    }
  }
}

pj_x = 0.35*inch;
module powerJack() {
  color("black")
   translate([-pj_x/2,0,0])
    cube([pj_x,0.70*inch,0.5*inch]);
}

module minispdt() {
  translate([-switch_x/2,-spdt_y/2,-pcb_z])
    cube([switch_x,spdt_y,switch_z+pcb_z]);
  translate([0,0,switch_z])
    cylinder(switch_z,r=6.35/2);
  translate([0,0,switch_z*2])
    rotate([0,15,0]) cylinder(lever,r=2);
}

module minidpdt() {
  translate([-switch_x/2,-dpdt_y/2,0])
    cube([switch_x,dpdt_y,switch_z]);
  translate([0,0,switch_z])
    cylinder(switch_z,r=6.35/2);
  translate([0,0,switch_z*2])
    rotate([0,10,0]) cylinder(lever,r=2);
}

module pcb() {
  color("green")
    cube([pcb_x,pcb_y,pcb_z]);
  color("gray") {
//    translate([0.35*inch,0.35*inch,pcb_z])
    translate([0.9*inch,0.35*inch,pcb_z])
      rotate([0,0,90]) minispdt();
//    translate([1.05*inch,0.35*inch,pcb_z])
    translate([1.6*inch,0.35*inch,pcb_z])
      rotate([0,0,90]) minidpdt();
    translate([2.3*inch,0.35*inch,pcb_z])
      rotate([0,0,90]) minispdt();
    translate([3*inch,0.35*inch,pcb_z])
      rotate([0,0,90]) minispdt();
  }
  
  translate([1*inch,1.6*inch,-6.35])
    phoneJack();
//  translate([0,0.5*inch,-pcb_z])
//    rotate([180,0,0])
    translate([6.35,1.6*inch,-pcb_z-12])
      powerJack();
// trim cap
  translate([2.36*inch,1.34*inch,-5])
    cylinder(4,r=2.5);  
  
  translate([0.9*inch,1*inch,pcb_z])
  color("green") cylinder(10,r=1.5,$fn=16);
  translate([0.9*inch,1*inch,switch_z+wall])
  color("green") sphere(1.5,$fn=32);
}

module roundedBox(x,y,z,rad=5) {
translate([rad,rad,0])
  minkowski() {
    cube([x-rad*2,y-rad*2,z-rad*3]);
    cylinder(z-rad*4,r=rad);
  }

}

module b1590a() {
  color([0.5,0.5,1])
  roundedBox(b1590a_x,b1590a_y,b1590a_z);

  color("black")
   translate([b1590a_x-10,10,b1590a_z])
    rotate([0,0,90])
    linear_extrude(2) text(label,b1590a_x/2);
}

module b1590b() {

  difference() {
    roundedBox(b1590b_x,b1590b_y,b1590b_z,5);
    translate([wall,wall,-wall])
      roundedBox(b1590b_x-wall*2,b1590b_y-wall*2,b1590b_z,5);

  }
}

b1590b();
translate([wall+2,wall+6,b1590b_z-wall-switch_z])
  pcb();

translate([b1590b_x,20,b1590b_z/2])
  rotate([0,90,0])
    color("red") bananaJack();
translate([b1590b_x,45,b1590b_z/2])
  rotate([0,90,0])
    color("black") bananaJack();

translate([b1590b_x-40,b1590b_y,b1590b_z/2])
  rotate([-90,0,0])
    color("green") bananaJack();