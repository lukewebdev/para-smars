//Soporte para utilizar dos pilas 18650 en el SMARS
//por Manuel Miranda Melián 2018

$fn=32;
showBatterySystem();


slotHeight=8;
module showBatterySystem(){
    union() {
      difference() {
        //caja principal
        translate([0,0,1])
        minkowski() {
          cube([66.5,65,5.1],center=true);
          sphere(r=1,center=true);
        }

        //apertura superior
        translate([0,0,1.5])
        cube([55,100,10],center=true);
        //recorte trasero
        translate([0,-33.1,1])
        cube([50,8,7.1],center=true);  
        //conector spi
        translate([-1,31,1])
        cube([8,6,7.1],center=true);
        //muesca portabaterias
        translate([33.5,0,-1])
        cube([1.5,32,1.5],center=true);
        translate([-33.5,0,-1])
        cube([1.5,32,1.5],center=true);
        //top slots
        translate([31.5,20,1])
        cube([2.2,8.5,7.1],center=true);
        
        translate([-31.5,20,1])
        cube([2.2,8.5,7.1],center=true);
        
        translate([31.5,-20,1])
        cube([2.2,8.5,7.1],center=true);
        
        translate([-31.5,-20,1])
        cube([2.2,8.5,7.1],center=true);
      }
      
     /* quarterround(12.5, 65.5);
      mirror(1,0,0)
      quarterround(12.5, 65.5);*/

    }
    //portabaterias

    translate([60,0,7])
    portabaterias();

    translate([-60,0,7])
    mirror([1,0,0])
    portabaterias();    
}



//differenceBatterySlots();
module differenceBatterySlots(){


        //muesca portabaterias
        translate([33.5,0,-1])
        cube([1.5,32,1.5],center=true);
        translate([-33.5,0,-1])
        cube([1.5,32,1.5],center=true);
        //top slots
        translate([31.5,20,1])
        cube([2.2,8.5,slotHeight],center=true);
        
        translate([-31.5,20,1])
        cube([2.2,8.5,slotHeight],center=true);
        
        translate([31.5,-20,1])
        cube([2.2,8.5,slotHeight],center=true);
        
        translate([-31.5,-20,1])
        cube([2.2,8.5,slotHeight],center=true);


    translate([60,0,7])
    portabaterias();

    translate([-60,0,7])
    mirror([1,0,0])
    portabaterias();    
}


module portabaterias() {
  translate([0,0,1])
  difference() {
    union() {
      minkowski() {      
        difference() {
          rotate([90,0,0])
          cylinder(d=20,h=69,center=true);
          translate([0,0,10.5])
          cube([20,70,19],center=true);
          translate([0,0,4.5])
          cube([20,30,19],center=true);
        }
        sphere(r=1,center=true);
      }
      //muesca inferior
      translate([-5,0,-8.5])
      cube([10,30,5],center=true);
      translate([-10.5,0,-10.5])
      cube([2,30,1],center=true);
    }
    rotate([90,0,0])
    cylinder(d=18.5,h=68,center=true);
    //contactos
    translate([0,-34,-6])
    cylinder(d=1.3,h=10,center=true);
    translate([0,34,-6])
    cylinder(d=1.3,h=10,center=true);
    translate([0,-38.5,-11])
    rotate([90,0,0])
    cylinder(d=1.3,h=10,center=true);
    translate([0,38.5,-11])
    rotate([90,0,0])
    cylinder(d=1.3,h=10,center=true);

  }
  //support clips
  translate([-13,20,-7])
  soporte_portapila();
  translate([-13,-20,-7])
  soporte_portapila();
}

module soporte_portapila() {
  difference() {
    translate([0,0,1])
    cube([1.5,7,4],center=true);
    translate([1.7,0,-1.1])
    rotate([0,-60,0])
    cube([1.6,7.1,3.1],center=true);
  }
  translate([1.75,0,3])
  cube([5,7,1.5],center=true);
  translate([0,0,4])
  cube([1,3,2],center=true);
  translate([0.5,0,5.5])
  rotate([0,30,0])
  cube([1,3,2],center=true);

}





module quarterround(qd, qh){
    translate([-27.5,0,-2.5])
    rotate([90,0,0])
    color("red")
    

    difference(){

        cylinder(h=qh, d=qd, center = true);
        translate([qd/2,0,0])
        cube([qd, qd, qh+2], center = true);
        translate([-qd/2,qd/2,0])
        cube([qd, qd, qh+2], center = true);        
        translate([qd/2,-qd/2,0])
        cube([qd, qd*2, qh+2], center = true);                    
    }
}
