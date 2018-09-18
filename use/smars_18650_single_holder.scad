//Soporte para utilizar dos pilas 18650 en el SMARS
//por Manuel Miranda Melián 2018
//use <use/openscad/Shapes.scad>
//$fn=50;
//battery_holders();
battery_holder_single();
/*
union() {
  difference() {
    //caja principal
    translate([0,0,1])
    minkowski() {
      cube([66.5,72,5.1],center=true);
      sphere(r=1,center=true);
    }
    //muesca soporte
    translate([0,0,-2.5])
    cube([59,69,5.1],center=true);
    //apertura superior
    translate([0,0,1.5])
    cube([53,66,7.1],center=true);
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
    //soportes portabaterias
    translate([31.5,29,1])
    cube([2.2,8.5,7.1],center=true);
    translate([-31.5,29,1])
    cube([2.2,8.5,7.1],center=true);
    translate([31.5,-29,1])
    cube([2.2,8.5,7.1],center=true);
    translate([-31.5,-29,1])
    cube([2.2,8.5,7.1],center=true);
  }
  
}*/
/*
//soportes centrales
translate([29,0,-6])
difference() {
  cube([4,6,12],center=true);
  translate([-1,0,-5])
  cube([2.6,6.1,2.1],center=true);
}

translate([-29,0,-6])
difference() {
  cube([4,6,12],center=true);
  translate([1,0,-5])
  cube([2.6,6.1,2.1],center=true);
}

//enlaces patas arduino
translate([27,-19.75,2.3])
cube([6,4,4.4],center=true);

translate([-26,-18.5,2.3])
cube([6,4,4.4],center=true);

*/
//portabaterias


module battery_holder_single(){



    portabaterias();
    
 
/*
translate([-60,0,7])
mirror([1,0,0])
portabaterias();*/

}


module triangles(){
    
  /*
    color("blue")
    translate([-5,-30,-10])
    rotate([90,90,0])

    Right_Angled_Triangle(
   17,17, height=9, 
    center=true);*/
    
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
          translate([10,0,4.5])
          cube([100,40,41],center=true);
        }
        sphere(r=1,center=true);
      }
      
      //muesca inferior
     /* translate([-5,0,-8.5])
      cube([10,30,5],center=true);
      translate([-10.5,0,-10.5])
      cube([2,30,1],center=true);*/
    triangles();
      translate([0,60,0])
    triangles();
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
   
    
    

  //soportes
 /* translate([-13,29,-7])
  soporte_portapila();
  translate([-13,-29,-7])
  soporte_portapila();*/
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







