//DEVEL ONLY - COMMENT OUT FOR EXPORT
$fa=1;
$fs=1.5;

//END DEVEL ONLY

use <use/openscad/hollowCylinder.scad>
use <use/openscad/torus.scad>
use <use/openscad/roundedCube.scad>
use <use/StepMotor_28BYJ-48.scad>
//STEPPER CONF
mount_plate_diameter = 30;

//BATTERY CONF
battery_w = 21.7;
battery_h = 42;
battery_l = 89;//max 65 before chassis has to be extended  


//CHASSIS CONF
wall_width = 3;
radius = 20;
chassis_w =  battery_w + 41.5;
chassis_h = battery_h + radius*1.4;
chassis_l =battery_l+radius*2;
rear_wheel_buffer = 11;

//WHEEL CONF
axle_d = 16;
axle_h = 16;

difference(){
    union(){
        chassis();
        SL_axles();
        stepper_mount_plate();
        battery_case();
    }    
    steppers();
    stepper_holes();
}

//show steppers? (don't print)
steppers();




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
    difference(){
            union(){

                SL_axle(); 
                mirror([0,1,0])
                SL_axle(); 
                hub();
        }
        chassis_exterior_subtract();
    }


}

module SL_axle(){
        //put at bottom
        translate([0,0,-chassis_h/2+radius/2])
        rotate([-90,0,0])
        translate([-chassis_l/2+radius,0,chassis_w/2-3 + axle_h/2])
        difference(){

            hollowCylinder(d=axle_d, h=axle_h, wallWidth=3, center=true, $fn=40);
            //inner chamfer
            torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true, $fn=40);
            //outer chamfer
            translate([0,0,9.5])
            torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true, $fn=40);
            
            //inner rim of outside axle
            translate([0,0,3])
            hollowCylinder(d=axle_d, h=2, wallWidth=.4, center=true, $fn=40);
            
            //slot for flex
            cube([3,axle_d,axle_h], center=true);
        }

    
    
}



module hub(){
    //render(){
        //put at bottom
        translate([0,0,-chassis_h/2+radius/2])
        color("red")
        translate([-chassis_l/2+radius,0,0])

        rotate([0,90,90])

        cylinder(h=chassis_w+1.5, d=axle_d, center = true, $fn=0);
    //  }
}  


module stepper_mount_plate(){  
    
    //put at bottom
    translate([0,0,-chassis_h/2+radius/2 + 28/6])
    difference(){
       union(){
            translate([chassis_l/2 - (mount_plate_diameter/2)-rear_wheel_buffer ,0,0])
            rotate([90,90,0])
            cylinder(h=chassis_w, d= mount_plate_diameter, center = true, $fn=0);
        } 
           chassis_exterior_subtract();
           chassis_top_subtract();
//        steppers();

    }
    
}



module stepper(){
    //same translate as stepper_mount_plate
    //put at bottom
    translate([0,0,-chassis_h/2+radius/2 + 28/6])
    translate([chassis_l/2 - (mount_plate_diameter/2)-rear_wheel_buffer ,-1,0])
    
    //now scoot it to the side
    translate([0,chassis_w/2-10,0])
    rotate([90,90,0])
    render()
    StepMotor28BYJ();
}
module steppers(){
    stepper();
    mirror([0,1,0])
    stepper();   
}



module stepper_holes(){ 
        w = chassis_w+4;
    //put at bottom
        translate([0,0,-chassis_h/2+radius/2 + 28/6])//28/2 is stepper height
        color("green")
    translate([chassis_l/2 - (mount_plate_diameter/2)-rear_wheel_buffer ,-1,-14.85])
    
    //now scoot it to the side

        rotate([0,0,90])
        union(){
            
            //mount hole
            translate([0, -17.5, 15])    
            rotate([0,90,0])
            cylinder(h=w, d = 4.5, center=true, $fn=0);
            //mount hole
            translate([0, 17.5, 15])    
            rotate([0,90,0])
            cylinder(h=w, d = 4.5, center=true, $fn=0);    
            //shaft hole
            translate([0, 0, 7])    
            rotate([0,90,0])
            cylinder(h=w, d = 9.5, center=true, $fn=0);    
                       
            

        }  
    
    
}


module battery_case(){
    //"89mm (+1.5mm for switch knob) x 42mm x 21.7mm"
    color("black")
    translate([0,0,wall_width])
    rotate([0,90,90])
    cube([battery_h,battery_l,battery_w], center = true);
}