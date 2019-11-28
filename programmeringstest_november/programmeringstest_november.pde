PImage gun;
float firearmScale = .2;

int targetX = 1000;
int targetY = 400;
int targetMaxRadius = 150;

int hitRadius = 7;


void setup() {
  size(1200, 800);
  gun = loadImage("gun.png");
  
  // Insert image of gun
  image(gun, 0, 300, width*firearmScale, height*firearmScale); 
  
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
}


void draw() {
  
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
  
  // Draw hit
  fill(204, 153, 0);
  circle(hitX, hitY, hitRadius*2);
}


void mouseClicked() {
  shoot();
}
