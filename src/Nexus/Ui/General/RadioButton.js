"use strict";

export const _newRadioButton = target => () =>
  Nexus.Add.RadioButton(target);

export const _newRadioButtonBy = target => config => () =>
  Nexus.Add.RadioButton(target, config);

export const _radioButtonOn = obj => eventType => call => () => 
  obj.on(eventType, function(v) { call(v)(); });

export const _radioButtonDestroy = obj => () => 
  obj.destroy(); 

export const _radioButtonDeselect = obj => () => 
  obj.deselect(); 

export const _radioButtonSelect = obj => index => () => 
  obj.select(index); 

export const _radioButtonResize = obj => width => height => () => 
  obj.resize(width, height); 

export const _radioButtonSetNumberOfButtons = obj => size => () => 
  obj.numberOfButtons = size; 

export const _radioButtonGetNumberOfButtons = obj => () => 
  obj.numberOfButtons; 


