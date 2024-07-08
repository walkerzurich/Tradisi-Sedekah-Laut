PImage character1; // Deklarasi variabel untuk gambar karakter 1 (Lintang)
PImage character2; // Deklarasi variabel untuk gambar karakter 2 (Vita)
PImage currentCharacter; // Deklarasi variabel untuk gambar karakter saat ini

// Deklarasi variabel untuk gelombang laut
float tinggiGelombang = 7; // Tinggi gelombang
float kecepatanGelombang = 0.01; // Kecepatan gelombang
float offsetGelombang = 0; // Offset gelombang

// Deklarasi variabel untuk awan
float[] awanX;
float[] awanY;
float[] kecepatanAwan;

// Variabel untuk posisi karakter Lintang dan Vita
float lintangX;
float vitaX;

void setup() {
  size(1920, 1080);
  
  // Load gambar karakter 1 (Lintang) dan karakter 2 (Vita) dari file PNG di folder 'data'
  character1 = loadImage("Lintang 1.png");
  character2 = loadImage("Vita 2.png");
  
  // Inisialisasi gambar karakter saat ini
  currentCharacter = character1; // Mulai dengan karakter 1 (Lintang)
  
  // Inisialisasi awan-awan
  awanX = new float[5]; // Menambahkan 5 awan
  awanY = new float[5]; // Menambahkan 5 awan
  kecepatanAwan = new float[5]; // Menambahkan 5 awan
  for (int i = 0; i < awanX.length; i++) {
    awanX[i] = random(width, width + 300);  // Mulai dari luar layar sebelah kanan
    awanY[i] = random(50, 200);
    kecepatanAwan[i] = random(1, 2);
  }
  
  // Inisialisasi posisi awal karakter di luar layar sebelah kiri
  lintangX = -100; // Posisi awal di luar layar sebelah kiri
  vitaX = -200; // Posisi awal di luar layar sebelah kiri
}

void draw() {
  background(135, 206, 235); // Latar belakang biru langit

  // Gambar laut dengan gelombang
  fill(0, 191, 255);
  beginShape();
  vertex(0, height / 2);
  for (int x = 0; x <= width; x += 20) {
    float y = height / 2 + sin(x * kecepatanGelombang + offsetGelombang) * tinggiGelombang;
    vertex(x, y);
  }
  vertex(width, height / 2);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  // Gambar pantai
  fill(255, 255, 200);
  rect(0, height / 1.5, width, height / 3);
  
  // Gambar batang pohon kelapa
  fill(139, 69, 19);
  beginShape();
  vertex(100, height / 1.5);
  vertex(120, height / 1.5);
  vertex(140, height / 3);
  vertex(160, height / 3);
  vertex(140, height / 1.5);
  vertex(120, height / 1.5);
  endShape(CLOSE);
  
  // Gambar daun pohon kelapa
  fill(34, 139, 34);
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    translate(150, height / 3);
    rotate(PI / 3 * i);
    ellipse(0, 0, 120, 40);
    popMatrix();
  }
  
  // Gambar kelapa
  fill(139, 69, 19);
  ellipse(150, height / 3, 20, 20);
  ellipse(160, height / 3 + 10, 20, 20);
  ellipse(140, height / 3 + 10, 20, 20);
  
  // Perbarui offset gelombang untuk animasi
  offsetGelombang += 0.02;
  
  // Gambar dan animasikan awan-awan
  fill(255); // Warna putih untuk awan
  noStroke();
  for (int i = 0; i < awanX.length; i++) {
    gambarAwan(awanX[i], awanY[i], 100); // Menggambar awan dengan ukuran 100
    awanX[i] -= kecepatanAwan[i]; // Bergerak ke kiri
    if (awanX[i] < -300) { // Jika sudah keluar layar kiri
      awanX[i] = width + 300; // Mulai kembali dari kanan layar
      awanY[i] = random(50, 200); // Posisi vertikal diacak ulang
      kecepatanAwan[i] = random(1, 2); // Kecepatan diacak ulang
    }
  }
  
  // Gambar karakter Lintang di tengah pantai dengan penyesuaian posisi dan skala
  float scaleLintang = 0.3; // Skala Lintang
  float lintangY = height / 1.5 - character1.height * scaleLintang + 30;
  image(character1, lintangX, lintangY, character1.width * scaleLintang, character1.height * scaleLintang);
  
  // Gambar karakter Vita di tengah pantai dengan penyesuaian posisi dan skala
  float scaleVita = 0.4; // Skala Vita
  float vitaY = height / 1.5 - character2.height * scaleVita + 50;
  image(character2, vitaX, vitaY, character2.width * scaleVita, character2.height * scaleVita);
  
  // Animasi pergerakan karakter Lintang dan Vita dari kiri ke kanan
  lintangX += 1.25; // Kecepatan Lintang
  vitaX += 1.25; // Kecepatan Vita
  
  // Jika karakter Lintang keluar layar kanan, kembalikan ke posisi awal di luar layar kiri
  if (lintangX > width) {
    
  }
  
  // Jika karakter Vita keluar layar kanan, kembalikan ke posisi awal di luar layar kiri
  if (vitaX > width) {
    
  }
}

void gambarAwan(float x, float y, float size) {
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

void mousePressed() {
  if (currentCharacter == character1) {
    currentCharacter = character2;
  } else {
    currentCharacter = character1;
  }
}
