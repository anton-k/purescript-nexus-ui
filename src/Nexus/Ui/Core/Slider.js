"use strict";

export const _newSlider = target => () =>
  Nexus.Add.Slider(target);

export const _newSliderBy = target => config => () =>
  Nexus.Add.Slider(target, config);

export const _sliderOn = slider => eventType => call => () => 
  slider.on(eventType, function(v) { call(v)(); });

export const _sliderSetMax = slider => value => () => 
  slider.max = value; 

export const _sliderGetMax = slider => () => 
  slider.max; 

export const _sliderSetMin = slider => value => () => 
  slider.min = value; 

export const _sliderGetMin = slider => () => 
  slider.min; 

export const _sliderSetMode = slider => value => () => 
  slider.mode = value; 

export const _sliderGetMode = slider => () => 
  slider.mode; 

export const _sliderSetStep = slider => value => () => 
  slider.step = value; 

export const _sliderGetStep = slider => () => 
  slider.step; 

export const _sliderSetValue = slider => value => () => 
  slider.value = value; 

export const _sliderGetValue = slider => () => 
  slider.value; 

export const _sliderDestroy = slider => () => 
  slider.destroy(); 

export const _sliderResize = slider => width => height => () => 
  slider.resize(width, height); 
