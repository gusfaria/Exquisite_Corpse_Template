/*************
 Input for Exquisite Corpse, third animation
 Input is audio level from internal microphone.
 Affects size and color of circle in the Exquisite Corpse app.
 
 February 11, 2014
 
 **************/

// Minim stuff

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput input;

// Spacebrew stuff

import spacebrew.*;
Spacebrew sb;
String server = "sandbox.spacebrew.cc";
String name = "Jennifer_Publisher_App";
String desc = "Application to capture Jennifer's input and send it on";

// variable for smoothing value for audio input
float smoothRange;

void setup() {
  size(300, 300);

  // Minim setup
  minim = new Minim(this);
  input = minim.getLineIn();

  // Spacebrew setup
  sb = new Spacebrew ( this );
  sb.addPublish( "jenniferRange", "range", 0 );
  sb.connect(server, name, desc );

  smoothRange = 0.0;
}

void draw() {

  // volume will be number between 0 and 1
  float volume = input.mix.level();
  //  println("volume level: " + volume);
  
  // use only 0 to 0.4, so don't have to be too loud
  float preRange = map(volume, 0, 0.4, 0, 1024);
  
  // smooth the input level; otherwise very herky-jerky
  smoothRange = 0.95 * smoothRange + 0.05 * preRange;
  
  // create integer to send across
  int rangeToSend = floor(smoothRange);

  // clamp the number to 1023
  if (rangeToSend > 1023) {
    rangeToSend = 1023;
  }

  //  println("signal to be sent: " + rangeToSend);
  sb.send("jenniferRange", rangeToSend);

  // change color of rectangle to show volume
  float newColor = map(rangeToSend, 0, 1024, 0, 255);
  fill(newColor, newColor, newColor);
  rect(0, 0, width, height);
}

