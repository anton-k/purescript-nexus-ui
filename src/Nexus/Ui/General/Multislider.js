"use strict";

export const _newMultislider = target => () =>
  Nexus.Add.Multislider(target);

export const _newMultisliderBy = target => config => () =>
  Nexus.Add.Multislider(target, config);

export const _multisliderOn = obj => eventType => call => () => 
  obj.on(eventType, function(v) { call(v)(); });

export const _multisliderSetSlider = obj => index => value => () => 
  obj.setSlider(index, value);

export const _multisliderSetAllSliders = obj => values => () => 
  obj.setAllSliders(values);
