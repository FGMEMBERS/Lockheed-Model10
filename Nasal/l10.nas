#Modified from A6M2 gear for iar80

ZeroGear = {
  new : func {
    var obj = { parents : [ZeroGear],
            gear_direction : 1,
	    gear_changing : 0,
	    delay_l : 5,
	    delay_r : 6,
            first_gear : "/gear/gear[0]/position-norm",
	    second_gear : "/gear/gear[1]/position-norm" };
    setlistener("/controls/gear/gear-down", func { obj.transform(); });
    setprop(obj.first_gear, 1);
    setprop(obj.second_gear, 1);
    return obj;
  },

  transform : func {
    var last_direction = me.gear_direction;
    me.gear_direction = getprop("/controls/gear/gear-down");
    if (last_direction != me.gear_direction) {
      interpolate(me.first_gear, me.gear_direction, me.delay_l);
      interpolate(me.second_gear, me.gear_direction, me.delay_r);
      me.gear_changing = 0;
    }
  }
};
var l10 = JapaneseWarbird.new();
var l10_gear = ZeroGear.new();
