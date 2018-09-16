//DEVEL ONLY - COMMENT OUT FOR EXPORT
$fa=1;
$fs=1.5;
$fn=15;
fn=$fn;
//END DEVEL ONLY

use <use/openscad/hollowCylinder.scad>
use <use/openscad/torus.scad>
use <use/openscad/roundedCube.scad>
use <use/openscad/pinConnector.scad>
use <use/openscad/shapes.scad>
use <use/StepMotor_28BYJ-48.scad>



//pcb config
    groove_d = 1.5;


//stepper driver config
stepper_driver_h = 32;
stepper_driver_w = 34.65;
stepper_driver_t = 1.5;
stepper_driver_front_offset = 2.2;//make room for tool modules
stepper_motor_max_d = 35;
stepper_motor_main_d = 28;
//WHEEL CONF
axle_d = 16;
axle_h = 16;
wheel_width = 21;
wheel_width_beyond_sl_axle = 12;
wheel_diameter = 31;

//arduino and module groove config
arduino_pcb_thickness = 1.7;
arduino_width = 53;
arduino_length = 66;

//CHASSIS CONF
rear_wheel_buffer = 11;
wall_width = 3.6;
radius = 5;//not more than ten or need to adjust stepper mount hub code
chassis_w =  58; // 40 is two stepper motors
chassis_h =58;
chassis_l = 70;
roof_offset = 40; // just how high to show roof separate from chassis
echo(chassis_l);
echo(chassis_w);
echo(chassis_h);
front_back_hex_d=35;

chassis_render();

module chassis_render(){
    difference(){
       chassis();
        diffs();
    }
    chassis_interior();
    
    
    //preview only
    //preview_parts();
}

module preview_parts(){
    //orig();
    stepper_motors();
    stepper_drivers();    
}


module stepper_motor(){
    translate([chassis_l/2 - 8.5,chassis_w/2 - 12.9,16])    
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
    SL_axles();        
    color("gray")
    translate([0,0,chassis_h/2])
    roundedcube(size = [chassis_l, chassis_w, chassis_h], radius = 6, apply_to = "all", center=true);
    rear_system();
    
    //only to see, otherwise comment out
    //nod[ 0.00, 0.00, 0.00 ]diffs();
}
module chassis_interior(){
    stepper_driver_holders_set();
    rear_module_hitch();
}



module diffs(){
    //chassis cavity
    translate([0,0,chassis_h/2])
    cube([chassis_l-wall_width*2, chassis_w-wall_width*2, chassis_h-wall_width*2], center=true);
    
    //big center cable hole
    translate([0,0,chassis_h/1.4])
    rotate([90,0,0])
    cylinder(h = chassis_w, d = 27, $fn = 6, center = true);
    
    //front and back hole
    translate([0,0,chassis_h/1.75])
    rotate([90,90,90])
    cylinder(h = chassis_l, d = front_back_hex_d, $fn = 6, center = true);
        
    //cut off top
    translate([0,0,chassis_h-radius/2])
    cube([chassis_l, chassis_w, radius], center=true);


    //tool tattachment front
    translate([-chassis_l/2 + wall_width/2,0,14/2 + 22])
        cube([wall_width, 42.5, 28], center = true);
        
    //top front cutout
    translate([-chassis_l/2 + wall_width/2,0,14/2 + 56])
        cube([wall_width, chassis_w-wall_width*2, 56], center = true);

        //tool tattachment rear cutout
    translate([+chassis_l/2 - wall_width/2+stepper_motor_max_d/2,0,14/2 + 8])
    cube([wall_width*5, 50.5, 16], center = true);

    rear_triangle_cutout();

    stepper_holes();
    
    stepper_motors();

    //arduino groove
    translate([0,0,chassis_h-radius-arduino_pcb_thickness-15])
    cube([arduino_length,arduino_width,arduino_pcb_thickness],center=true); 
    
    //arduino top slant printable groove
    arduino_printable_top_slants();
 
    arduino_groove_stoppers();


    
    //top stackable module groove
    translate([0,0,chassis_h-radius-arduino_pcb_thickness])
    cube([arduino_length,arduino_width,arduino_pcb_thickness],center=true);    
    
    stackable_groove_stoppers();    

}

    //arduino_printable_top_slants();

module arduino_printable_top_slant(){
    //arduino groove printable top slant
    translate([0,-chassis_w/2+wall_width+arduino_pcb_thickness/2-1,chassis_h-radius-arduino_pcb_thickness-14])
    rotate([90,45,90])
    cylinder(d = arduino_pcb_thickness, h = arduino_length, center=true, $fn=3);
}

module arduino_printable_top_slants(){
    arduino_printable_top_slant();
    mirror([0,1,0])
    arduino_printable_top_slant();
}

module stackable_groove_stopper(){
    //arduino groove stoppers
    translate([-chassis_l/2+wall_width/2,chassis_w/2-wall_width-.25,chassis_h-radius-arduino_pcb_thickness])
    rotate([0,90,0])
    cylinder(d=arduino_pcb_thickness, h=2,center=true);
}


module stackable_groove_stoppers(){
    stackable_groove_stopper();
    mirror([0,1,0])
    stackable_groove_stopper();
}


module arduino_groove_stopper(){
    //arduino groove stoppers
    translate([-chassis_l/2+wall_width/2,chassis_w/2-wall_width-.25,chassis_h-radius-arduino_pcb_thickness-15])
    rotate([0,90,0])
    cylinder(d=arduino_pcb_thickness, h=2,center=true);
}


module arduino_groove_stoppers(){
    arduino_groove_stopper();
    mirror([0,1,0])
    arduino_groove_stopper();
}

module rear_module_hitch(){
    difference(){
         
        translate([chassis_l/2+stepper_motor_max_d/2-wall_width/2-1,0,14])
        rotate([14,0,90])

        difference(){
            cube([chassis_w-7, 2, 14], center = true);
            cube([42.5, 4, 15], center = true);
        }
        translate([chassis_l/2,0,stepper_motor_max_d/2])
        rotate([90,0,0])        
        translate([0,stepper_motor_max_d/2+3,0])        
        top_stepper_housing_cutout_block();
    }   
}



module top_stepper_housing_cutout_block(){
    cube([stepper_motor_max_d,stepper_motor_max_d,chassis_w ], center=true);                
}

module rear_system(){
    translate([chassis_l/2,0,stepper_motor_max_d/2])
    rotate([90,0,0])
    difference(){
        rotate([0,0,18])
        cylinder(h=chassis_w, d=stepper_motor_max_d, center = true);
        cylinder(h=chassis_w-wall_width*2, d=stepper_motor_max_d-wall_width*2, center = true);    
        translate([0,stepper_motor_max_d/2+3,0])
        top_stepper_housing_cutout_block();
    }
}


module orig(){
    color("green")
    rotate([0,0,90])
    import("import/chassis_-SL.stl");
}

module stepper_driver(){
    color("green")
    translate([-chassis_l/2 + stepper_driver_w/2 + wall_width*2 + stepper_driver_front_offset,chassis_w/2-wall_width*2-groove_d/2,stepper_driver_h/2+wall_width])
    cube([stepper_driver_w,  stepper_driver_t,stepper_driver_h],center=true);
}

module stepper_drivers(){
    stepper_driver();
    mirror([0,1,0])
    stepper_driver();
}


module stepper_driver_holder(){
    post_w = 4;
    post_l = 6;
    post_h  = stepper_driver_h/2 + wall_width;
    post_z = post_h/2 + wall_width;

    //stepper driver spacing
    translate([-stepper_driver_w/2 - groove_d,0,0])
    difference(){
        translate([0,0,post_z])
        cube([post_w,post_l,post_h], center = true);
        //groove
        translate([post_w/2,-groove_d,post_z])
        cube([groove_d,groove_d,stepper_driver_h/2 + wall_width], center = true);    
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
        stepper_driver_holders();
     //   mirror([0,1,0])
        translate([0,25,0])
        stepper_driver_holders();    
    }

}
module SL_axles(){

        SL_axle(); 
        mirror([0,1,0])
        SL_axle(); 

}

module SL_axle(){
        //put at bottom


        translate([-chassis_l/2+axle_d/2,chassis_w/2+3,axle_d/2])
        rotate([-90,0,0])
        difference(){

            hollowCylinder(d=axle_d, h=axle_h, wallWidth=3, center=true);
            //inner chamfer
            torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true);
            //outer chamfer
            translate([0,0,9.5])
            torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true);
            
            //inner rim of outside axle
            translate([0,0,3])
            hollowCylinder(d=axle_d, h=2, wallWidth=.4, center=true);
            
            //slot for flex
            cube([3,axle_d,axle_h], center=true);
        }

}


//rear_triangle_cutout();
module rear_triangle_cutout(){
    tw_offset=10;
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
    //    render()

        union(){
            
            //mount hole
            translate([0, -17.5, 15])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = 4.5, center=true);
            //mount hole
            translate([0, 17.5, 15])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = 4.5, center=true);    
            //shaft hole
            translate([0, 0, 7])    
            rotate([0,90,0])
            cylinder(h=chassis_w+1, d = 9.5, center=true);    
                       
            
            //scoop out for shape of stepper on bottom floor
            translate([0,-1.5,17])
            rotate([0,90,0])
            cylinder(h=chassis_w-wall_width*2, d= stepper_motor_max_d, center = true);     
            
           
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