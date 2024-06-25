"use strict";

export const _newDial = target => () =>
  Nexus.Add.Dial(target);

export const _newDialBy = target => config => () =>
  Nexus.Add.Dial(target, config);

export const _dialOn = dial => eventType => call => () => 
  dial.on(eventType, call);

export const _dialSetMax = dial => value => () => 
  dial.max = value; 

export const _dialGetMax = dial => () => 
  dial.max; 

export const _dialSetMin = dial => value => () => 
  dial.min = value; 

export const _dialGetMin = dial => () => 
  dial.min; 

export const _dialSetMode = dial => value => () => 
  dial.mode = value; 

export const _dialGetMode = dial => () => 
  dial.mode; 

export const _dialSetStep = dial => value => () => 
  dial.step = value; 

export const _dialGetStep = dial => () => 
  dial.step; 

export const _dialSetValue = dial => value => () => 
  dial.value = value; 

export const _dialGetValue = dial => () => 
  dial.value; 

export const _dialDestroy = dial => () => 
  dial.destroy(); 

export const _dialResize = dial => width => height => () => 
  dial.resize(width, height); 
