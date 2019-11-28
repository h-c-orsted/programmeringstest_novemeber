PImage gun;
PImage gunfire;

int targetX = 1000;
int targetY = 400;
int targetMaxRadius = 150;

int hitRadius = 7;

int fireTiming = 0;
boolean showFire = false;

float[][] hits = new float[100][2];
int countHits = 0;


void setup() {
  size(1200, 800);
  gun = loadImage("gun.png");
  gunfire = loadImage("gunfire.png");
}


void draw() {
  clear();
  background(226, 225, 221);
  
  // Insert image of gun
  imageMode(CENTER);
  image(gun, 155, 400, 310, 200); 
  
  // Draw target
  fill(255, 255, 255);
  circle(targetX, targetY, 300);
  fill(0, 0, 0);
  circle(targetX, targetY, 250);
  fill(0, 201, 243);
  circle(targetX, targetY, 200);
  fill(255, 52, 35);
  circle(targetX, targetY, 150);
  fill(253, 229, 123);
  circle(targetX, targetY, 100);
  fill(255, 52, 35);
  circle(targetX, targetY, 20);
  
  if (showFire) {
    imageMode(CORNER);
    image(gunfire, 290, 240, 300, 200);
    
    if (millis() - fireTiming > 150) {showFire=false;}
  }
  
  // Create each hit
  for (int i=0; i<countHits; i++) {
    fill(204, 153, 0);
    circle(hits[i][0], hits[i][1], hitRadius*2);
  }
}


void shoot() {
  boolean insideTarget = false;
  float hitX = 0;
  float hitY = 0;
  
  // Generate new coordinates until the point is inside the circle
  while (!insideTarget) {
    
    // Get random coordianates for the shot
    hitX = targetX + random(targetMaxRadius * (-1) + hitRadius, targetMaxRadius - hitRadius);
    hitY = targetY + random(targetMaxRadius * (-1) + hitRadius, targetMaxRadius - hitRadius);
    
    // Check if the coordinates are inside the target (circle)
    insideTarget = sqrt(pow(hitX-targetX, 2) + pow(hitY-targetY, 2)) < targetMaxRadius; 
  }
  
  hits[countHits][0] = hitX;
  hits[countHits][1] = hitY;
  countHits++;
  
  // Show fire animation
  fireTiming = millis();
  showFire = true;
}


void mouseClicked() {
  shoot();
}
