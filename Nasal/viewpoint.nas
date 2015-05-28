setlistener("/sim/signals/fdm-initialized", func {
	setprop("/gear/gear/rollspeed-ms", 0);
	setprop("/gear/gear[1]/rollspeed-ms", 0);
	setprop("/gear/gear[2]/rollspeed-ms", 0);
	setprop("/controls/seat/setting", 0);
	setprop("/controls/seat/setting_prev", 0);
	print("viewpoint effects  ---INITIALIZED");
	viewpoint_loop();
});

var on_ground = func {
	var gear0wow = getprop("/gear/gear[0]/wow");
	var gear1wow = getprop("/gear/gear[1]/wow");
	var gear2wow = getprop("/gear/gear[2]/wow");

	if (gear0wow){
		return 1;
	} elsif (gear1wow){
		return 1;
	} elsif (gear2wow){
		return 1;
	} else {
		return 0;
	}
}

var wheel_roll = func {
	var gear0roll = abs(getprop("/gear/gear/rollspeed-ms"));
	var gear1roll = abs(getprop("/gear/gear[1]/rollspeed-ms"));
	var gear2roll = abs(getprop("/gear/gear[2]/rollspeed-ms"));

	if (gear0roll > 1){
		if (gear0roll < gear1roll){
			if (gear1roll < gear2roll){
			} else {
				return gear1roll;
			}
		} else {
			if (gear0roll < gear2roll){
				return gear2roll;
			}
			return gear0roll;
		}
	} else {
		return 0;
	}
}

setlistener("/controls/seat/setting", func(n) {
    var seat_set = n.getValue();
    var view_num = getprop("/sim/current-view/view-number");
    if (view_num < 1){
	if (seat_set == 0){
		setprop("/sim/current-view/y-offset-m", 0.78);
		setprop("/sim/current-view/z-offset-m", 4.80);
	} elsif (seat_set == 1) {
		setprop("/sim/current-view/y-offset-m", 0.82);
		setprop("/sim/current-view/z-offset-m", 4.79);
	} elsif (seat_set == 2) {
		setprop("/sim/current-view/y-offset-m", 0.86);
		setprop("/sim/current-view/z-offset-m", 4.78);
	} elsif (seat_set == 3) {
		setprop("/sim/current-view/y-offset-m", 0.92);
		setprop("/sim/current-view/z-offset-m", 4.77);
	} elsif (seat_set == 4) {
		setprop("/sim/current-view/y-offset-m", 0.96);
		setprop("/sim/current-view/z-offset-m", 4.76);
	}
    }
}, 0);

var viewpoint_loop = func {
	var aoa = getprop("/orientation/alpha-deg");
	var x = getprop("/sim/time/elapsed-sec");
	var view_num = getprop("/sim/current-view/view-number");
	var view_ang = getprop("/sim/current-view/pitch-offset-deg");
	var view_pos = getprop("/sim/current-view/y-offset-m");
	var airspeed = getprop("/velocities/airspeed-kt");
	var wheel_speed = wheel_roll();

	if (view_num < 1){

		if (on_ground()){
			if (wheel_speed > 2){
			    var delta_view = 0.4 * math.sin(7.5 * wheel_speed * x);
			    interpolate("/sim/current-view/pitch-offset-deg", view_ang + delta_view , 0.045);
			    interpolate("/sim/current-view/y-offset-m", view_pos + 0.00055 * delta_view , 0.075);
			}
		} elsif (aoa > 9.5) {
			delta_view = 0.5 * math.sin(1.6 * aoa * x);
			interpolate("/sim/current-view/pitch-offset-deg", view_ang + delta_view , 0.045);
			interpolate("/sim/current-view/y-offset-m", view_pos + 0.00045 * delta_view , 0.075);
		} elsif (airspeed > 365) {
		    delta_view = 0.5 * math.sin(0.2 * airspeed * x);
		    interpolate("/sim/current-view/pitch-offset-deg", view_ang + delta_view , 0.045);
		    interpolate("/sim/current-view/y-offset-m", view_pos + 0.00035 * delta_view , 0.075);
		}

	}
	settimer(viewpoint_loop, 0.125);
};