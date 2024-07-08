float seaLevel;
float waveHeight;
float waveSpeed;

int numClouds = 5; // Number of clouds
float[] cloudX = new float[numClouds];
float[] cloudY = new float[numClouds]; // Array to hold fixed vertical positions of clouds
float cloudSpeed = 1; // Reduced cloud speed for slower movement

PImage boat;
int numBoats = 3; // Number of boats
float[] boatX = new float[numBoats];
float[] boatY = new float[numBoats];
float[] boatScale = {0.5, 1.0, 1.5}; // Scales for the boats
float boatSpeed = 0.5; // Speed of the boat movement

void setup() {
  size(1920, 1080);
  seaLevel = height * 0.6; // Adjust sea level position
  waveHeight = 30; // Height of the waves
  waveSpeed = 0.01; // Speed of the wave animation
  
  // Load the boat image
  boat = loadImage("C:/Users/L E N O V O/Downloads/Animasi GMM/Scene_22/Sesajen Perahu.png");
  
  // Initialize boat positions
  for (int i = 0; i < numBoats; i++) {
    boatX[i] = -boat.width * boatScale[i] - i * 400 - random(100, 300); // Space the boats far apart to the left
    boatY[i] = seaLevel;
  }
  
  // Initialize cloud positions
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] = width + i * 300 + random(100, 300); // Increased initial random offset and spacing
    cloudY[i] = random(50, seaLevel - 200); // Fixed vertical position within the sky area
  }
}

void draw() {
  background(135, 206, 235); // Light blue background
  
  // Draw sea waves
  drawSeaWaves();
  
  // Draw clouds
  drawClouds();
  
  // Draw and move the boats
  drawBoats();
}

void drawSeaWaves() {
  // Calculate wave movement based on frameCount
  float waveOffset = sin(frameCount * waveSpeed) * waveHeight;
  
  // Draw sea waves
  fill(100, 149, 237); // Deep sky blue
  noStroke();
  beginShape();
  vertex(0, seaLevel);
  for (int x = 0; x <= width; x += 20) {
    float y = seaLevel + waveOffset + sin(x * 0.01 + frameCount * 0.05) * waveHeight;
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void drawClouds() {
  // Move clouds to the left
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] -= cloudSpeed;
    
    // Wrap clouds around when they go off screen
    if (cloudX[i] < -200) {
      cloudX[i] = width + random(100, 300); // Reset cloud position outside the canvas
    }
    
    // Draw cloud
    float cloudYPos = cloudY[i]; // Use fixed vertical position
    drawCloud(cloudX[i], cloudYPos, 100);
  }
}

void drawCloud(float x, float y, float size) {
  fill(255); // White cloud
  noStroke();
  
  // Draw the main part of the cloud
  ellipse(x, y, size, size);
  
  // Draw the left side of the cloud
  ellipse(x - size * 0.6, y, size * 0.6, size * 0.6);
  
  // Draw the right side of the cloud
  ellipse(x + size * 0.6, y, size * 0.6, size * 0.6);
  
  // Draw the upper left side of the cloud
  ellipse(x - size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
  
  // Draw the upper right side of the cloud
  ellipse(x + size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
}

void drawBoats() {
  for (int i = 0; i < numBoats; i++) {
    // Move the boat to the right
    boatX[i] += boatSpeed; // Move boats to the right
    
    // Wrap the boat around when it goes off screen
    if (boatX[i] > width + boat.width * boatScale[i]) {
      boatX[i] = -boat.width * boatScale[i];
    }
    
    // Update boat Y position based on wave height
    float waveOffset = sin(frameCount * waveSpeed) * waveHeight;
    boatY[i] = seaLevel + waveOffset + sin(boatX[i] * 0.01 + frameCount * 0.05) * waveHeight - boat.height * boatScale[i] / 2;
    
    // Draw the boat at its current position with scaling
    image(boat, boatX[i], boatY[i], boat.width * boatScale[i], boat.height * boatScale[i]);
  }
}
