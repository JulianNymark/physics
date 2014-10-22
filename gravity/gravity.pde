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
// define gravity vector

void setup(){
    size(1600,900);

    al = new ArrayList<Ball>();

    mouseOld = new PVector();
}

void draw() {
    background(0); // clear

    float dt = 1/frameRate;

    physics(dt);
    draw_stuff();
}

void physics( float dt ) {
    // motion
    for (Ball b : al){
	PVector a = b.acceleration.get();
	PVector v = b.velocity.get();
	a.mult(dt);
	v.mult(dt);

	b.velocity.add(a);
	b.location.add(v);
    }

    // gravity
    
}

void draw_stuff() {
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

void mousePressed(){
    if (mouseButton == LEFT){
	mouseOld = new PVector(mouseX, mouseY);
    }
}

void mouseReleased(){
    PVector b_vel = new PVector(mouseOld.x - mouseX, mouseOld.y - mouseY);
    PVector mo = mouseOld.get();

    if (mouseButton == LEFT){
	Ball b = new Ball(mo, b_vel, new PVector(0,0));
	al.add(b);
    }
}
