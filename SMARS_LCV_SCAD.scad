//DEVEL ONLY - COMMENT OUT FOR EXPORT
$fa=1;
$fs=1.5;

//END DEVEL ONLY



use <use/openscad/roundedCube.scad>

mount_plate_diamter = 34;
battery_w = 21.7;
battery_h = 42;
battery_l = 89;//max 65 before chassis has to be extended  
wall_width = 3;
radius = 20;

chassis_w = 60;
chassis_h = 35;
chassis_l = 100;

chassis();
SL_axles();





module chassis(){
    //main box
    difference(){
        roundedCube([chassis_l,chassis_w,chassis_h], xcorners=[true,false,false,true], zcorners=[true,false,false,true], r=radius, x=true, y=true, z=true, center=true, $fn=30);
        
        
        ///main cavity
       roundedCube([chassis_l-wall_width,chassis_w-wall_width,chassis_h-wall_width], xcorners=[true,false,false,true], zcorners=[true,false,false,true], r=radius, x=true, y=true, z=true, center=true, $fn=30);
        
        
        //cut off top
        translate([0,0,chassis_h/2])
        cube([chassis_l+wall_width/2,chassis_w+wall_width/2,radius], center=true);   
    }
}

module SL_axles(){
    union(){
        rotate([0,0,90])
        translate([-125,-80,-10])

        import("import/SMARS_LCSL_CHASSIS_AXLES_fixed.stl");
        
        
        rotate([0,0,-90])
        translate([0,0,-10])
        union(){
            hub();
            mirror([1,0,0])
            hub(); 
        }
        
    }
    
    
}


module hub(){
    color("green")
    translate([27,-25,8])
    rotate([0,90,0])
  
    cylinder(h=3.5, d=16, center = false, $fn=0);
}  