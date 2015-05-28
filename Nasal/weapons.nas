setlistener("/sim/signals/fdm-initialized", func {
	print("Weapons  ---LOADED");
	setup();
});

var setup = func {
	setprop("/controls/armament/mgLi/recoil", 0);
	setprop("/controls/armament/mgLo/recoil", 0);
	setprop("/controls/armament/gpL/recoil", 0);
	setprop("/controls/armament/mgRi/recoil", 0);
	setprop("/controls/armament/mgRo/recoil", 0);
	setprop("/controls/armament/gpR/recoil", 0);
	recoil();
	safety_check();
}

var safety_check = func{
	var mg_armed = getprop("/controls/armament/mg-armed") or 0;
	var gun_armed = getprop("/controls/armament/gun-armed") or 0;
	var shooting = getprop("/controls/armament/trigger") or 0;
	if (shooting){
		if (mg_armed){
		setprop("/controls/armament/mg-fire", 1);
		}else{
		    setprop("/controls/armament/mg-fire", 0);
		}
		if (gun_armed){
		    setprop("/controls/armament/gun-fire", 1);
		}else{
		    setprop("/controls/armament/gun-fire", 0);
		}
	} else {
		setprop("/controls/armament/mg-fire", 0);
		setprop("/controls/armament/gun-fire", 0);
	}
	settimer(safety_check, 0);
}

var recoil = func {
	var shooting = getprop("/controls/armament/trigger");
	var gpL_tracer = getprop("/ai/submodels/submodel[0]/count");
	var gpL_bullet = getprop("/ai/submodels/submodel[1]/count");
	var mgLi_tracer = getprop("/ai/submodels/submodel[2]/count");
	var mgLi_bullet = getprop("/ai/submodels/submodel[3]/count");
	var mgLo_tracer = getprop("/ai/submodels/submodel[4]/count");
	var mgLo_bullet = getprop("/ai/submodels/submodel[5]/count");
	var gpR_tracer = getprop("/ai/submodels/submodel[6]/count");
	var gpR_bullet = getprop("/ai/submodels/submodel[7]/count");
	var mgRi_tracer = getprop("/ai/submodels/submodel[8]/count");
	var mgRi_bullet = getprop("/ai/submodels/submodel[9]/count");
	var mgRo_tracer = getprop("/ai/submodels/submodel[10]/count");
	var mgRo_bullet = getprop("/ai/submodels/submodel[11]/count");
	var mg_fire = getprop("/controls/armament/mg-fire");
	var gun_fire = getprop("/controls/armament/gun-fire");
	var gpL_count = gpL_bullet + gpL_tracer;
	var mgLi_count = mgLi_bullet + mgLi_tracer;
	var mgLo_count = mgLo_bullet + mgLo_tracer;
	var gpR_count = gpR_bullet + gpR_tracer;
	var mgRi_count = mgRi_bullet + mgRi_tracer;
	var mgRo_count = mgRo_bullet + mgRo_tracer;
	if (shooting) {
		if (gpL_count > 0 and gun_fire){
		    interpolate("/controls/armament/gpL/recoil", 1, 0.5);
		    interpolate("/controls/armament/gpL/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/gpL/recoil", 0);
		}
		if (gpR_count > 0 and gun_fire){
		    interpolate("/controls/armament/gpR/recoil", 1, 0.75);
		    interpolate("/controls/armament/gpR/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/gpR/recoil", 0);
		}
		if (mgLi_count > 0 and mg_fire){
		    interpolate("/controls/armament/mgLi/recoil", 1, 0.25);
		    interpolate("/controls/armament/mgLi/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/mgLi/recoil", 0);
		}
		if (mgRi_count > 0 and mg_fire){
		    interpolate("/controls/armament/mgRi/recoil", 1, 0.5);
		    interpolate("/controls/armament/mgRi/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/mgRi/recoil", 0);
		}
		if (mgLo_count > 0 and mg_fire){
		    interpolate("/controls/armament/mgLo/recoil", 1, 0.4);
		    interpolate("/controls/armament/mgLo/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/mgLo/recoil", 0);
		}
		if (mgRo_count > 0 and mg_fire){
		    interpolate("/controls/armament/mgRo/recoil", 1, 0.6);
		    interpolate("/controls/armament/mgRo/recoil", 0, 0.5);
		} else {
		    setprop("/controls/armament/mgRo/recoil", 0);
		}
	} else {
	    setprop("/controls/armament/mgLi/recoil", 0);
	    setprop("/controls/armament/mgLo/recoil", 0);
	    setprop("/controls/armament/gpL/recoil", 0);
	    setprop("/controls/armament/mgRi/recoil", 0);
	    setprop("/controls/armament/mgRo/recoil", 0);
	    setprop("/controls/armament/gpR/recoil", 0);
	}
	settimer(recoil, 0.5);
}