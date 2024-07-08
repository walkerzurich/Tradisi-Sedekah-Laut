float seaLevel;
float waveHeight;
float waveSpeed;

int numClouds = 5; // Number of clouds
float[] cloudX = new float[numClouds];
float[] cloudY = new float[numClouds]; // Array to hold fixed vertical positions of clouds
float cloudSpeed = 1; // Reduced cloud speed for slower movement

PImage kapal;

void setup() {
  size(1920, 1080);
  seaLevel = height * 0.6; // Adjust sea level position
  waveHeight = 30; // Height of the waves
  waveSpeed = 0.01; // Speed of the wave animation
  
  // Load images
  kapal = loadImage("A.png");
  
  // Initialize cloud positions
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] = width + i * 300 + random(100, 300); // Increased initial random offset and spacing
    cloudY[i] = random(50, seaLevel - 200); // Fixed vertical position within the sky area
  }
}

void draw() {
  background(200, 240, 255); // Light blue background
  
  // Draw sea waves
  drawSeaWaves();
  
  // Draw clouds
  drawClouds();
  
  // Draw kapal
  drawKapal();
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
    fill(255); // White cloud
    noStroke();
    ellipse(cloudX[i], cloudYPos, 100, 60);
    ellipse(cloudX[i] + 30, cloudYPos - 20, 80, 50);
    ellipse(cloudX[i] + 60, cloudYPos, 100, 60);
    ellipse(cloudX[i] + 90, cloudYPos - 20, 80, 50);
  }
}

void drawKapal() {
  float kapalWidth = 900; // Adjust the width to make the kapal 3 times larger
  float kapalHeight = 600; // Adjust the height to make the kapal 3 times larger
  
  // Calculate the vertical position of the kapal based on the wave
  float x = width / 2;
  float waveOffset = sin(frameCount * waveSpeed) * waveHeight;
  float y = seaLevel + waveOffset + sin(x * 0.01 + frameCount * 0.05) * waveHeight - kapalHeight / 2;
  
  // Display kapal on the sea
  image(kapal, x - kapalWidth / 2, y, kapalWidth, kapalHeight);
}
