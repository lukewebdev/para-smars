$fn = 100;

//use <use/openscad/shapes.scad>
use <SMARS_LCV.scad>
use <use/openscad/hollowCylinder.scad>
use <use/openscad/torus.scad>
use <use/openscad/torus.scad>
//wheel_slave_original();

//SL_axle_diff();
/*rotate([180,90,90])
translate([0,0,6])   
rotate([0,180,0]) 
SL_axle_diff(axle_d = 16);*/
      //default smars wheel is like 31, too slack
      //wheel_w needs to be minus rims
  
 //SAVE THIS - THIS IS A WORkING LARGER SLAVE WHEEL  smooth
//wheel(axle_d = 15, wheel_w=20.6, wheel_d = 32, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =false);


//slave wheel geared, larger than master to take up slack in track
//wheel(axle_d = 15, wheel_w=20.6, wheel_d = 31, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =true, fn = 8);

//sample master
//wheel(axle_d = 15, wheel_w=20.6, wheel_d = 31, pyramid_h = 3.5, pyramid_d=8, pyramid_d2=3.5, rim_w=.2, rim_d = 35, do_pyramids =true, fn = 8, slave=false);

wheel_spinner_drill_attachment();
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
            //color("red") 
            SL_axle_diff(axle_d = 16, SL_axle_h = SL_axle_h);
            

 


            if(slave==true){
               /* for (i = [1 : 6]){
                    color("yellow")
                    rotate([60*i,90,0])
                    translate([wheel_w/2,0,wheel_w/2 -5])    
                    rotate([0,45,0])
                    translate([-3,0,4])
                    cube([7, (2*(wheel_d/2)*3.14)/18, 16], center=true);
                //              cylinder(d=pyramid_d*.8,h=pyramid_h*4,$fn=4);
                    
                } */
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
                //stepper shaft hole
//                cube([5,3,wheel_w*2 + rim_w*2],center=true);
                
              /*  //m3 captive slot
                translate([0,6,wheel_w/2-2.8])
                cube([5.5, 2.4, 6.05],center=true);
                
                //m3 hole
                translate([0,wheel_w/4+3,wheel_w/2 - 2.8])
                rotate([90,0,0])
                cylinder(d=3.2, h=wheel_w/2 + 3, center=true);
                
                //m3 countersink
                translate([0,wheel_w/2+4,wheel_w/2 - 2.8])
                rotate([90,0,0])
                cylinder(d=5.45, h=wheel_w/4 + 3, center=true);      
      */
      
               //wheel chamfer

               /* translate([0,0,-wheel_w/2 + rim_w*3])
                cylinder(d=wheel_d*1.5, d2=1, h=wheel_w*.3, center=true);*/
                

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
                //wheel chamfer
               // translate([0,0,-wheel_w/2 * rim_w*2 + 3])
                //cylinder(d=wheel_d*1.2, d2=1, h=wheel_w*.7, center=true);                
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
        hollowCylinder(d=axle_d, h=SL_axle_h, wallWidth=3, center=true);
        translate([0,0,7])
        torus(d1=axle_d-5, d2=axle_d, fill=false, center=true);               
    }

}

module SL_axle_orig(axle_d = 16){//keep in sync with main chassis axle code!
    axle_h=15;
          //translate([-chassis_l/2+axle_d/2,chassis_w/2+3,axle_d/2])
        union(){
            difference(){

                hollowCylinder(d=axle_d, h=axle_h, wallWidth=3, center=true);
                //inner chamfer
                torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true);
                //outer chamfer
                //translate([0,0,9.5])
                //torus(d1=axle_d-2, d2=axle_d+1, fill=false, center=true);
                
                translate([0,0,12])
                torus(d1=axle_d-5, d2=axle_d, fill=false, center=true);               
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
            }
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