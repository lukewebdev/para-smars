

$fn=100;
pins();
module pins(){
//some sizes to test
    /*
    for (i = [0 : 4]){
        translate([0,i*3,(1.5+(.1*i))/2])
        rotate([0,90,0])

        render()
        cylinder(h=17, d=1.5+(.1*i), center=true);
    }*/

    //qty of 16 pins size 1.9mm (tighten track to the max
      for (i = [1 : 10]){
        translate([0,i*3,(1.5+(.1*i))/2])
        rotate([0,90,0])

        render()
          //change d= to diameter of pin you want to make 
        cylinder(h=17, d=1.45, center=true);
    }


}