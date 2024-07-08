int t = 0;
float circleX = -50; // Posisi awal lingkaran di luar layar bagian kiri
float circleY = 360; // Posisi vertikal lingkaran (tengah layar secara horizontal)
float circleSpeed = 2; // Kecepatan gerak lingkaran

void setup() {
  size(1920, 1080);
}

void draw() {
  background(220, 200, 150);
  
  // Rotasi canvas 90 derajat ke kiri
  translate(0, height);
  rotate(-HALF_PI);
  
  stroke(170, 150, 100);
  int delay = 50;
  for (int x = 0; x < height; x++) {
    line(x, 0, x, 6 * 50 - 50 + (float)Math.sin((t - delay) % 200 / 100.0 * Math.PI) * 50 + noise(x / 100f + 6 * 1000, (t - delay) / 100f) * 100);
  }
  
  for (int i = 6; i > 0; i--) {
    for (int x = 0; x < height; x++) {
      stroke(155 - (5 - i) * 30, 205 - (5 - i) * 20, 205);
      line(x, 0, x, i * 50 - 50 + (float)Math.sin(t % 200 / 100.0 * Math.PI) * 50 + noise(x / 100f + i * 1000, t / 100f) * 100);
    }
  }
   
  t += 1; // Increase t by 5 instead of 1 to speed up the wave movement
}

float wave(int x) {
  return Math.max(Math.max((float)Math.sin(x), (float)Math.sin(x / 2f)), Math.min(1, (float)Math.sin(x) - (float)Math.cos(x)));
}
