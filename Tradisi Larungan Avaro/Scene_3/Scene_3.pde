float[] whiteSandX;
float[] whiteSandY;
float[] whiteSandSpeed;

void setup() {
  size(800, 600);
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
  
  // Draw clouds
  fill(255); // Warna putih untuk awan
  noStroke();
  drawCloud(150, 100, 100);
  drawCloud(300, 150, 80);
}

void drawCloud(float x, float y, float size) {
  // Gambar bagian tengah awan
  ellipse(x, y, size, size);
  
  // Gambar sisi kiri awan
  ellipse(x - size * 0.6, y, size * 0.6, size * 0.6);
  
  // Gambar sisi kanan awan
  ellipse(x + size * 0.6, y, size * 0.6, size * 0.6);
  
  // Gambar sisi atas kiri awan
  ellipse(x - size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
  
  // Gambar sisi atas kanan awan
  ellipse(x + size * 0.3, y - size * 0.4, size * 0.6, size * 0.6);
}
