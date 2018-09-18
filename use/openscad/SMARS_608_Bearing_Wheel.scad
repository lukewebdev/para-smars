//use <use/openscad/shapes.scad>

$fn = 50;

//wheel_slave_original();
wheel_w = 21;
axle_d=16;
wheel_d = 31;
pyramid_h = 2;
rim_w = 1;

wheel();
module bearing(){
    color("yellow")
    cylinder(d=22, h=7);
}


module wheel(){
    
    //main wheel
    difference(){
        union(){
            rotate([0,0,022.5])
            cylinder(d=wheel_d, h=wheel_w, center=true, $fn = 8);
            //rims
            translate([0,0,wheel_w/2 + rim_w/2])
            cylinder(d=wheel_d, h = rim_w, center=true);
            translate([0,0,-wheel_w/2 +- rim_w/2])
            cylinder(d=wheel_d, h = rim_w, center=true);              
        }
        cylinder(d=axle_d,h=wheel_w + rim_w*2,center=true);
    }
  
    //tread
    pyramids();
}



module pyramids(){
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