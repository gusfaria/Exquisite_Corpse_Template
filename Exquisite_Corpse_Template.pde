import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteCorpse_Jennifer!";
String desc   = "Some stuff";

Spacebrew sb;

// Jennifer variables
JenniferParticle jenniferCircle;

// App Size: you should decide on a width and height
// for your group
int appWidth  = 1280;
int appHeight = 720;

// EC stuff
int corpseStarted   = 0;
boolean bDrawing    = false;
boolean bNeedToClear = false;

void setup(){
  size( appWidth, appHeight );
  
  sb = new Spacebrew(this);
  sb.addPublish("doneExquisite", "boolean", false);
  sb.addSubscribe("startExquisite", "boolean");
  
  // add any of your own subscribers here!
  
  sb.connect( server, name, desc );
  
  jenniferCircle = new JenniferParticle();
  jenniferCircle.reset();
}

void draw(){
  // this will make it only render to screen when in EC draw mode
  if (!bDrawing) return;
  
  // blank out your background once
  if ( bNeedToClear ){
    bNeedToClear = false;
    background(0); // feel free to change the background color!
  }
  
  // ---- start person 1 ---- //
  if ( millis() - corpseStarted < 10000 ){
    noFill();
    stroke(255);
    rect(0,0, width / 3.0, height );
    fill(255);
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
    
  // ---- start person 3 ---- //
  } else if ( millis() - corpseStarted < 30000 ){
    println("r: " + jenniferCircle.r + " and diameter: " + jenniferCircle.diameter);
    println("xPos: " + jenniferCircle.xPos + " yPos: " + jenniferCircle.yPos);
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    
    jenniferCircle.update();
    jenniferCircle.display();

    fill(255);
    ellipse(jenniferCircle.xPos, jenniferCircle.yPos,  100, 100);  
  
    ellipse(20, 20, 100, 100);
    ellipse(882, 959);
  
  // ---- we're done! ---- //
  } else {
    sb.send( "doneExquisite", true );
    bDrawing = false;
  }
}

void mousePressed(){
  // for debugging, comment this out!
  sb.send( "doneExquisite", true );
}

void keyPressed() {
  jenniferCircle.reset();
  println("keypressed!");
}

void onBooleanMessage( String name, boolean value ){
  if ( name.equals("startExquisite") ){
    // start the exquisite corpse process!
    bDrawing = true;
    corpseStarted = millis();
    bNeedToClear = true;
  }
}

void onRangeMessage( String name, int value ){
}

void onStringMessage( String name, String value ){
}


