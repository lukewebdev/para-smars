# para-smars
Parametric library for generating SMARS robots. 

All credit for the original SMARS concept etc goes to creator of SMARS and the original robot - https://www.thingiverse.com/thing:2662828

This is a parametric effort, primarily aimed at the stepper version of SMARS, 
but the idea is to make a single code repository capable of generating all desirable variants of SMARS.

Benefits:

1. easy to adjust for quirks in individual 3d Printers
2. easy to adjust size to fit other battery options
3. Anyone can tweak without having to use proprietary software


Hopefully the biggest benefit to the community will be that people FORK this code and submit Pull Requests to improve it. 

SMARS right now consists of the original designs and many one-off tweaks. Because the project is not in code, it is not really
building on itself or improving overall.

Ideally, we could improve this so that one may simply choose their battery selection, and width/height etc and the robot model will generate itself.

To try out defaults, simply open
configuration_parameters.scad and change $fn=15 or something low to render it faster while developing.
Set iteme like batteries and preview to false:
show_batteries = true;
show_rear_system = true;
show_cable_management = true;
show_grooves = true;
show_chassis = true;
show_preview = false;
use_608_bearing = false; // should always be false...bearing variant is not working yet.

Then save and open
SMARS_LCV.scad in openscad and hit F5.  



Currently there is some clutter we need to clean up and some unused files.

A few videos of these robots in action:
https://www.youtube.com/watch?v=e3OiXQOx9ag

https://www.youtube.com/watch?v=ZqQueUTJkCA

https://www.youtube.com/watch?v=jl2UJ-XNMSg

Thingiverse page for this variant:
https://www.thingiverse.com/thing:3202688
