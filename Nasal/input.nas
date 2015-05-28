#function to simulate airspeed effects on control surfaces with direct links (no hidraulics)
#it reduces effective input by a factor proportional to the square of the speed
#also simulating dinamic compensators (for elevator input)

setlistener("/sim/signals/fdm-initialized", func {
	print("Control filter  ---INITIALIZED");
	control_loop();
});

var control_loop = func {
	var  airspeed = getprop("/velocities/airspeed-kt");
	var  el_input = getprop("/controls/flight/elevator");
	var ail_input = getprop("/controls/flight/aileron");
	var rud_input = getprop("/controls/flight/rudder");

	if (airspeed > 90){
		if (airspeed <= 375){
			var comp_factor = 0.65 * math.pow(( airspeed - 90 ), 2) /81225;
			setprop("/controls/flight/elevator-input", el_input * (1 - comp_factor));
			setprop("/controls/flight/rudder-input", rud_input * (1 - comp_factor * 0.66));
			setprop("/controls/flight/aileron-input", ail_input * (1 - comp_factor * 0.8));
		}else {
			setprop("/controls/flight/elevator-input", el_input * 0.35);
			setprop("/controls/flight/rudder-input", rud_input * 0.57);
			setprop("/controls/flight/aileron-input", ail_input * 0.48);
		};
	}else {
		setprop("/controls/flight/elevator-input", el_input);
		setprop("/controls/flight/rudder-input", rud_input);
		setprop("/controls/flight/aileron-input", ail_input);
	    };

	settimer(control_loop, 0);
};
