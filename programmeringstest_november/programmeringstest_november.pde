PImage gun;
PImage gunfire;

int targetX = 1000;
int targetY = 400;
int targetMaxRadius = 150;

int hitRadius = 7;

int score = 0;
int[] points = {50, 30, 20, 10, 5}; 

// Vars for fire animation
int fireTiming = 0;
boolean showFire = false;

// Array to hold x and y for each hit. Max count of hits is 200
float[][] hits = new float[200][2];
int countHits = 0;

// Colors for target
color white = color(255, 255, 255);
color black = color(0, 0, 0);
color blue = color(0, 201, 243);
color red = color(255, 52, 35);
color yellow = color(253, 229, 123);

color[] targetColors = {white, black, blue, red, yellow, red};


void setup() {
  size(1200, 800);
  gun = loadImage("gun.png");
  gunfire = loadImage("gunfire.png");
}


void draw() {
  clear();
  background(226, 225, 221);
  
  textAlign(CENTER);
  textSize(30);
  text("Din score: " + score, 150, 40);
  
  // Insert image of gun
  imageMode(CENTER);
  if (showFire) {
    image(gun, 170 - (150 - (millis()-fireTiming)), 400, 310, 200);
  } else {
    image(gun, 170, 400, 310, 200);
  }
  
  // Draw target
  for (int i=0; i<5; i++) {
    fill(targetColors[i]);
    circle(targetX, targetY, targetMaxRadius*2 - i*50);
  }
  // The last center point is irregular, so this one is created outside the loop
  fill(255, 52, 35);
  circle(targetX, targetY, 20);
  
  // Show fire image
  if (showFire) {
    imageMode(CORNER);
    image(gunfire, 300, 235, 300, 200);
    
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
  float distanceToCenter = 0;
  
  // Generate new coordinates until the point is inside the circle
  while (!insideTarget) {
    
    // Get random coordianates for the shot
    hitX = targetX + random(targetMaxRadius * (-1) + hitRadius, targetMaxRadius - hitRadius);
    hitY = targetY + random(targetMaxRadius * (-1) + hitRadius, targetMaxRadius - hitRadius);
    
    // Check if the coordinates are inside the target (circle)
    distanceToCenter = sqrt(pow(hitX-targetX, 2) + pow(hitY-targetY, 2));
    insideTarget = distanceToCenter < targetMaxRadius; 
  }
  
  // Add coordinates to array and add one to counter
  hits[countHits][0] = hitX;
  hits[countHits][1] = hitY;
  countHits++;
  
  // Show fire animation
  fireTiming = millis();
  showFire = true;
  
  // Points
  score += points[floor(distanceToCenter / 50)];
  
}


void mouseClicked() {
  shoot();
}
