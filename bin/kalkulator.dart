import 'dart:io';
import 'dart:math';

// Mengatur tampilan angka agar bilangan bulat tidak memakai .0
String formatAngka(num angka) {
  if (angka.isFinite && angka == angka.roundToDouble()) {
    return angka.toInt().toString();
  }

  return angka.toString();
}

void main() {
  print('======================================');
  print('         KALKULATOR SEDERHANA');
  print('       Pemrograman Mobile - Dart');
  print('======================================');

  stdout.write('Bilangan pertama              : ');
  final double? a = double.tryParse(stdin.readLineSync() ?? '');

  stdout.write('Operator (+ - * / ~/ % ^)     : ');
  final String op = (stdin.readLineSync() ?? '').trim();

  stdout.write('Bilangan kedua                : ');
  final double? b = double.tryParse(stdin.readLineSync() ?? '');

  // Memastikan kedua input berupa angka yang valid
  if (a == null || b == null || !a.isFinite || !b.isFinite) {
    print('Input bukan angka yang valid.');
    return;
  }

  // Menentukan hasil sesuai operator yang dipilih
  final num? hasil = switch (op) {
    '+' => a + b,
    '-' => a - b,
    '*' => a * b,
    '/' => b == 0 ? null : a / b,
    '~/' => b == 0 ? null : a ~/ b,
    '%' => b == 0 ? null : a % b,
    '^' => pow(a, b),
    _ => null,
  };

  if (hasil == null) {
    print('Operator tidak dikenal atau pembagian dengan nol.');
    return;
  }

  // Memastikan hasil perhitungan dapat ditampilkan
  if (!hasil.isFinite) {
    print('Hasil perhitungan tidak valid atau terlalu besar.');
    return;
  }

  print('--------------------------------------');
  print(
    'Hasil: ${formatAngka(a)} $op ${formatAngka(b)} = ${formatAngka(hasil)}',
  );
  print('======================================');
}
