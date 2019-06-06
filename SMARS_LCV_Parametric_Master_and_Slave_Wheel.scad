/* openscad code by Luke Meier, contributed to SMARS project which was created by Kevin Thomas*/


$fn = 100;


 //THIS IS A WORkING LARGER SLAVE WHEEL  smooth
//wheel(axle_d = 15, wheel_w=20.6, wheel_d = 32, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =false);


//slave wheel geared, larger than master to take up slack in track.
wheel(axle_d = 15, wheel_w=20.6, wheel_d = 31, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =true, fn = 8);

//sample master  - for stepper variant
//wheel(axle_d = 15, wheel_w=20.6, wheel_d = 31, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =true, fn = 8, slave=false);

//tool for breaking in wheel (use vaseline on axle and pin the wheel after track is installed until plastic anneals and smooths our print imperfections)
//wheel_spinner_drill_attachment();
module wheel(axle_d = 15, wheel_w=20.6, wheel_d = 32, pyramid_h = 2, rim_w=.2, rim_d = 35, fn = $fn, do_pyramids = false, slave=true, SL_axle_h=6){
    
    //main wheel
    rotate([180,0,90])
    union(){
        difference(){

            union(){
                rotate([0,0,022.5])
                cylinder(d=wheel_d, h=wheel_w, center=true, $fn = fn);//make $fn = 8 for original
                //rims
                color("purple")
                hull(){
                    translate([0,0,wheel_w/2 + rim_w/2])
                    cylinder(d=rim_d, h = rim_w, center=true);
                    
                    color("red")
                    translate([0,0,wheel_w/2 + rim_w/2 - 1.25])
                    cylinder(d=wheel_d-2.4, h = rim_w, center=true);
                }
                color("purple")                
                hull(){
                    translate([0,0,-wheel_w/2 +- rim_w/2])
                    cylinder(d=rim_d, h = rim_w, center=true);              
                    
                    color("red")
                    translate([0,0,-wheel_w/2 + -rim_w/2 + 1.25])
                    cylinder(d=wheel_d-2.4, h = rim_w, center=true);                    
                }
            }
            if(slave==true){
                cylinder(d=axle_d,h=wheel_w*2 + rim_w*2,center=true);
            }else{

                translate([0,0,wheel_w/4 + rim_w +1])
                cylinder(d=axle_d,h=wheel_w/2 +7 + rim_w*2,center=true);
            }

            //ball difference for ball tip of axle
            translate([0,0,2.5])   
            rotate([0,180,0]) 

            SL_axle_diff(axle_d = 16, SL_axle_h = SL_axle_h);
            

 


            if(slave==true){

                 for (i = [1 : 6]){
                    color("yellow")
                    rotate([60*i,90,0])
                    translate([wheel_w/2,0,wheel_w/2 -5])    
                   // rotate([0,45,0])
                    translate([0,0,4])
                    cube([5, (2*(wheel_d/2)*3.14)/30, 12], center=true);
                }
                
               //wheel chamfer
                translate([0,0,-wheel_w/2])
                cylinder(d=wheel_d*1.25, d2=5, h=wheel_w*1.4, center=true);                

                translate([0,0,-wheel_w/2 * rim_w*2 + 15.5])
                mirror([0,0,1])        
                cylinder(d=wheel_d*1.2, d2=1, h=wheel_w*.7, center=true);                   
                            
            }else{
               for (i = [1 : 6]){
                    color("yellow")
                    rotate([60*i,90,0])
                    translate([wheel_w/2,0,wheel_w/2 -5])    
                   // rotate([0,45,0])
                    translate([0,0,4])
                    cube([5, (2*(wheel_d/2)*3.14)/30, 12], center=true);
                }
             
                

                translate([0,0,-wheel_w/2 * rim_w*2 + 15.5])
                mirror([0,0,1])        
                cylinder(d=wheel_d*1.2, d2=1, h=wheel_w*.7, center=true);                   
                
            }

            
            
                   

        }
      
        //tread
        if(do_pyramids == true){
            for (i = [1 : 8]){
                color("red")
                rotate([45*i,90,0])
                translate([0,0,wheel_d/2-1.5])    
                cylinder(d=pyramid_d,d2=pyramid_d2,h=pyramid_h,$fn=4);
            } 
        }
        
        
        if(slave != true){
            difference(){
                //shaft that goes into wheel axle
                translate([0,0,0])
                cylinder(d=8, h=wheel_w+ rim_w*2, center=true);
                
                //take off outter part of inner cylinder to clear outter chamfer
                translate([0,0,-(wheel_w + rim_w*2)/2 +3])
                cylinder(d=18, h=6, center=true);                
                
                //stepper shaft slot
                color("red")
                translate([0,0, +20.6/2 +.2])
                cube([5.5,3.5,29],center=true); 
                
            }
        }
        //wheel chamfer to account for first layer print being wider

        

    }
}
//rotate([180,0,90])

module bearing_retainer(){

}
module bearing_608_difference(wheel_w=21, rim_w=1){
    color("red")
    translate([0,0,wheel_w/2+rim_w - 17/4])
        cylinder(d=22, h=17, center=true);//7mm + 1 for extra depth into wheel, must correspond to axle configuration
}

module pyramids(pyramid_h=2, wheel_w = wheel_w, wheel_d = wheel_d,pyramid_d = pyramid_d, pyramid_d2 = pyramid_d2){
  
}
module wheel_slave_original(){
    rotate([90,90,0])
    translate([35,-26.75,-8.2])

    color("green")
    import("import/slave_wheel_SL.stl");
}


module SL_axle_diff(axle_d = 15){//keep in sync with main chassis axle code!
    axle_h=15;

   // scale(v = [1.0625,1.0625,1])
    difference(){
        color("pink") 
        hollowCylinder(d=axle_d+1, h=SL_axle_h, ww=3, center=true);
        translate([0,0,7])
        color("red")
        torus(d1=axle_d-5, d2=axle_d, fill=false, center=true);               
    }

}



module wheel_spinner_drill_attachment(axle_d = 15, wheel_w=20.6, wheel_d = 32, pyramid_h = 2, rim_w=.2, rim_d = 35, fn = $fn, do_pyramids = false, slave=true, SL_axle_h=6){
    translate([0,0,0])   
    rotate([0,180,0]) 

    union(){
        for (i = [1 : 6]){
            color("yellow")
            rotate([60*i,90,0])
            translate([0,0,wheel_w/2 -5])    
            // rotate([0,45,0])
            translate([0,0,4])
            cube([11, (2*(wheel_d/2)*2.75)/30, 8], center=true);
        }
        translate([0,0,3])
        cylinder(h=5, d=27,center=true);

        translate([0,0,12.5])
        cylinder(h=20, d=10, center=true);
        
        translate([0,0,8])
        cylinder(h=5, d1=27, d2=10, center=true);        
    }

}

module hollowCylinder(d=5, h=10, ww=1, $fn=140)
{
	difference()
	{
		cylinder(d=d, h=h, center=true);
		translate([0, 0, -0.1]) { cylinder(d=d-(ww*2), h=h+0.2, center=true); }
	}
}


module torus(d1=10, d2=2, $fn=140)
{
	rotate_extrude()
	{
		translate([(d1/2)+(d2/2), 0, 0])
		{
			circle(d=d2);
		}
	}

}
