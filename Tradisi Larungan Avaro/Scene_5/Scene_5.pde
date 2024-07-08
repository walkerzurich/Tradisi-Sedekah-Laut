Cloud[] clouds; // Array untuk menyimpan objek awan
int numClouds = 10; // Jumlah awan yang ingin ditampilkan
float seaLevel;
float waveHeight;
float waveSpeed;
PImage character1Img; // Deklarasikan variabel untuk menyimpan gambar karakter 1
PImage character2Img; // Deklarasikan variabel untuk menyimpan gambar karakter 2
PImage character3Img; // Deklarasikan variabel untuk menyimpan gambar karakter 3

float vitaX, vitaY, vitaTargetX, vitaTargetY, vitaSpeed;
float lintangX, lintangY, lintangTargetX, lintangTargetY, lintangSpeed;

void setup() {
  size(1920, 1080);
  background(135, 206, 235); // Warna langit

  seaLevel = height * 0.5; // Posisi level laut
  waveHeight = 20; // Tinggi gelombang laut
  waveSpeed = 0.01; // Kecepatan animasi gelombang

  // Load gambar karakter dari file PNG
  character1Img = loadImage("Pak Watino.png");
  character2Img = loadImage("Lintang 1.png");
  character3Img = loadImage("Vita 2.png");

  // Inisialisasi array clouds
  clouds = new Cloud[numClouds];
  for (int i = 0; i < numClouds; i++) {
    float x = random(width); // Posisi awan acak di sepanjang lebar layar
    float y = random(100, height / 4); // Posisi awan acak di atas setengah layar
    float size = random(100, 200); // Ukuran awan acak antara 100 dan 200
    float speed = random(1, 3); // Kecepatan gerak awan acak antara 1 dan 3
    clouds[i] = new Cloud(x, y, size, speed);
  }

  // Inisialisasi posisi dan target karakter
  vitaX = width/2 + 1300;
  vitaY = seaLevel - 100;
  vitaTargetX = width/2 + 50;
  vitaTargetY = seaLevel - 200;
  vitaSpeed = 1; // Kecepatan gerak karakter Vita

  lintangX = width/2 - 1300;
  lintangY = seaLevel - 150;
  lintangTargetX = width/2 - 300;
  lintangTargetY = seaLevel - 200;
  lintangSpeed = 1; // Kecepatan gerak karakter Lintang
}

void draw() {
  // Redraw background setiap frame untuk menghindari tumpang tindih gambar
  background(135, 206, 235);
  
  // Gambar laut dan pasir
  drawBeach();
  
  // Perbarui dan tampilkan objek awan
  for (Cloud cloud : clouds) {
    cloud.update();
    cloud.display();
  }
  
  // Gambar pohon di kanan dan kiri layar
  drawTree(150, seaLevel * 1.3, 20, 20, 170, seaLevel * 1.3 - 150); // Kiri
  drawTree(width - 150, seaLevel * 1.3, 20, 20, width - 130, seaLevel * 1.3 - 150);
  
  // Menampilkan karakter pertama di posisi tetap
  image(character1Img, width/2 - 200, seaLevel - 200);
  
  // Update posisi karakter kedua (Lintang)
  lintangX = lerp(lintangX, lintangTargetX, lintangSpeed * 0.01);
  lintangY = lerp(lintangY, lintangTargetY, lintangSpeed * 0.01);
  image(character2Img, lintangX, lintangY, character2Img.width * 0.8, character2Img.height * 0.8);
  
  // Update posisi karakter ketiga (Vita)
  vitaX = lerp(vitaX, vitaTargetX, vitaSpeed * 0.01);
  vitaY = lerp(vitaY, vitaTargetY, vitaSpeed * 0.01);
  image(character3Img, vitaX, vitaY);
}

void drawBeach() {
  // Gambar laut
  drawSeaWaves();
  
  // Gambar pasir
  fill(255, 223, 186); // Warna pasir
  noStroke();
  rect(0, seaLevel * 1.3, width, height - seaLevel * 1.3); // Menggambar pasir dari seaLevel ke bawah
}

void drawSeaWaves() {
  // Hitung pergerakan gelombang berdasarkan frameCount
  float waveOffset = sin(frameCount * waveSpeed) * waveHeight;
  
  // Gambar gelombang laut
  fill(100, 149, 237); // Warna biru langit dalam
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

// Kelas Cloud untuk merepresentasikan setiap awan
class Cloud {
  float x, y;
  float size;
  float speed;

  // Konstruktor untuk inisialisasi awan
  Cloud(float x, float y, float size, float speed) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
  }

  // Method untuk memperbarui posisi awan
  void update() {
    x -= speed; // Gerakkan awan ke kiri berdasarkan kecepatan
    if (x < -size) { // Jika awan keluar dari layar sebelah kiri, reset posisi ke sebelah kanan layar
      x = width + random(100, 300); // Posisi baru di sebelah kanan layar dengan jarak acak
      y = random(100, height / 4); // Posisi vertikal acak di atas setengah layar
    }
  }

  // Method untuk menampilkan awan
  void display() {
    fill(255); // Warna putih untuk awan
    noStroke();
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
}

// Fungsi untuk menggambar pohon
void drawTree(int palmX, float palmY, int palmW, int palmH, int leafX, float leafY) {
  fill(158, 107, 17);
  for (int i = 0; i < 15; i++) {
    ellipse(palmX + i * 2, palmY - i * 10, palmW, palmH);
  }

  fill(0, 255, 0);
  // Pindahkan bagian ini di atas penggambaran batang
  triangle(leafX, leafY, leafX - 10, leafY - 10, leafX - 60, leafY + 60);
  triangle(leafX + 5, leafY - 10, leafX - 10, leafY - 10, leafX - 40, leafY + 60);
  triangle(leafX + 10, leafY - 5, leafX - 10, leafY - 10, leafX - 20, leafY + 60);
  triangle(leafX + 15, leafY, leafX - 10, leafY - 10, leafX, leafY + 60);
  triangle(leafX + 20, leafY + 5, leafX - 10, leafY - 10, leafX + 20, leafY + 60);
  triangle(leafX + 25, leafY + 10, leafX - 10, leafY - 10, leafX + 40, leafY + 60);
  triangle(leafX + 30, leafY + 15, leafX - 10, leafY - 10, leafX + 60, leafY + 60);
  triangle(leafX + 35, leafY + 20, leafX - 10, leafY - 10, leafX + 80, leafY + 60);
}
