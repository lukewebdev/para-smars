//use </Users/luke/Documents/2d/use/publicDomainGearV1.1.scad>
//1/2 EVA FOAM WHEEL PROTOTYPE

//Features:
//MAgnetic Ferrite Rotary Encoder
//Lug Bolts
//
use </Users/luke/Documents/2D-3D-FlowmBot/use/shapes.scad>
use </Users/luke/Documents/2D-3D-FlowmBot/use/scad-utils/morphology.scad>
$fn = 40;

//WHEEL
axle_d=16;
wheel_d = 200;
facets = 8;
rounding = 10;

//ROTARY ENCODER
encoder_count = 20;
encoder_h = 18;
encoder_w = 5;
encoder_spacing = 75;
//HUB CONFIG
lug_count = 5;
lug_spacing = 25;
lug_d = 5;
//TEETH
teeth_d = ((wheel_d*3.14) / facets) * .5;
wheel();
module teeth(){
    for (i = [1 : 12]){
        rotate([0,0,(360/facets)*i])
        translate([wheel_d/2,0,0])      
        outset(d=rounding)
        square(size=[teeth_d*1.5, teeth_d], center=true);
    }   
}

module lug_bolt_holes(){
    for (i = [1 : lug_count]){
        rotate([0,0,(360/lug_count)*i])
        translate([lug_spacing,0,0])      
        circle(d=lug_d, center=true);        
     }
}

module magnetic_encoder_slots(){
    for (i = [1 : encoder_count]){
        rotate([0,0,(360/encoder_count)*i])
        translate([encoder_spacing,0,0])      
        square(size=[encoder_h, encoder_w], center=true);    
     }    
}

module wheel(){
    
    //main wheel
    difference(){
        union(){
            rotate([0,0,45])
            circle(d=wheel_d,  center=true);
            teeth();     
        }
        //axle
        circle(d=axle_d,center=true);      
        
        //lug bolts
        lug_bolt_holes();
        
        //magnetic encoder slots
        magnetic_encoder_slots();
    }

}