use <use/openscad/hollowCylinder.scad>
$fn=30;
tensioner();

module tensioner(){
    translate([0,0,18])
    rotate([90,90,0])
    hollowCylinder(d=22, wallWidth=2, h=12);
    
    rotate([90,90,90]){
        difference(){
            cylinder(d=8, h=3, center=true);
            cylinder(d=2.4, h = 4, center=true);
        }
    }
}