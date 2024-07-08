float seaLevel;
float waveHeight;
float waveSpeed;

int numClouds = 5; // Number of clouds
float[] cloudX = new float[numClouds];
float[] cloudY = new float[numClouds]; // Array to hold fixed vertical positions of clouds
float cloudSpeed = 1; // Reduced cloud speed for slower movement

PImage boat;
PImage vita;
PImage lintang;

int numBoats = 3; // Number of boats
float[] boatX = new float[numBoats];
float[] boatY = new float[numBoats];
float boatScale = 0.3; // Smaller scale for all boats
float boatSpeed = 0.2; // Slower speed for the boats

float[] whiteSandX;
float[] whiteSandY;
float[] whiteSandSpeed;

void setup() {
  size(1920, 1080);
  seaLevel = height * 0.6; // Adjust sea level position
  waveHeight = 10; // Smaller height of the waves for minimal vertical movement
  waveSpeed = 0.01; // Speed of the wave animation
  
  // Load the images
  boat = loadImage("C:/Users/L E N O V O/Downloads/Animasi GMM/Scene_22/Sesajen Perahu.png");
  vita = loadImage("C:/Users/L E N O V O/Downloads/Animasi GMM/Scene_25/Vita 1.png");
  lintang = loadImage("C:/Users/L E N O V O/Downloads/Animasi GMM/Scene_25/Lintang 2.png");
  
  // Initialize boat positions
  for (int i = 0; i < numBoats; i++) {
    boatX[i] = -boat.width * boatScale - i * 400 - random(100, 300); // Space the boats far apart to the left
    boatY[i] = seaLevel;
  }
  
  // Initialize cloud positions
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] = width + i * 300 + random(100, 300); // Increased initial random offset and spacing
    cloudY[i] = random(50, seaLevel - 200); // Fixed vertical position within the sky area
  }
  
  // Initialize the white sand particles
  whiteSandX = new float[100];
  whiteSandY = new float[100];
  whiteSandSpeed = new float[100];
  for (int i = 0; i < whiteSandX.length; i++) {
    whiteSandX[i] = random(width);
    whiteSandY[i] = random(height / 1.5, height);
    whiteSandSpeed[i] = random(1, 3);
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
  
  // Draw the beach
  fill(255, 228, 181);
  rect(0, height / 1.5, width, height / 3);
  
  // Draw the palm tree trunk
  fill(139, 69, 19);
  beginShape();
  vertex(100, height / 1.5);
  vertex(120, height / 1.5);
  vertex(140, height / 3);
  vertex(160, height / 3);
  vertex(140, height / 1.5);
  vertex(120, height / 1.5);
  endShape(CLOSE);
  
  // Draw the palm leaves
  fill(34, 139, 34);
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    translate(150, height / 3);
    rotate(PI / 3 * i);
    ellipse(0, 0, 120, 40);
    popMatrix();
  }
  
  // Draw coconuts
  fill(139, 69, 19);
  ellipse(150, height / 3, 20, 20);
  ellipse(160, height / 3 + 10, 20, 20);
  ellipse(140, height / 3 + 10, 20, 20);
  
  // Draw and animate the white sand particles
  fill(255, 255, 255);
  noStroke();
  for (int i = 0; i < whiteSandX.length; i++) {
    ellipse(whiteSandX[i], whiteSandY[i], 5, 5);
    whiteSandX[i] += whiteSandSpeed[i];
    whiteSandY[i] -= whiteSandSpeed[i] * 0.1;
    if (whiteSandX[i] > width) {
      whiteSandX[i] = 0;
      whiteSandY[i] = random(height / 1.5, height);
    }
  }
  
  // Draw Vita image on the left side, scaled down and showing only the bottom half
  pushMatrix();
  translate(width / 2 - vita.width / 4 - 150, height - vita.height / 2 * 0.5 + 150); // Adjusted for further downward positioning and closer to center
  scale(0.7, 0.7); // Scale down the image
  image(vita, 0, -vita.height / 2);
  popMatrix();
  
  // Draw Lintang image on the right side, scaled down and showing only the bottom half
  pushMatrix();
  translate(width / 2 + lintang.width / 4 + 150, height - lintang.height / 2 * 0.5 + 150); // Adjusted for further downward positioning and closer to center
  scale(0.5, 0.5); // Scale down the image
  image(lintang, -lintang.width / 2, -lintang.height / 2);
  popMatrix();
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
    if (boatX[i] > width + boat.width * boatScale) {
      boatX[i] = -boat.width * boatScale;
    }
    
    // Update boat Y position based on wave height
    float waveOffset = sin(frameCount * waveSpeed) * waveHeight;
    boatY[i] = seaLevel + waveOffset + sin(boatX[i] * 0.01 + frameCount * 0.05) * waveHeight - boat.height * boatScale / 2;
    
    // Draw the boat at its current position with scaling
    image(boat, boatX[i], boatY[i], boat.width * boatScale, boat.height * boatScale);
  }
}
