"use strict";

export const _newButton = target => () =>
  Nexus.Add.Button(target);

export const _newButtonBy = target => config => () =>
  Nexus.Add.Button(target, config);

export const _buttonOn = obj => eventType => call => () => 
  obj.on(eventType, function () { call(); });

export const _buttonSetMode = obj => value => () => 
  obj.mode = value; 

export const _buttonGetMode = obj => () => 
  obj.mode; 

export const _buttonSetState = obj => value => () => 
  obj.state = value; 

export const _buttonGetState = obj => () => 
  obj.state; 

export const _buttonDestroy = obj => () => 
  obj.destroy(); 

export const _buttonFlip = obj => () => 
  obj.flip(); 

export const _buttonResize = obj => width => height => () => 
  obj.resize(width, height); 

export const _buttonTurnOff = obj => () => 
  obj.turnOff(); 

export const _buttonTurnOn = obj => () => 
  obj.turnOn(); 

export const _buttonColorize = obj => prop => color => () => 
  obj.colorize(prop, color);
