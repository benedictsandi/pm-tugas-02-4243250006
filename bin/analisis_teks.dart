import 'dart:io';

void main() {
  print('========================================');
  print('          PROGRAM ANALISIS TEKS');
  print('         Pemrograman Mobile - Dart');
  print('========================================');

  stdout.write('Masukkan kalimat: ');
  final String teks = (stdin.readLineSync() ?? '').trim();

  if (teks.isEmpty) {
    print('Kalimat kosong.');
    return;
  }

  // Mengubah kalimat menjadi huruf kecil
  final String kecil = teks.toLowerCase();

  // Memisahkan kalimat menjadi daftar kata
  final List<String> kata = kecil
      .split(RegExp(r'[^a-z0-9]+'))
      .where((k) => k.isNotEmpty)
      .toList();

  // Menghitung jumlah huruf vokal
  final int vokal = kecil.split('').where((c) => 'aiueo'.contains(c)).length;

  // Membalik urutan karakter
  final String terbalik = teks.split('').reversed.join();

  // Memeriksa apakah kalimat merupakan palindrom
  final String huruf = kata.join();
  final bool palindrom = huruf == huruf.split('').reversed.join();

  // Menghitung frekuensi kemunculan kata
  final Map<String, int> frekuensi = {};

  for (final k in kata) {
    frekuensi[k] = (frekuensi[k] ?? 0) + 1;
  }

  // Tantangan tambahan: mencari kata terpanjang
  final String kataTerpanjang = kata.isEmpty
      ? ''
      : kata.reduce((a, b) => a.length >= b.length ? a : b);

  print('\n========== HASIL ANALISIS ==========');
  print('Jumlah karakter : ${teks.length}');
  print('Jumlah kata     : ${kata.length}');
  print('Jumlah vokal    : $vokal');
  print('Huruf besar     : ${teks.toUpperCase()}');
  print('Terbalik        : $terbalik');
  print('Palindrom?      : $palindrom');
  print('Kata unik       : ${kata.toSet()}');
  print('Frekuensi kata  : $frekuensi');
  print('Kata terpanjang : $kataTerpanjang');
  print('Panjang kata   : ${kataTerpanjang.length}');
  print('====================================');
}
