import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class collision extends PApplet {

class Ball {
    public PVector location;
    public PVector velocity;
    public PVector acceleration;

    Ball( PVector l, PVector v, PVector a ){
	location = l;
	velocity = v;
	acceleration = a;
    }
}

ArrayList<Ball> al;
PVector mouseOld;
PVector g = new PVector(0, 900); // pixels

public void setup(){
    size(1600,900);

    al = new ArrayList<Ball>();

    mouseOld = new PVector();
}

public void draw() {
    background(0); // clear

    float dt = 1/frameRate;

    physics(dt);
    draw_stuff();
}

public void physics( float dt ) {
    // gravity
    for (Ball b : al) {
	b.acceleration = g.get(); // set force acting on objs -> gravity
    }

    // motion
    for (Ball b : al) {
	PVector a = b.acceleration.get();
	PVector v = b.velocity.get();
	a.mult(dt);
	v.mult(dt);

	b.velocity.add(a);
	b.location.add(v);
    }

    // boundary check
    for (Ball b : al) {
	if (b.location.x > displayWidth || b.location.x < 0 ) {
	    b.velocity.x *= -1;
	    b.velocity.mult(0.99f);
	}
	if (b.location.y > displayHeight || b.location.y < 0 ) {
	    b.velocity.y *= -1;
	    b.velocity.mult(0.99f);
	}
    }
    
    // circle to circle
    
    
}

public void draw_stuff() {
    // draw balls
    fill(255, 0, 0);
    stroke(0);
    for (Ball b : al) {
	ellipse(b.location.x, b.location.y, 20, 20);
    }
    
    // draw mouse-drag
    stroke(255);
    if (mousePressed == true) {
	if (mouseButton == LEFT) {
	    line(mouseX, mouseY, mouseOld.x, mouseOld.y);
	}
    }
}

public void mousePressed(){
    if (mouseButton == LEFT){
	mouseOld = new PVector(mouseX, mouseY);
    }
}

public void mouseReleased(){
    PVector b_vel = new PVector(mouseOld.x - mouseX, mouseOld.y - mouseY);
    PVector mo = mouseOld.get();

    if (mouseButton == LEFT){
	Ball b = new Ball(mo, b_vel, new PVector(0,0));
	al.add(b);
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "collision" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
