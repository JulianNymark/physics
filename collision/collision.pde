float DAMPEN_BORDER = 0.90;
float DAMPEN_C2C = 0.99;
float C_RADIUS = 10;

class Ball {
    public PVector location;
    public PVector velocity;
    public PVector acceleration;
    public PVector radius;

    Ball( PVector l, PVector v, PVector a ){
	location = l;
	velocity = v;
	acceleration = a;
	radius = new PVector(C_RADIUS, C_RADIUS);
    }
}

ArrayList<Ball> al;
PVector mouseOld;
PVector g = new PVector(0, 900); // pixels

void setup(){
    size(1600,900);

    al = new ArrayList<Ball>();

    mouseOld = new PVector();

    ellipseMode(RADIUS);
}

void draw() {
    background(0); // clear

    float dt = 1/frameRate;

    physics(dt);
    draw_stuff();
}

void physics( float dt ) {
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
    // TODO
    
    // circle to circle collision
    // TODO
    
    // print some info
    fill(255);
    textSize(32);
    text("FPS: " + round(frameRate), 10, 32);
    text("Balls: " + al.size(), 10, 32*2);
}

void draw_stuff() {
    // draw balls
    fill(255, 0, 0);
    stroke(0);
    for (Ball b : al) {
	ellipse(b.location.x, b.location.y, b.radius.x, b.radius.y);
    }
    
    // draw mouse-drag
    stroke(255);
    if (mousePressed == true) {
	if (mouseButton == LEFT) {
	    line(mouseX, mouseY, mouseOld.x, mouseOld.y);
	}
    }
}

void mousePressed(){
    if (mouseButton == LEFT){
	mouseOld = new PVector(mouseX, mouseY);
    }
}

void mouseReleased(){
    PVector b_vel = new PVector(mouseOld.x - mouseX, mouseOld.y - mouseY);
    PVector mo = mouseOld.get();

    if (mouseButton == LEFT){
	Ball b = new Ball(mo, b_vel, new PVector());
	al.add(b);
    }

    if (mouseButton == RIGHT){
	for (int i = 0; i < 10; ++i){
	    Ball b = new Ball(new PVector(mouseX, mouseY), new PVector(), new PVector());
	    al.add(b);
	}
    }

}
