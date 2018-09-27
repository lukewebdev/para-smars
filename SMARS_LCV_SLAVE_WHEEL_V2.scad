//use <use/openscad/shapes.scad>

//wheel_slave_original();


wheel(axle_d = 16, wheel_w=21, wheel_d = 31, pyramid_h = 2, rim_w=1, rim_d = 35, rim_fn = 8);
module wheel(axle_d = 16, wheel_w=21, wheel_d = 31, pyramid_h = 2, rim_w=1, rim_d = 31, rim_fn = 20){
    
    //main wheel
    rotate([180,90,90])
    union(){
        difference(){
            union(){
                rotate([0,0,022.5])
                cylinder(d=wheel_d, h=wheel_w, center=true, $fn = 8);
                //rims
                translate([0,0,wheel_w/2 + rim_w/2])
                cylinder(d=rim_d, h = rim_w, center=true, $fn=rim_fn);
                translate([0,0,-wheel_w/2 +- rim_w/2])
                cylinder(d=rim_d, h = rim_w, center=true, $fn= rim_fn);              
            }
            cylinder(d=axle_d,h=wheel_w + rim_w*2,center=true);
            //bearing_608_difference(wheel_w=wheel_w, rim_w=rim_w);
        }
      
        //tread
        pyramids(pyramid_h=pyramid_h, wheel_w = wheel_w);
    }
}

module bearing_retainer(){

}
module bearing_608_difference(wheel_w=21, rim_w=1){
    color("red")
    translate([0,0,wheel_w/2+rim_w - 17/4])
        cylinder(d=22, h=17, center=true);//7mm + 1 for extra depth into wheel, must correspond to axle configuration
}

module pyramids(pyramid_h=2){
    for (i = [1 : 8]){
        color("red")
        rotate([45*i,90,0])
        translate([0,0,wheel_w/2 + pyramid_h*1.75])    
        cylinder(d=7,d2=3.5,h=pyramid_h,$fn=4);
    }   
}
module wheel_slave_original(){
    translate([35,-10,2])
    rotate([0,0,0])
    color("green")
    import("import/slave_wheel_SL.stl");
}