# STARTER
setlistener("controls/switches/starter", func(n) {
	var pos2 = n.getValue();
	if(pos2){
		interpolate("controls/switches/starter-pos-norm", 1, 0.75);
	}else{
		interpolate("controls/switches/starter-pos-norm", 0, 0.75);
	}
},1);

# PRIMER
setlistener("controls/engines/engine[0]/primer-pressed", func(n) {
	var pos2 = n.getValue();
	if(pos2){
		interpolate("controls/engines/engine[0]/primer-pos-norm", 1, 0.3);
	}else{
		interpolate("controls/engines/engine[0]/primer-pos-norm", 0, 0.3);
	}
},1);

#PANEL LIGHT SW Left
setlistener("controls/lighting/panel-left-sw-press", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/lighting/panel-left-sw-pos", 1.0, 0.3);
    }else{
	interpolate("controls/lighting/panel-left-sw-pos", 0.0, 0.3);
    }
},1);

setlistener("controls/lighting/panel-left-sw-pos", func(n) {
    var pos2 = n.getValue() or 0.0;
    var bat_sw = getprop("controls/electric/battery-switch");
    if(pos2 > 0.75 and bat_sw){
	setprop("controls/lighting/panel-left", 1.0);
    }else{
	setprop("controls/lighting/panel-left", 0.0);
    }
},1);

#PANEL LIGHT SW Right
setlistener("controls/lighting/panel-right-sw-press", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/lighting/panel-right-sw-pos", 1.0, 0.3);
    }else{
	interpolate("controls/lighting/panel-right-sw-pos", 0.0, 0.3);
    }
},1);

setlistener("controls/lighting/panel-right-sw-pos", func(n) {
    var pos2 = n.getValue() or 0.0;
    var bat_sw = getprop("controls/electric/battery-switch");
    if(pos2 > 0.75 and bat_sw){
	setprop("controls/lighting/panel-right", 1.0);
    }else{
	setprop("controls/lighting/panel-right", 0.0);
    }
},1);

#GearEmergRelease sw
setlistener("controls/gear/emergrel-click", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/gear/emergrel-pos-norm", 1.0, 0.5);
    }else{
	interpolate("controls/gear/emergrel-pos-norm", 0.0, 0.5);
    }
},1);

setlistener("controls/gear/emergrel-pos-norm", func(n) {
    var pos2 = n.getValue() or 0.0;
    if(pos2 > 0.75){
	setprop("controls/gear/emerg-release", 1.0);
    }else{
	setprop("controls/gear/emerg-release", 0.0);
    }
},1);

#GearSafety knob
setlistener("controls/gear/safety-click", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/gear/safety-pos-norm", 1.0, 0.5);
    }else{
	interpolate("controls/gear/safety-pos-norm", 0.0, 0.5);
    }
},1);

setlistener("controls/gear/safety-pos-norm", func(n) {
    var pos2 = n.getValue() or 0.0;
    if(pos2 > 0.75){
	setprop("controls/gear/safety-on", 1.0);
    }else{
	setprop("controls/gear/safety-on", 0.0);
    }
},1);

#Manual Gear pump
setlistener("controls/gear/mangear-click", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/gear/mangear-pos-norm", 1.0, 1);
    }else{
	interpolate("controls/gear/mangear-pos-norm", 0.0, 0.5);
    }
},1);

setlistener("controls/gear/mangear-pos-norm", func(n) {
    var pos2 = n.getValue() or 0.0;
    var man_pump = getprop("controls/gear/man-pump") or 0.0;
    var new_man_pump = 0;
    var gear_safety = getprop("controls/gear/safety-on");
    if(pos2 > 0.95){
	if (gear_safety){
	    new_man_pump = man_pump + 1.1;
	    setprop("controls/gear/man-pump", new_man_pump);
	} else {
	    setprop("controls/gear/man-pump", man_pump);
	}
    }else{
	setprop("controls/gear/man-pump", man_pump);
    }
},1);

#GunArm sw
setlistener("controls/armament/gunsel-click", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/armament/gunsel-pos-norm", 1.0, 0.5);
    }else{
	interpolate("controls/armament/gunsel-pos-norm", 0.0, 0.5);
    }
},1);

setlistener("controls/armament/gunsel-pos-norm", func(n) {
    var pos2 = n.getValue() or 0.0;
    if(pos2 > 0.75){
	setprop("controls/armament/gun-armed", 1.0);
    }else{
	setprop("controls/armament/gun-armed", 0.0);
    }
},1);

#MGArm sw
setlistener("controls/armament/mgsel-click", func(n) {
    var pos2 = n.getValue();
    if(pos2){
	interpolate("controls/armament/mgsel-pos-norm", 1.0, 0.5);
    }else{
	interpolate("controls/armament/mgsel-pos-norm", 0.0, 0.5);
    }
},1);

setlistener("controls/armament/mgsel-pos-norm", func(n) {
    var pos2 = n.getValue() or 0.0;
    if(pos2 > 0.75){
	setprop("controls/armament/mg-armed", 1.0);
    }else{
	setprop("controls/armament/mg-armed", 0.0);
    }
},1);