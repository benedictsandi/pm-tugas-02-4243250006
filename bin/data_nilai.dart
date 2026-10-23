void main() {
  // Data mahasiswa menggunakan List of Record
  final List<({String nama, int nilai})> kelas = [
    (nama: 'Andi', nilai: 85),
    (nama: 'Butet', nilai: 72),
    (nama: 'Citra', nilai: 58),
    (nama: 'Dimas', nilai: 91),
    (nama: 'Elisa', nilai: 66),

    // Tantangan 1: menambahkan dua mahasiswa
    (nama: 'Benedict', nilai: 95),
    (nama: 'Micael', nilai: 78),
  ];

  // Konversi nilai angka ke nilai huruf
  String huruf(int n) => n >= 85
      ? 'A'
      : n >= 70
      ? 'B'
      : n >= 60
      ? 'C'
      : n >= 50
      ? 'D'
      : 'E';

  print('================================');
  print('       DATA NILAI MAHASISWA');
  print('================================');

  print('${'Nama'.padRight(12)}${'Nilai'.padLeft(6)}  Huruf');
  print('-' * 32);

  for (final m in kelas) {
    final baris = m.nama.padRight(12) + m.nilai.toString().padLeft(6);

    print('$baris  ${huruf(m.nilai)}');
  }

  // Menghitung total dan rata-rata
  final int total = kelas.fold<int>(0, (sum, m) => sum + m.nilai);

  final double rataRata = total / kelas.length;

  // Menentukan mahasiswa yang lulus
  final List<String> lulus = kelas
      .where((m) => m.nilai >= 60)
      .map((m) => m.nama)
      .toList();

  // Mencari nilai tertinggi
  final terbaik = kelas.reduce((a, b) => a.nilai >= b.nilai ? a : b);

  final (:nama, :nilai) = terbaik;

  print('-' * 32);
  print('Jumlah mahasiswa : ${kelas.length}');
  print('Rata-rata kelas  : ${rataRata.toStringAsFixed(1)}');
  print('Lulus (>= 60)    : ${lulus.join(', ')}');
  print('Nilai tertinggi  : $nama ($nilai)');

  // Tantangan 2: distribusi nilai huruf
  final Map<String, int> distribusi = {'A': 0, 'B': 0, 'C': 0, 'D': 0, 'E': 0};

  for (final m in kelas) {
    final kategori = huruf(m.nilai);
    distribusi[kategori] = (distribusi[kategori] ?? 0) + 1;
  }

  print('\n===== DISTRIBUSI NILAI HURUF =====');

  distribusi.forEach((kategori, jumlah) {
    print('Nilai $kategori : $jumlah mahasiswa');
  });

  // Tantangan 3: urutkan berdasarkan nilai tertinggi
  final peringkat = kelas.toList()..sort((a, b) => b.nilai.compareTo(a.nilai));

  print('\n===== PERINGKAT MAHASISWA =====');

  for (var i = 0; i < peringkat.length; i++) {
    final m = peringkat[i];

    print(
      '${i + 1}. ${m.nama.padRight(12)} '
      '- ${m.nilai} (${huruf(m.nilai)})',
    );
  }

  print('================================');
}
