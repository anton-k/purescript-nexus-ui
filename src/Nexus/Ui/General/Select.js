"use strict";

export const _newSelect = target => () =>
  Nexus.Add.Select(target);

export const _newSelectBy = target => config => () =>
  Nexus.Add.Select(target, config);

export const _selectOn = obj => eventType => call => () => 
  obj.on(eventType, function(v) { call(v)(); });

export const _selectSetSelectedIndex = obj => index => () => 
  obj.selectedIndex = index; 

export const _selectGetSelectedIndex = obj => () => 
  obj.selectedIndex; 

export const _selectSetValue = obj => index => () => 
  obj.value = index; 

export const _selectGetValue = obj => () => 
  obj.value; 

export const _selectResize = obj => width => height => () => 
  obj.resize(width, height); 

export const _selectDestroy = obj => () => 
  obj.destroy(); 

export const _selectDefineOptions = obj => options => () => 
  obj.defineOptions(options);

export const _selectColorize = obj => property => color => () => 
  obj.colorize(property, color); 
