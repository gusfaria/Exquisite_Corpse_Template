import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "ExquisiteCorpse_GUS!";
String desc   = "Some stuff";

int gusA, gusB, gusC, gusD;
color gusColor;

Spacebrew sb;

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
  
  //gus
    sb.addSubscribe( "remote_slider", "range" );

  
  // add any of your own subscribers here!
  
  sb.connect( server, name, desc );
  
  //gus 
  gusA = 0;
  gusB = 100;
  gusC = 0;
  gusD = 100;
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
    
    gusA += 10;
    gusB -= 10;
    gusC += 6;
    
      if (gusA>100){
        gusA=0;
      }
         
      if (gusB<0){
        gusB=0;
      }
      
      if (gusC>2000){           
        pushMatrix();
          translate(width/2,height/2);
          rectMode(CENTER);
           noFill();
           strokeWeight(1);
           stroke(255);
           rect(0,0,gusD,gusD);
           gusD += 20;
        popMatrix();
        rectMode(CORNER);
      }
  
    pushMatrix();
      translate(width/2,height/2);
      rotate(gusA);
      ellipseMode(CENTER);
      fill(random(255),gusA,random(255),10);
      noStroke();
      ellipse(width/2,height/2,gusC,gusC);
    popMatrix();
  
  // ---- start person 2 ---- //
  } else if ( millis() - corpseStarted < 20000 ){
    noFill();
    stroke(255);
    rect(width / 3.0,0, width / 3.0, height );
    fill(255);
  

    
    
  // ---- start person 3 ---- //
  } else if ( millis() - corpseStarted < 30000 ){
    noFill();
    stroke(255);
    rect(width * 2.0/ 3.0,0, width / 3.0, height );
    fill(255);
  
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


