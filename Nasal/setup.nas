setlistener("/sim/signals/fdm-initialized", func {
	print("Aerodinamic setup  ---CHECK");
	setup();
});

var setup = func {
	setprop("/controls/flight/aileron-trim", -0.20);
	setprop("/controls/flight/rudder-trim", 0.015);
	setprop("/controls/engines/engine[0]/cowl-flaps-norm", 0);
}