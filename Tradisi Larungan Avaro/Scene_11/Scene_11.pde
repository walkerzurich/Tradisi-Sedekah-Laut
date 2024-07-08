int t = 0;
float boatY;

void setup() {
  size(1920, 1080);
  boatY = height + 150; // Initialize the boat's starting Y position below the canvas
}

void draw() {
  background(220, 200, 150);

  // Draw the animated waves
  stroke(170, 150, 100);
  int delay = 50;
  for (int x = 0; x < width; x++) {
    line(x, 0, x, 6 * 50 - 50 + (float)Math.sin((t - delay) % 200 / 100.0 * Math.PI) * 50 + noise(x / 100f + 6 * 1000, (t - delay) / 100f) * 100);
  }

  for (int i = 6; i > 0; i--) {
    for (int x = 0; x < width; x++) {
      stroke(155 - (5 - i) * 30, 205 - (5 - i) * 20, 205);
      line(x, 0, x, i * 50 - 50 + (float)Math.sin(t % 200 / 100.0 * Math.PI) * 50 + noise(x / 100f + i * 1000, t / 100f) * 100);
    }
  }

  t += 15; // Increase t by 15 instead of 1 to speed up the wave movement

  // Draw the boat at the current position
  drawBoat(width / 2, boatY);

  // Move the boat slowly upward
  boatY -= 5; // Adjust this value to change the speed of the upward movement
}

void drawBoat(float cx, float cy) {
  float[][] points = {
    {1449, 639.718}, {1485.75, 566}, {1518, 639.718}, {1518, 951.141}, {1485.75, 988}, {1449, 951.141},
    {1187, 639.718}, {1223.75, 566}, {1256, 639.718}, {1256, 951.141}, {1223.75, 988}, {1187, 951.141},
    {925, 639.718}, {961.75, 566}, {994, 639.718}, {994, 951.141}, {961.75, 988}, {925, 951.141},
    {663, 639.718}, {699.75, 566}, {732, 639.718}, {732, 951.141}, {699.75, 988}, {663, 951.141},
    {401, 639.718}, {437.75, 566}, {470, 639.718}, {470, 951.141}, {437.75, 988}, {401, 951.141}
  };

  // Scale the points to fit within the new canvas size
  for (int i = 0; i < points.length; i++) {
    points[i][0] = map(points[i][0], 0, 1920, 0, width);
    points[i][1] = map(points[i][1], 0, 1080, 0, height);
  }

  // Draw the paths with black stroke
  for (int i = 0; i < points.length; i += 6) {
    fill(0xFFBBAD7A);
    stroke(0);
    strokeWeight(1);
    beginShape();
    vertex(points[i][0], points[i][1] - (951.141 - cy));
    vertex(points[i + 1][0], points[i + 1][1] - (951.141 - cy));
    vertex(points[i + 2][0], points[i + 2][1] - (951.141 - cy));
    vertex(points[i + 2][0], points[i + 3][1] - (951.141 - cy));
    vertex(points[i + 1][0], points[i + 4][1] - (951.141 - cy));
    vertex(points[i][0], points[i + 5][1] - (951.141 - cy));
    endShape(CLOSE);
  }

  // Draw the gray rectangles with black stroke
  fill(0xFFD9D9D9);
  stroke(0);
  float[] rectX = {1468, 1206, 944, 682, 420};
  for (int i = 0; i < rectX.length; i++) {
    float x = map(rectX[i], 0, 1920, 0, width);
    float y = map(829, 0, 1080, 0, height);
    float w = map(29, 0, 1920, 0, width);
    float h = map(113, 0, 1080, 0, height);
    drawRoundRect(x, y - (951.141 - cy), w, h, 14.5);
  }

  // Draw the ellipses and circles
  fill(0xFFBA2525);
  noStroke();
  float[] ellipseX = {1482.5, 1220.5, 958.5, 696.5, 434.5};
  for (int i = 0; i < ellipseX.length; i++) {
    float x = map(ellipseX[i], 0, 1920, 0, width);
    float y = map(843, 0, 1080, 0, height);
    ellipse(x, y - (951.141 - cy), map(11, 0, 1920, 0, width), map(10, 0, 1080, 0, height));
  }

  for (int i = 0; i < ellipseX.length; i++) {
    float x = map(ellipseX[i], 0, 1920, 0, width);
    float y = map(859.5, 0, 1080, 0, height);
    ellipse(x, y - (951.141 - cy), map(11, 0, 1920, 0, width), map(11, 0, 1080, 0, height));
  }

  for (int i = 0; i < ellipseX.length; i++) {
    float x = map(ellipseX[i], 0, 1920, 0, width);
    float y = map(876.5, 0, 1080, 0, height);
    ellipse(x, y - (951.141 - cy), map(11, 0, 1920, 0, width), map(11, 0, 1080, 0, height));
  }

  for (int i = 0; i < ellipseX.length; i++) {
    float x = map(ellipseX[i], 0, 1920, 0, width);
    float y = map(893, 0, 1080, 0, height);
    ellipse(x, y - (951.141 - cy), map(11, 0, 1920, 0, width), map(10, 0, 1080, 0, height));
  }

  for (int i = 0; i < ellipseX.length; i++) {
    float x = map(ellipseX[i], 0, 1920, 0, width);
    float y = map(909.5, 0, 1080, 0, height);
    ellipse(x, y - (951.141 - cy), map(11, 0, 1920, 0, width), map(11, 0, 1080, 0, height));
  }
}

void drawRoundRect(float x, float y, float w, float h, float r) {
  beginShape();
  vertex(x + r, y);
  vertex(x + w - r, y);
  bezierVertex(x + w, y, x + w, y + r, x + w, y + r);
  vertex(x + w, y + h - r);
  bezierVertex(x + w, y + h, x + w - r, y + h, x + w - r, y + h);
  vertex(x + r, y + h);
  bezierVertex(x, y + h, x, y + h - r, x, y + h - r);
  vertex(x, y + r);
  bezierVertex(x, y, x + r, y, x + r, y);
  endShape(CLOSE);
}
