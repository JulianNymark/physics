class Ball {
    public PVector location;
    public PVector velocity;
    public PVector acceleration;
    public PVector radius;

    Ball( PVector l, PVector v, PVector a ){
	location = l;
	velocity = v;
	acceleration = a;
	radius = new PVector(20, 20);
    }
}

ArrayList<Ball> al;
PVector mouseOld;
PVector g = new PVector(0, 900); // pixels

float DAMPEN = 0.90;

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
    for (Ball b : al) {
	if (b.location.x > width - b.radius.x ) {
	    b.velocity.x *= -1;
	    b.velocity.mult(DAMPEN);
	    b.location.x = width - b.radius.x;
	}
	if (b.location.x < 0 + b.radius.x) {
	    b.velocity.x *= -1;
	    b.velocity.mult(DAMPEN);
	    b.location.x = 0 + b.radius.x;
	}
	if (b.location.y > height - b.radius.y) {
	    b.velocity.y *= -1;
	    b.velocity.mult(DAMPEN);
	    b.location.y = height - b.radius.y;
	}
	if (b.location.y < 0 + b.radius.y) {
	    b.velocity.y *= -1;
	    b.velocity.mult(DAMPEN);
	    b.location.y = 0 + b.radius.y;
	}
    }
    
    // circle to circlec collision
    for (int i = 0; i < al.size(); ++i) {
	for (int i2 = i; i2 < al.size(); ++i2) {
	    Ball b = al.get(i);
	    Ball b2 = al.get(i2);

	    if (b != b2) {
		// detect collision
		if (b.location.dist(b2.location) < b.radius.x + b2.radius.x) {
		    // resolve collision
		    PVector vec_delta = b.location.get();
		    vec_delta.sub(b2.location);
		    float angle_delta = vec_delta.heading();
		    
		    // rotate vel
		    b2.velocity.rotate(-angle_delta);
		    b.velocity.rotate(-angle_delta);
		    
		    // swap x values of velocities
		    float temp = b.velocity.x;
		    b.velocity.x = b2.velocity.x;
		    b2.velocity.x = temp;
		    
		    // rotate back
		    b.velocity.rotate(angle_delta);
		    b2.velocity.rotate(angle_delta);
		}
	    }
	}
    }
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
	Ball b = new Ball(mo, b_vel, new PVector(0,0));
	al.add(b);
    }
}
