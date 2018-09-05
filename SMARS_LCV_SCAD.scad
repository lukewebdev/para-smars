//DEVEL ONLY - COMMENT OUT FOR EXPORT
$fa=1;
$fs=1.5;

//END DEVEL ONLY



use <use/openscad/roundedCube.scad>

mount_plate_diameter = 28;
battery_w = 21.7;
battery_h = 42;
battery_l = 89;//max 65 before chassis has to be extended  
wall_width = 3;
radius = 20;

chassis_w = 50;
chassis_h = 35;
chassis_l =200;

chassis();
SL_axles();
stepper_mount_plate();


module chassis_exterior_subtract(){
      render()
        roundedCube([chassis_l,chassis_w,chassis_h], xcorners=[true,false,false,true], zcorners=[true,false,false,true], r=radius, x=true, y=true, z=true, center=true, $fn=30);
}


module chassis_interior_subtract(){
        render()
        ///main cavity
       roundedCube([chassis_l-wall_width,chassis_w-wall_width,chassis_h-wall_width], xcorners=[true,false,false,true], zcorners=[true,false,false,true], r=radius, x=true, y=true, z=true, center=true, $fn=30);

}

module chassis_top_subtract(){
        //cut off top
    render()
        translate([0,0,chassis_h/2])
        cube([chassis_l+wall_width/2,chassis_w+wall_width/2+5,radius], center=true);     
}
module chassis(){
    //main box
    //render()
    difference(){
        chassis_exterior_subtract();
        chassis_interior_subtract();
        chassis_top_subtract();
        
  
    }
}

module SL_axles(){
    //render()
    difference(){
        union(){
            rotate([0,0,90])
            //center the axles
            translate([-125,-105,-10])
            //now move proportional to length of chassis
            translate([0,chassis_l/2-25,0])
            import("import/SMARS_LCSL_CHASSIS_AXLES_fixed.stl");
            
            

                hub();

            
        }
        chassis_exterior_subtract();
    }
}


module hub(){
    //render(){
    
        rotate([0,0,90])

        color("red")
        translate([0,-0,0])//center
        translate([0,chassis_l/2-25,-2.5])
        rotate([0,90,0])

        cylinder(h=chassis_w+5, d=15.5, center = true, $fn=0);
    //  }
}  


module stepper_mount_plate(){  
    difference(){
       union(){
            translate([chassis_l/2 - (mount_plate_diameter/2)-2 ,0,0])
            rotate([90,90,0])
            cylinder(h=chassis_w + 4, d= mount_plate_diameter, center = true, $fn=0);
        } 
           chassis_exterior_subtract();
           chassis_top_subtract();
    }
    
}