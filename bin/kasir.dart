import 'dart:io';

// Format nominal rupiah menggunakan pemisah ribuan.
String rupiah(int angka) {
  final teks = angka.toString();
  return teks.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
}

void main() {
  // Katalog menggunakan Map dengan nilai berbentuk Record.
  final Map<String, ({String nama, String kategori, int harga})> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  print('================================================');
  print('           KASIR TOKO OLEH-OLEH MEDAN');
  print('================================================');
  print(
    '${'Kode'.padRight(7)}'
    '${'Nama Produk'.padRight(26)}'
    '${'Harga'.padLeft(15)}',
  );
  print('-' * 48);

  // TODO 1: Menampilkan katalog dalam bentuk tabel.
  katalog.forEach((kode, produk) {
    print(
      '${kode.padRight(7)}'
      '${produk.nama.padRight(26)}'
      '${('Rp${rupiah(produk.harga)}').padLeft(15)}',
    );
  });

  print('-' * 48);

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final String input = stdin.readLineSync() ?? '';

  // Setiap pesanan valid disimpan sebagai Record.
  final List<
    ({String kode, String nama, String kategori, int harga, int jumlah})
  >
  pesanan = [];

  final List<String> ditolak = [];

  // TODO 2: Memisahkan pesanan dengan split dan trim.
  for (final bagian in input.split(',')) {
    final item = bagian.trim();

    final detail = item.toLowerCase().split('x');

    if (detail.length != 2) {
      ditolak.add('$item (format tidak sesuai)');
      continue;
    }

    final kode = detail[0].trim().toUpperCase();
    final jumlah = int.tryParse(detail[1].trim());

    // TODO 3: Validasi kode produk dan jumlah.
    final produk = katalog[kode];

    if (produk == null) {
      ditolak.add('$item (kode produk tidak ditemukan)');
      continue;
    }

    if (jumlah == null || jumlah <= 0) {
      ditolak.add('$item (jumlah tidak valid)');
      continue;
    }

    pesanan.add((
      kode: kode,
      nama: produk.nama,
      kategori: produk.kategori,
      harga: produk.harga,
      jumlah: jumlah,
    ));
  }

  // TODO 4: Menghitung subtotal dengan map dan total dengan fold.
  final subtotal = pesanan.map((item) => item.harga * item.jumlah).toList();

  final total = subtotal.fold<int>(0, (jumlah, nilai) => jumlah + nilai);

  final diskon = total >= 100000 ? total ~/ 10 : 0;
  final bayar = total - diskon;

  // TODO 5: Mengumpulkan kategori produk unik.
  final Set<String> kategoriDibeli = pesanan
      .map((item) => item.kategori)
      .toSet();

  print('\n================ STRUK BELANJA ================');

  if (pesanan.isEmpty) {
    print('Tidak ada pesanan valid.');
  } else {
    for (var i = 0; i < pesanan.length; i++) {
      final item = pesanan[i];

      print('${i + 1}. ${item.nama}');
      print(
        '   ${item.jumlah} x Rp${rupiah(item.harga)}'
        ' = Rp${rupiah(subtotal[i])}',
      );
    }
  }

  print('-' * 48);
  print('Total       : Rp${rupiah(total)}');
  print('Diskon 10%  : Rp${rupiah(diskon)}');
  print('Jumlah bayar: Rp${rupiah(bayar)}');
  print(
    'Kategori    : '
    '${kategoriDibeli.isEmpty ? '-' : kategoriDibeli.join(', ')}',
  );

  if (ditolak.isNotEmpty) {
    print('\nItem yang ditolak:');
    for (final item in ditolak) {
      print('- $item');
    }
  }

  print('================================================');
  print('               TERIMA KASIH');
  print('================================================');
}
