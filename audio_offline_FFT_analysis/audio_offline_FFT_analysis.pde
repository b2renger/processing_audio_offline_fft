
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.spi.*;
import controlP5.*;

ControlP5 cp5;
Minim minim;

boolean fileSelected = false;
String file = "jingle.mp3";

Table table;
int fftSize = 1024;

int nbands = 2;
int minBandwith = 2;

void setup() {
  size(640, 480);

  minim = new Minim(this); 
  cp5 = new ControlP5(this);

  setup_gui();
}

void draw() {
  textAlign(CENTER, CENTER);
  background(0);

  text(file, width/2, height*0.15);
}





float dB(float x) {
  if (x == 0) {
    return 0;
  } else {
    return 10 * (float)Math.log10(x);
  }
}
