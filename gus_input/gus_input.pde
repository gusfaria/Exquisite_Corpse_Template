/*
 * Slider Example
 *
 *   This example is of a slider that sends a value in the range of 0 to 1023.  
 *   Click and drag the mouse to move the slider.
 * 
 */

import spacebrew.*;

String server="sandbox.spacebrew.cc";
String name="Gus_slider";
String description ="Client that sends and receives range messages. Range values go from 0 to 1023.";


Spacebrew sb;

// Keep track of our current place in the range
int local_slider_val = 512;
int remote_slider_val = 512;

void setup() {
  size(1044, 200);
  background(0);

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "gus_slider", "range", local_slider_val ); 

  // connect!
  sb.connect(server, name, description );
  
}

void draw() {
  background(50);
  stroke(0);

  // Display the current value of local and remote sliders
  fill(255);
  text("Local Slider Value: ", 30, 40);  
  text(local_slider_val, 180, 40);  

  // White box containing slider
  fill(255);
  rect(0, height/2, width, height/2);

  // Line the slider moves on
  fill(150);
  line(0, height * 3/4, width, height * 3/4);

  // Local Slider
  fill(255, 0, 0);
  stroke(200, 0, 0);
  rect(local_slider_val, (height/2) + 5, 20, (height/2) - 10);
}

void mouseDragged() {
  // Leaving 20 pixels at the end prevents the slider from going off the screen
  if (mouseX >= 0 && mouseX <= width - 20) {
    local_slider_val = mouseX;
    sb.send("gus_slider", local_slider_val);
  }   
}


void onRangeMessage( String name, int value ){

}
