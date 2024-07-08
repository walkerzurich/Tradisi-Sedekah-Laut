Cloud[] clouds; // Array untuk menyimpan objek awan
int numClouds = 8; // Jumlah awan yang ingin ditampilkan

void setup() {
  size(1920, 1080);
  background(135, 206, 235); // Warna langit
  
  // Inisialisasi array clouds
  clouds = new Cloud[numClouds];
  for (int i = 0; i < numClouds; i++) {
    float x = random(width); // Posisi awan acak di sepanjang lebar layar
    float y = random(100, height / 3); // Posisi awan acak di atas setengah layar
    float size = random(150, 250); // Ukuran awan acak antara 100 dan 200
    float speed = random(0.5, 1.5); // Kecepatan gerak awan acak antara 1 dan 3
    clouds[i] = new Cloud(x, y, size, speed);
  }
}

void draw() {
  // Redraw background setiap frame untuk menghindari tumpang tindih gambar
  background(135, 206, 235);
  
  // Perbarui dan tampilkan objek awan
  for (Cloud cloud : clouds) {
    cloud.update();
    cloud.display();
  }
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
      y = random(100, height / 2); // Posisi vertikal acak di atas setengah layar
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
  
