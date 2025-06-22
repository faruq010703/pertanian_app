import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String namaPengguna = 'Agus Setiawan';
  String peranPengguna = 'Petani Cabai Organik';
  String lokasiPengguna = 'Jawa Barat, Indonesia';
  String jenisUsaha = 'Budidaya Cabai Organik';
  String luasLahan = '2 Hektar';
  String tanggalBergabung = 'Januari 2022';
  String bioPengguna = 'Petani cabai organik dengan sistem irigasi tetes modern. Fokus pada pertanian berkelanjutan.';
  String jenisKelamin = 'Perempuan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Petani'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buatHeaderProfil(),
            const SizedBox(height: 24),
            _buatBagianInfoPengguna(),
            const SizedBox(height: 24),
            _buatBagianFiturPertanian(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tampilkanDialogEditProfil,
        child: const Icon(Icons.edit),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buatHeaderProfil() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Icon(
            jenisKelamin == 'Perempuan' ? Icons.female : Icons.male,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: jenisKelamin == 'Perempuan' ? Colors.pink : Colors.blue,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaPengguna,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              peranPengguna,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  jenisKelamin == 'Perempuan' ? Icons.female : Icons.male,
                  size: 16,
                  color: jenisKelamin == 'Perempuan' ? Colors.pink : Colors.blue,
                ),
                const SizedBox(width: 4),
                Text(lokasiPengguna),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _tampilkanDialogEditProfil() {
    final namaController = TextEditingController(text: namaPengguna);
    final peranController = TextEditingController(text: peranPengguna);
    final lokasiController = TextEditingController(text: lokasiPengguna);
    final usahaController = TextEditingController(text: jenisUsaha);
    final lahanController = TextEditingController(text: luasLahan);
    final bergabungController = TextEditingController(text: tanggalBergabung);
    final bioController = TextEditingController(text: bioPengguna);
    String? jenisKelaminTerpilih = jenisKelamin;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              TextField(
                controller: peranController,
                decoration: const InputDecoration(labelText: 'Peran/Pekerjaan'),
              ),
              TextField(
                controller: lokasiController,
                decoration: const InputDecoration(labelText: 'Lokasi'),
              ),
              TextField(
                controller: usahaController,
                decoration: const InputDecoration(labelText: 'Jenis Usaha'),
              ),
              TextField(
                controller: lahanController,
                decoration: const InputDecoration(labelText: 'Luas Lahan'),
              ),
              TextField(
                controller: bergabungController,
                decoration: const InputDecoration(labelText: 'Tanggal Bergabung'),
              ),
              DropdownButtonFormField<String>(
                value: jenisKelaminTerpilih,
                items: ['Laki-laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  jenisKelaminTerpilih = newValue;
                },
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              TextField(
                controller: bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                namaPengguna = namaController.text;
                peranPengguna = peranController.text;
                lokasiPengguna = lokasiController.text;
                jenisUsaha = usahaController.text;
                luasLahan = lahanController.text;
                tanggalBergabung = bergabungController.text;
                bioPengguna = bioController.text;
                jenisKelamin = jenisKelaminTerpilih ?? jenisKelamin;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil berhasil diperbarui')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buatBagianInfoPengguna() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Usaha Tani',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buatItemInfo(Icons.person, 'Nama Lengkap', namaPengguna),
        _buatItemInfo(Icons.work, 'Peran/Pekerjaan', peranPengguna),
        _buatItemInfo(Icons.location_on, 'Lokasi', lokasiPengguna),
        _buatItemInfo(Icons.agriculture, 'Jenis Usaha', jenisUsaha),
        _buatItemInfo(Icons.landscape, 'Luas Lahan', luasLahan),
        _buatItemInfo(Icons.calendar_today, 'Bergabung Sejak', tanggalBergabung),
        _buatItemInfo(
          jenisKelamin == 'Perempuan' ? Icons.female : Icons.male,
          'Jenis Kelamin', 
          jenisKelamin
        ),
        _buatItemInfo(Icons.description, 'Deskripsi', bioPengguna),
      ],
    );
  }

  Widget _buatItemInfo(IconData ikon, String judul, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ikon, 
            size: 20, 
            color: ikon == Icons.female 
              ? Colors.pink 
              : ikon == Icons.male 
                ? Colors.blue 
                : Colors.green[700],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  nilai,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatBagianFiturPertanian() {
    final List<Map<String, dynamic>> fitur = [
      {
        'ikon': Icons.wb_sunny,
        'judul': 'Monitoring Iklim',
        'detail': 'Suhu: 28°C\nKelembaban: 75%',
      },
      {
        'ikon': Icons.calendar_month,
        'judul': 'Kalender Tanam',
        'detail': 'Tanam: 5 Jun\nPanen: 15 Ags',
      },
      {
        'ikon': Icons.attach_money,
        'judul': 'Catatan Keuangan',
        'detail': 'Pendapatan: Rp12.5jt\nPengeluaran: Rp8.2jt',
      },
      {
        'ikon': Icons.insights,
        'judul': 'Analisis Tanah',
        'detail': 'pH: 6.2\nNitrogen: Sedang',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur Pertanian',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: fitur.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(fitur[index]['ikon'], size: 24, color: Colors.green[700]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fitur[index]['judul'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          fitur[index]['detail'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}