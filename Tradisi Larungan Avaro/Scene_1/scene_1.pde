// Variabel untuk posisi dan kecepatan bus
float busPosX = -200;
float busSpeed = 2.0;
boolean isBusMoving = true;

// Deklarasikan variabel untuk menyimpan gambar karakter 1
PImage character1Img;
float lintangX, lintangY, lintangSpeed, lintangTargetX;
boolean lintangMoving = false;

// Deklarasikan variabel untuk menyimpan gambar karakter 2
PImage character2Img;
float vitaX, vitaY, vitaSpeed, vitaTargetX;
boolean vitaMoving = false;

void setup() {
  size(1920, 1080);  // Ukuran canvas
  background(135, 206, 235); // Warna langit
  
  // Gambar awan
  fill(255); // Warna putih untuk awan
  noStroke();
  drawCloud(150, 100, 100);
  drawCloud(300, 150, 80);
  
  // Load gambar karakter dari file PNG
  character1Img = loadImage("Lintang 1.png");
  character2Img = loadImage("Vita 2.png");
  
  // Inisialisasi posisi dan kecepatan awal karakter
  lintangX = width - 10; // Mulai dari luar layar sebelah kanan
  lintangY = height - 300;
  lintangSpeed = 1.5;
  lintangTargetX = width / 2 - 300; // Posisi tengah
  
  vitaX = width + 100; // Mulai dari luar layar sebelah kanan
  vitaY = height - 300;
  vitaSpeed = 1.5;
  vitaTargetX = width / 2 - 150; // Posisi sebelah kanan Lintang
  
  // Posisi awal Vita
  vitaX = width + 100;
  vitaY = height - 300;
}

void draw() {
  // Gambar ulang background untuk menghapus posisi sebelumnya
  background(135, 206, 235);
  
  // Gambar jalan aspal
  drawRoad();
  
  // Skala untuk membuat bus lebih besar
  float busScale = 2.0;
  
  // Menggambar bus pada posisi busPosX, dengan y sedikit lebih rendah agar ban menyentuh jalan
  drawBus(busPosX, 300, busScale);
  
  // Pergerakan bus
  if (isBusMoving) {
    busPosX += busSpeed;  // Gerak maju
  }
  
  // Batasan pergerakan bus (berhenti saat mencapai posisi tertentu)
  if (busPosX >= width / 2 - 400) {
    busPosX = width / 2 - 400;  // Set posisi tepat di tengah-tengah
    isBusMoving = false;  // Berhenti jika sudah mencapai posisi tertentu
    
    // Aktifkan pergerakan karakter setelah bus berhenti
    lintangMoving = true;
    vitaMoving = true;
  }
  
  // Gambar karakter Lintang
  image(character1Img, lintangX, lintangY);
  
  // Jika sedang bergerak, pindahkan karakter Lintang ke posisi tengah
  if (lintangMoving && lintangX > lintangTargetX) {
    lintangX -= lintangSpeed;
  }
  
  // Gambar karakter Vita
  image(character2Img, vitaX, vitaY);
  
  // Jika sedang bergerak, pindahkan karakter Vita ke posisi sebelah Lintang
  if (vitaMoving && vitaX > vitaTargetX) {
    vitaX -= vitaSpeed;
  }
  
  // Perbarui posisi karakter Vita dan Lintang agar tetap di atas jalan aspal
  constrainCharacters();
  
  // Gambar awan
  fill(255); // Warna putih untuk awan
  noStroke();
  drawCloud(150, 100, 100);
  drawCloud(300, 150, 80);
}

// Fungsi untuk menggambar bus
void drawBus(float x, float y, float scale) {
  // Warna bodi bus
  fill(255, 204, 0);
  // Gambar bodi bus
  rect(x * scale, y * scale, 600 * scale, 150 * scale);
  
  // Warna jendela
  fill(0, 150, 255);
  // Gambar jendela
  rect((x + 30) * scale, (y + 20) * scale, 100 * scale, 60 * scale);  // Jendela pertama
  rect((x + 180) * scale, (y + 20) * scale, 100 * scale, 60 * scale); // Jendela kedua
  rect((x + 330) * scale, (y + 20) * scale, 100 * scale, 60 * scale); // Jendela ketiga
  rect((x + 480) * scale, (y + 20) * scale, 100 * scale, 60 * scale); // Jendela keempat
  
  // Warna roda
  fill(0);
  // Gambar roda
  ellipse((x + 100) * scale, (y + 170) * scale, 80 * scale, 80 * scale);
  ellipse((x + 500) * scale, (y + 170) * scale, 80 * scale, 80 * scale);
  
  // Warna pintu
  fill(150);
  // Gambar pintu
  rect((x + 560) * scale, (y + 30) * scale, 50 * scale, 100 * scale);
}

// Fungsi untuk menggambar awan
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

// Fungsi untuk menggambar jalan aspal
void drawRoad() {
  fill(50); // Warna abu-abu untuk jalan aspal
  rect(0, height - 200, width, 200); // Menggambar jalan aspal di bagian bawah layar
}

// Fungsi untuk memastikan karakter Vita dan Lintang tetap di atas jalan aspal
void constrainCharacters() {
  // Batasan posisi karakter Lintang di atas jalan aspal
  if (lintangY > height - 200 - 300) {
    lintangY = height - 200 - 300;
  }
  
  // Batasan posisi karakter Vita di atas jalan aspal
  if (vitaY > height - 200 - 300) {
    vitaY = height - 200 - 300;
  }
}
