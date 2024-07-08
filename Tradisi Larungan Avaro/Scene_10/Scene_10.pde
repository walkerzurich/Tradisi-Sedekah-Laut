float[] whiteSandX;
float[] whiteSandY;
float[] whiteSandSpeed;

int numClouds = 5; // Number of clouds
float[] cloudX = new float[numClouds];
float[] cloudY = new float[numClouds];
float cloudSpeed = 2; // Increased cloud movement speed

PImage kapal; // Ship image

void setup() {
  size(1920, 1080);

  // Load the ship image
  kapal = loadImage("Sesajen Perahu.png");

  // Initialize cloud positions
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] = width + i * 300 + random(100, 300); // Initial random offset and spacing
    cloudY[i] = random(50, height / 3); // Fixed vertical position within the sky area
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
  background(135, 206, 235); // Sky blue background

  // Draw the sea
  fill(0, 191, 255);
  rect(0, height / 2, width, height / 2);
  
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
  fill(255, 255, 200);
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
  
  // Draw moving clouds
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] -= cloudSpeed;
    if (cloudX[i] < -200) {
      cloudX[i] = width + random(100, 300);
    }
    drawCloud(cloudX[i], cloudY[i], 100);
  }
  
  // Draw the ship on the beach
  drawKapal();
}

void drawCloud(float x, float y, float size) {
  fill(255); // White color for clouds
  noStroke();
  // Draw main cloud body
  ellipse(x, y, size, size);
  // Draw left side
  ellipse(x - size * 0.6, y, size * 0.6, size * 0.6);
  // Draw right side
  ellipse(x + size * 0.6, y, size * 0.6, size * 0.6);
  // Draw top left side
  ellipse(x - size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
  // Draw top right side
  ellipse(x + size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
}

void drawKapal() {
  float kapalWidth = 900; // Adjusted the width of the ship
  float kapalHeight = 600; // Adjusted the height of the ship
  
  // Set the vertical position of the ship on the beach
  float x = width / 2;
  float y = height / 1.5 - kapalHeight / 2;
  
  // Display the ship on the beach
  image(kapal, x - kapalWidth / 2, y, kapalWidth, kapalHeight);
}
