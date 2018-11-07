//usage
chassis_render();
//StepMotor28BYJ();    
//print test axles
//bearing_608_axle_test();
use <use/openscad/hollowCylinder.scad>
use <use/openscad/torus.scad>
use <use/openscad/roundedCube.scad>
use <use/openscad/pinConnector.scad>
use <use/openscad/shapes.scad>
use <use/StepMotor_28BYJ-48.scad>
use <use/smars_18650_single_holder.scad>


//include configuration
include <configuration_parameters.scad>


if(use_608_bearing == true){
    //generate non-standard bearing wheels and bearing retainers
    //wheels_render();
}
module chassis_render(){

        union(){

                difference(){
                   render()
                   chassis();
                   diffs();
                }
               chassis_interior();
                chassis_exterior();
                }
        
        //preview only
        if(show_preview){
            preview_parts();
        }
        
}

module wheels_render(){
    wheel_render();
    mirror([0,1,0])
    wheel_render();
}


module wheel_render(){
    render()
    translate([-chassis_l/2 + wheel_d/4,chassis_w/2 + wheel_w/2 + rim_w + 1, + wheel_d/4])
    wheel(axle_d = 16, wheel_w=21, wheel_d = 31, pyramid_h = 2, rim_w=1);
}

module preview_parts(){
    //orig();
    color("yellow")
    stepper_motors();
    color("green")
    stepper_drivers(); 
    color("blue")
    arduinos(); 
    
  //  preview_bearings();
    

}

module arduino(){
    render()
    translate([-10,-35,70.5])
    rotate([0,0,270])
    import("import/Arduino.stl");
}


module arduinos(){
    arduino();
    translate([0,0,15])
    arduino();

}

module stepper_motor(){

    translate([stepper_x_nudge,0,stepper_z_nudge]) // nudge
    render()
    translate([chassis_l/2 - 8.5,chassis_w/2 - 12.3,16])    
    rotate([90,90,0])
    StepMotor28BYJ();    
}
module stepper_motors(){
    stepper_motor();
    mirror([0,1,0])
    stepper_motor();
}

module chassis(){
    //holesbox
    if(use_608_bearing == true){
        bearing_608_axles();
    }else{
        SL_axles();        
    }
    //SL_axles();        
    color("gray")
    translate([0,0,chassis_h/2])
if(show_chassis==true){
    roundedcube(size = [chassis_l, chassis_w, chassis_h], radius = 6, apply_to = "all", center=true);
}
    rear_system();
    
    //only to see, otherwise comment out
    //nod[ 0.00, 0.00, 0.00 ]diffs();
}
module chassis_interior(){
    stepper_driver_holders_set();
}


module chassis_exterior(){
    rotate([0,0,90])
    batteries();

}

module batteries(){
    if(show_batteries){
        render()
        union(){
            translate([chassis_w/2+wall_width+battery_y_offset,0,battery_z])
            color("yellow")
            rotate([0,battery_tilt,0])
            battery_holder_single();

            mirror([1,0,0])
            translate([chassis_w/2+wall_width+battery_y_offset,0,battery_z])
            rotate([0,battery_tilt,0])
            battery_holder_single();
        }
    }
}

module diffs(){
    //chassis cavity - this version has equal wall width on all sides.
    //This results in front wall being too thick to accept SMARS module
    //translate([0,0,chassis_h/2])
    //cube([chassis_l-wall_width*2, chassis_w-wall_width*2, chassis_h-wall_width*2], center=true);
    
    translate([0,0,chassis_h/2])
    cube([chassis_l-2.2*2, chassis_w-wall_width*2, chassis_h-wall_width*2], center=true);//2.2 is to ensure thinner front wall width to acecpt SMARS modules

    
    
    //big center cable hole
    if(show_cable_management){
        //translate([0,0,chassis_h/1.4])
        translate([0,0,chassis_h/2 + 10.5])
        rotate([90,90,0])
        cylinder(h = chassis_w, d = side_hex_d, $fn = 6, center = true);
    }    
    //front and back hole
    /*
    translate([0,0,chassis_h/2.1])
    rotate([90,90,90])
    cylinder(h = chassis_l, d = front_back_hex_d, $fn = 6, center = true);
        */

    //front top tool attachment
    rotate([0,0,90])  
    translate([0, -chassis_l/2+wall_width - module_difference_y/2,chassis_h/2 + 15 + wall_width*1.1])
    module_difference();
    
    mirror([1,0,0]){
        //front top tool attachment
        rotate([0,0,90])  
        translate([0, -chassis_l/2+wall_width - module_difference_y/2,chassis_h/2 + 15 + wall_width*1.1])
        module_difference();

    }
    
    //cut off top
    translate([0,0,chassis_h-radius/2])
    cube([chassis_l, chassis_w, radius], center=true);


    //tool tattachment front
    translate([-chassis_l/2 + wall_width/2,0,14/2 + 22])
    rotate([0,0,90])  
    mirror([0,1,0])
    module_difference();
    
    //top front cutout
    translate([-chassis_l/2 + wall_width/2,0,14/2 + 56])
        cube([wall_width, chassis_w-wall_width*2, 56], center = true);

    //tool tattachment rear cutout
    //translate([+chassis_l/2 - wall_width/2+stepper_motor_max_d/2,0,14/2 + 8])
    //cube([wall_width*5, 50.5, 16], center = true);

    //rear_triangle_cutout();
    translate([stepper_x_nudge,0,stepper_z_nudge]) // nudge    
    render()
    stepper_holes();
    render()
    stepper_motors();
    


    //arduino groove
    if(show_grooves){
        translate([0,0,chassis_h-radius-arduino_pcb_thickness-15])
        color("yellow")
        cube([arduino_length,arduino_width,arduino_pcb_thickness],center=true); 
    }
    //arduino top slant printable groove
    arduino_printable_top_slants();
    arduino_groove_stoppers();


    if(show_grooves){
        //top stackable module groove
        color("yellow")
        translate([-.5,0,chassis_h-radius-arduino_pcb_thickness])
        cube([chassis_l-wall_width*2+1,arduino_width,arduino_pcb_thickness],center=true);    //length minus due to back wall
    }
    stackable_printable_top_slants();
    stackable_groove_stoppers();    

    
    //cut off everything below z=0
    translate([0,0,-5])
    cube([chassis_l + stepper_motor_max_d, chassis_w + axle_h*2, 10], center=true);
}


    //arduino_printable_top_slants();

module arduino_printable_top_slant(){
    //arduino groove printable top slant
    render()
    translate([0,-chassis_w/2+wall_width+arduino_pcb_thickness/2-.3,chassis_h-radius-arduino_pcb_thickness-13.89])
    rotate([90,45,90])
    cylinder(d = arduino_pcb_thickness+.5, h = arduino_length, center=true, $fn=3);
}

module arduino_printable_top_slants(){
    if(show_grooves){
        arduino_printable_top_slant();
        mirror([0,1,0])
        arduino_printable_top_slant();
    }
}

module stackable_printable_top_slant(){
    render()
    //arduino groove printable top slant
    translate([-.5,-chassis_w/2+wall_width+arduino_pcb_thickness/2-.3,chassis_h-radius-arduino_pcb_thickness+1.1])
    rotate([90,45,90])
    color("red")
    cylinder(d = arduino_pcb_thickness+.5, h = chassis_l-wall_width*2+1, center=true, $fn=3);//length minus to avoid back wall
}
//stackable_printable_top_slants();
module stackable_printable_top_slants(){
    if(show_grooves){
        stackable_printable_top_slant();
        mirror([0,1,0])
        stackable_printable_top_slant();
       /* mirror([1,1,0])//rear top slant
        scale([.78,1,1])    
        translate([0,-7,0])
        stackable_printable_top_slant(); */   
    }
}

module stackable_groove_stopper(){
    //arduino groove stoppers
    render()
    translate([-chassis_l/2+wall_width/2,chassis_w/2-wall_width-.25,chassis_h-radius-arduino_pcb_thickness-.1])
    rotate([0,90,0])
    cylinder(d=arduino_pcb_thickness*1, h=3,center=true);
}


module stackable_groove_stoppers(){
    if(show_grooves){
        stackable_groove_stopper();
        mirror([0,1,0])
        stackable_groove_stopper();
    }
}


module arduino_groove_stopper(){
    //arduino groove stoppers
    render()
    translate([-chassis_l/2+wall_width/2,chassis_w/2-wall_width-.25,chassis_h-radius-arduino_pcb_thickness-14.9])
    rotate([0,90,0])
    cylinder(d=arduino_pcb_thickness*1, h=3,center=true);
}


module arduino_groove_stoppers(){
    if(show_grooves){
        arduino_groove_stopper();
        mirror([0,1,0])
        arduino_groove_stopper();
    }
}

//module_difference();
module module_difference(){//what to subtract (if in a wall and don't need sides)
    //mount hole
    translate([0,1.8 + stepper_hole_mount_d,module_difference_z/2 - stepper_hole_mount_d-2])
    rotate([0,90,0])
    color("red")
    cylinder(h=chassis_w+1, d = 4.5, center=true);
   
    
    cube([module_difference_x, module_difference_y, module_difference_z+2], center = true);
}


module top_stepper_housing_cutout_block(){
    cube([stepper_motor_max_d,stepper_motor_max_d,chassis_w ], center=true);                
}
                
module rear_system(){
    if(show_rear_system){
        //render()
        difference(){
            translate([chassis_l/2,0,stepper_motor_max_d/2])
            rotate([90,0,0])
            difference(){
                rotate([0,0,0])
                //main cube
                roundedcube(size = [stepper_motor_max_d, stepper_motor_max_d, chassis_w], radius = 6, apply_to = "all", center=true);
                
                //main hollow
                cube([stepper_motor_max_d-2.2*2, stepper_motor_max_d-wall_width*2, chassis_w-wall_width*2], center=true);
                
                //cylinder(h=chassis_w-wall_width*2, d=stepper_motor_max_d-wall_width*2, center = true);    
                translate([0,stepper_motor_max_d/2+5,0])
                top_stepper_housing_cutout_block();
                

                translate([16,-stepper_motor_max_d/2-chassis_l/2+1.2+48,0])
                rotate([0,90,90])
                color("red")
                module_difference();  

            }

        }        
    }
}



module orig(){
    color("green")
    rotate([0,0,90])
    import("import/chassis_-SL.stl");
}

module stepper_driver(){
    color("green")
    //translate([-chassis_l/2 + stepper_driver_w/2 + wall_width*2 + stepper_driver_front_offset,chassis_w/2-wall_width*2-groove_d/2,stepper_driver_h/2+wall_width])
    translate([0,0,stepper_driver_h/2 + wall_width])
    rotate([0,0,90])
    cube([stepper_driver_w,  stepper_driver_t,stepper_driver_h],center=true);
}

module stepper_drivers(){
    stepper_driver();
    mirror([0,1,0])
    translate([-24,0,0])
    stepper_driver();
}


module stepper_driver_holder(){

    post_w = 4;
    post_l = 6;
    post_h  = stepper_driver_h/2 + wall_width;
    post_z = post_h/2 + wall_width;

    //stepper driver spacing
    //render()    
    translate([-stepper_driver_w/2 - post_w/2 + groove_d/2,0,0]){
        difference(){
            translate([0,0,post_z])
            cube([post_w,post_l,post_h], center = true);
            //groove
            translate([post_w/2,-groove_d,post_z])
            cube([groove_d*1.25,groove_d,stepper_driver_h/2 + wall_width], center = true);    
        }
        //vertical brace to chassis
        color("red")
        translate([-(chassis_w/2-stepper_driver_w/2)/2+wall_width/2,0,post_h-post_w/2])
        cube([chassis_w/2-stepper_driver_w/2-groove_d, post_w/2, post_w/2], center=true);
    }

}

module stepper_driver_holders(){
    translate([0,0,0])
    union(){
        stepper_driver_holder();
        mirror([1,0,0])  
        translate([0,0,0])
        stepper_driver_holder();
    }    
}

module stepper_driver_holders_set(){
    rotate([0,0,90]){
        translate([0,-1.5,0])        
        mirror([0,1,0])
        stepper_driver_holders();
        translate([0,25,0])
        stepper_driver_holders();    
    }

}

module SL_axles_set(){
    difference(){
        translate([0,0,-1])
        union(){
            SL_axle(); 
            mirror([0,1,0])
            SL_axle(); 
        }
    }
}

module SL_axles(){
    SL_axles_set();
    mirror([1,0,0])
    SL_axles_set();
}

module SL_axle(){
        //put at bottom
        translate([-chassis_l/2+axle_d/2,chassis_w/2+3,axle_d/2])
        rotate([-90,0,0])
    difference(){
        union(){
            difference(){

                hollowCylinder(d=axle_d, h=axle_h, wallWidth=3, center=true);
                //inner chamfer
                torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true);
                
                translate([0,0,12])
                torus(d1=axle_d-5, d2=axle_d, fill=false, center=true);               
                //inner rim of outside axle
                //translate([0,0,3])
                //hollowCylinder(d=axle_d, h=2, wallWidth=.4, center=true);
                
                //slot for flex
                cube([3,axle_d,axle_h], center=true);
            }

            //add lip
            difference(){
               // color("red")
                union(){
                    translate([0,0,4.25])
                    hollowCylinder(d=axle_d, h=1.6, wallWidth=3, center=true);
                    translate([0,0,-3.25])
                    hollowCylinder(d=axle_d, h=1.6, wallWidth=3, center=true);                    
                }
                cube([3,axle_d,axle_h], center=true);
            }
        }
        
        //top of axle flat
        translate([0,-axle_d+1.5,0])
        cube([axle_d, axle_d, axle_d], center=true);
    }
}
            

module bearing_608_axles(){
    color("yellow")
    translate([-chassis_l/2+axle_d/2,chassis_w/2+3,axle_d/2])
    rotate([90,90,0])
    cylinder(h=7, d=22.4, center=true);
    
    
    
    bearing_608_axle(); 
    mirror([0,1,0])
    bearing_608_axle(); 
}
module bearing_608_axle(){
    //put at bottom
    //render()

    translate([-chassis_l/2+axle_d/2,chassis_w/2+3,axle_d/2])//keep centered on original axle location, we want to add a bearing but not change distance between front and rear wheel...
    rotate([-90,0,0])
    union(){
        difference(){
            union(){
                
                //outer hub
                translate([0,0,9.8])
                hollowCylinder(d=bearing_608_axle_d+.4, h=3, wallWidth=3, center=true);

                //inner axle
                color("red")
                translate([0,0,3.5 + bearing_chassis_offset/4])

                hollowCylinder(d=bearing_608_axle_d, h=7, wallWidth=2.8, center=true);//7mm bearing width. d accounts for wall width to arrive at difference leaving an 8mmm shaft
                
                //inner hub
                translate([0,0,2.1])
                hollowCylinder(d=bearing_608_axle_d+1, h=3, wallWidth=3, center=true);

            }
            //outer chamfer
            translate([0,0,12.5])
            torus(d1=bearing_608_axle_d-2, d2=bearing_608_axle_d+1, fill=false, center=true);
            
            
            //translate([0,0,12])
            //torus(d1=bearing_608_axle_d-5, d2=bearing_608_axle_d, fill=false, center=true);               
            //inner rim of outside axle
            //translate([0,0,3])
            //hollowCylinder(d=axle_d, h=2, wallWidth=.4, center=true);
            
            //slot for flex
            cube([2,bearing_608_axle_d+1,bearing_608_axle_h], center=true);
        }  
    }
}


module bearing_608_axle_test(){
    difference(){
        union(){
//            translate([-chassis_l/2+axle_d/2,chassis_w/2,axle_d/2])
  //          cube([bearing_608_axle_d+1,bearing_608_axle_d/2,bearing_608_axle_d+1], center=true);
            bearing_608_axle();
        }
        translate([-chassis_l/2+axle_d/2,chassis_w/2-6,axle_d/2])
        cube([bearing_608_axle_d+2,bearing_608_axle_d+2,bearing_608_axle_d+2], center=true);
    }
}

module preview_bearings(){
    hollowCylinder(d=bearing_608_axle_d, h=7, wallWidth=7, center=true);//608 bearing
}

//rear_triangle_cutout();
module rear_triangle_cutout(){

    tw_offset=10;
    render()
    translate([chassis_l/2 - wall_width,-chassis_w/2+wall_width,40])
    rotate([90,0,90])
    //trapezoid(width_base, width_top, height, thickness)
    trapezoid(chassis_w-wall_width*2, 0, front_back_hex_d/3, wall_width, center = true);
    
    //bottom
    translate([chassis_l/2-wall_width/2,0,35])
    cube([wall_width,chassis_w-wall_width*2,10],center=true);
}


module hub(){
    translate([0,0,-chassis_h/2 + axle_d/2+.55])
    translate([-chassis_l/2+radius,0,0])
    rotate([0,90,90])
    cylinder(h=chassis_w+1.5, d=axle_d, center = true);
}  

//stepper_holes();
module stepper_holes(){ 

        color("green")
        rotate([0,0,90])
        translate([0,-26.5,1])
        render()

        union(){
            
            //mount hole
            translate([0, -17.5, 15])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = stepper_hole_mount_d, center=true);
            //mount hole
            translate([0, 17.5, 15])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = stepper_hole_mount_d, center=true);    
            //shaft hole
            translate([0, 0, 7])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = 9.5, center=true);    
                        
           //scoop out for shape of stepper on bottom floor
           translate([0,.25,15.2])
           rotate([0,90,0])
           cylinder(h=chassis_w-wall_width*2, d= stepper_motor_main_d*1.02, center = true, $fn=45);     

            //clean up under top tool module attachment
            translate([0,-.25,19.8])
            rotate([0,90,0])
            cube([stepper_motor_max_d-5,stepper_motor_max_d+11,chassis_w-wall_width*2], center = true);                 
           
        }  
    
    
}


module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}