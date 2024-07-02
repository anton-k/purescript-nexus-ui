"use strict";

export const _newTextButton = target => () =>
  Nexus.Add.TextButton(target);

export const _newTextButtonBy = target => config => () =>
  Nexus.Add.TextButton(target, config);

export const _textButtonOn = obj => eventType => call => () => 
  obj.on(eventType, function (v) { call(v)(); });

export const _textButtonSetMode = obj => value => () => 
  obj.mode = value; 

export const _textButtonGetMode = obj => () => 
  obj.mode; 

export const _textButtonSetText = obj => value => () => 
  obj.text = value; 

export const _textButtonGetText = obj => () => 
  obj.text; 

export const _textButtonSetAlternateText = obj => value => () => 
  obj.alternateText = value; 

export const _textButtonGetAlternateText = obj => () => 
  obj.alternateText; 

export const _textButtonSetState = obj => value => () => 
  obj.state = value; 

export const _textButtonGetState = obj => () => 
  obj.state; 

export const _textButtonDestroy = obj => () => 
  obj.destroy(); 

export const _textButtonFlip = obj => () => 
  obj.flip(); 

export const _textButtonResize = obj => width => height => () => 
  obj.resize(width, height); 

export const _textButtonTurnOff = obj => () => 
  obj.turnOff(); 

export const _textButtonTurnOn = obj => () => 
  obj.turnOn(); 

export const _textButtonColorize = obj => prop => color => () => 
  obj.colorize(prop, color);
