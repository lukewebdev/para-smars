$fn=30;

    scale([1,1.02,1])
    track_lcv();
//pins();
module track_lcv(){
    render()
    difference(){
        translate([0,0,-2])
        import("import/mechanical_track.stl");


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



module pins(){

    for (i = [0 : 6]){
        translate([0,i*3,(1.5+(.1*i))/2])
        rotate([0,90,0])

        render()
        cylinder(h=17, d=1.5+(.1*i), center=true);
    }


  


}