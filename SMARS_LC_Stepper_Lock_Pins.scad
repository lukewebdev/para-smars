difference(){
    union(){
        difference(){
            basicpin();
                //remove center
             rotate([0,90,0])
             cylinder(h = 43, r1 = 4, r2 = 4, center = true, $fn=100);
                


        }
        //main shaft
        rotate([0,90,0])
        cylinder(h = 50, r1 = 1.1, r2 = 1.1, center = true, $fn=100);

    }
    //flat bottom
    translate([0,0,-5.5])
    rotate([0,90,0])
    cube([10,12,60],center=true);    
}



//stoppers
module stop(){
    cylinder(h = 4, r1 = 3.8, r2 = 3.8, center = true, $fn=100);
}

module basicpin(){
 rotate([0,90,0])
    difference(){
        union(){
            
            //main key shaft
            cylinder(h = 57.5, r1 = 1.9, r2 = 1.9, center = true, $fn=100);
            //cylinder(h = 52, r1 = 2.3, r2 = 2.3, center = true, $fn=100);

            //stoppers
            translate([0,0,23.25])
            stop();
            //this was 23
            translate([0,0,-23.25])
            stop();
        }

        

    }   
}