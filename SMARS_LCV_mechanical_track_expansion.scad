$fn=30;

    //scale([1,1.02,1]);
    //track_lcv();
    pins();
module track_lcv(){
    render()
    difference(){
        translate([0,0,-2])
        import("import/mechanical_track-orig-import-dont-print-use-modified.stl");


        color("yellow")
        rotate([0,90,0])
        translate([0,6.7,0])
        cylinder(h=6, d=2.4, center=true);
        

        color("yellow")
        rotate([0,90,0])
        translate([0,-6.25,0])
        cylinder(h=20, d=2.4, center=true);    
    }

}


