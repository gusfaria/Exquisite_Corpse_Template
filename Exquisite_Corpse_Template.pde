import spacebrew.*;

//Alex
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import javax.sound.sampled.*;
Minim minim;
AudioPlayer turret;
PImage bird;
PImage background;
float alexDraw;
float b;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "Gus_Alex_Jennifer";
String desc   = "Exquisite Corpse Animation Extravaganza";

Spacebrew sb;

// Jennifer variables
JenniferParticle jenniferCircle;
float jenniferRedValue;
float jenniferDiameterValue;

// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;


void setup() {
  size( appWidth, appHeight );

  //Alex
  minim = new Minim(this);
  turret = minim.loadFile("ignition.mp3");
  bird = loadImage("bird.png");
  background = loadImage("background.jpeg");

  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  sb.addSubscribe("alexInput", "boolean");
  sb.addSubscribe("jenniferRange", "range");

  sb.connect( server, name, desc );

  alexDraw = 0;

  b = .2;
  Minim minim;
  AudioPlayer turret;

  jenniferCircle = new JenniferParticle();
}

void draw() {
  background(0);
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;

  // blank out your background once
  if ( bNeedToClear ) {
    bNeedToClear = false;
    // feel free to change the background color!
  }

  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ) {
    //Alex
    alexDraw = b++;
    noStroke();
    //image(background, width / 100, 0, width / 3.0, height);
    fill(30, 20, 100);
    ellipse(alexDraw, alexDraw/4, 50 + alexDraw/5, 50 +alexDraw/5);
    fill(255, 20, 20);
    ellipse(alexDraw/4, alexDraw +2, 30, 30);
    fill(0, 255, 0);
    ellipse(alexDraw-10, alexDraw*2, 40 - alexDraw, 40 + alexDraw);
    fill(20, 80, 98);
    ellipse(alexDraw*2, alexDraw - 10, 40 - alexDraw, 40- alexDraw);
    fill(20, 28, 120);
    ellipse(alexDraw/4, alexDraw +2, 100- alexDraw, 100-alexDraw);
    fill(130, 40, 255);
    ellipse(alexDraw*3, alexDraw - 20, 100-alexDraw, 100 + alexDraw);
    image(bird, alexDraw*2, 300, 50, 50);
    fill(0);

    rect(width / 3.0, 0, width / 3.0, height );
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );

    // ---- start person 2 ---- //
  } 
  else if ( millis() - corpseStarted < 20000 ) {

    noFill();
    stroke(255);
    rect(width / 3.0, 0, width / 3.0, height );
    fill(255);

    // ---- start person 3 ---- //
  } 
  else if ( millis() - corpseStarted < 30000 ) {
    println("xPos: " + jenniferCircle.xPos + " yPos: " + jenniferCircle.yPos);
    fill(0);
    stroke(255);
    rect(width * 2.0/ 3.0, 0, width / 3.0, height );

    jenniferCircle.update();
    jenniferCircle.display();
    println("diameter: " + jenniferCircle.diameter);
    println("xPos: " + jenniferCircle.xPos);
    println("yPos: " + jenniferCircle.yPos);

    // ---- we're done! ---- //
  } 
  else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed() {
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void keyPressed() {
  // for debugging purposes only
  jenniferCircle.resetPosition();
  println("keypressed!");
}

void onBooleanMessage( String name, boolean value ) {
  if ( name.equals("startExquisite") ) {
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  } 
  //Alex
  if (name.equals("alexInput")) {

    turret.play();
  }
}

void onRangeMessage( String name, int value ) {
  if (name.equals("jenniferRange") ) {
    jenniferRedValue = map(float(value), 0, 1024, 0, 255); // redness of circle
    jenniferDiameterValue = map(float(value), 0, 1024, 0, jenniferCircle.maxDiameter); // diameter of circle
    println("incoming value: " + value);
    println("jenniferRedValue: " + jenniferRedValue);
    println("jenniferDiameterValue: " + jenniferDiameterValue);
  }
}

void onStringMessage( String name, String value ) {
}

