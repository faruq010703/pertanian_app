import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Pertanian'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TipsSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Plant Care Tips
            _buildSectionTitle('Cara Merawat Tanaman'),
            _buildTipCard(
              context,
              'Penyiraman yang Tepat',
              Icons.water_drop,
              Colors.blue,
              'Siram tanaman di pagi atau sore hari. Hindari menyiram daun secara langsung untuk mencegah jamur.',
            ),
            _buildTipCard(
              context,
              'Pemupukan Berkala',
              Icons.grass,
              Colors.green,
              'Gunakan pupuk organik setiap 2 minggu. Untuk tanaman buah, gunakan pupuk tinggi fosfor saat berbunga.',
            ),
            _buildTipCard(
              context,
              'Pencahayaan Optimal',
              Icons.light_mode,
              Colors.amber,
              'Kenali kebutuhan cahaya tanaman. Tanaman hias umumnya butuh cahaya tidak langsung, sementara sayuran butuh sinar matahari penuh.',
            ),

            // Section 2: Enhanced Disease Detection
            const SizedBox(height: 24),
            _buildSectionTitle('Deteksi Penyakit Tanaman'),
            _buildDiseaseCard(
              context,
              'Daun Menguning',
              Icons.warning,
              Colors.amber,
              [
                'Gejala: Daun menguning, pertumbuhan terhambat',
                'Penyebab: Kekurangan nitrogen, overwatering, atau jamur',
                'Solusi: Periksa kelembaban tanah, beri pupuk nitrogen',
                'Pencegahan: Jaga drainase tanah, rotasi tanaman'
              ],
            ),
            _buildDiseaseCard(
              context,
              'Bercak Hitam pada Daun',
              Icons.bug_report,
              Colors.red,
              [
                'Gejala: Bercak hitam/coklat dengan pinggiran kuning',
                'Penyebab: Jamur antraknosa atau bakteri',
                'Solusi: Potong daun terinfeksi, semprot fungisida alami',
                'Pencegahan: Hindari penyiraman dari atas, jaga sirkulasi udara'
              ],
            ),
            _buildDiseaseCard(
              context,
              'Tanaman Layu',
              Icons.sick,
              Colors.brown,
              [
                'Gejala: Tanaman layu meski tanah cukup air',
                'Penyebab: Akar busuk atau penyakit layu fusarium',
                'Solusi: Periksa akar, ganti media tanam jika busuk',
                'Pencegahan: Gunakan media tanam steril, jangan overwatering'
              ],
            ),

            // Section 3: Land Maintenance
            const SizedBox(height: 24),
            _buildSectionTitle('Perawatan Lahan'),
            _buildLandTipCard(
              context,
              'Rotasi Tanaman',
              Icons.autorenew,
              'Berganti jenis tanaman setiap musim untuk menjaga kesuburan tanah dan mengurangi hama.',
            ),
            _buildLandTipCard(
              context,
              'Pengolahan Tanah',
              Icons.agriculture,
              'Gemburkan tanah sebelum menanam dan tambahkan kompos untuk meningkatkan aerasi dan nutrisi.',
            ),
            _buildLandTipCard(
              context,
              'Pengendalian Gulma',
              Icons.forest,
              'Cabut gulma secara rutin atau gunakan mulsa organik untuk menekan pertumbuhannya.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(BuildContext context, String title, IconData icon, Color color, List<String> details) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiseaseDetailScreen(
                title: title,
                icon: icon,
                color: color,
                details: details,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Disease details summary
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details[0],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details[1],
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Ketuk untuk detail',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 16, color: Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandTipCard(BuildContext context, String title, IconData icon, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TipDetailScreen(
                title: title,
                description: description,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiseaseDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> details;

  const DiseaseDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 30),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Disease details
            _buildDetailSection('Gejala', details[0].replaceFirst('Gejala: ', '')),
            _buildDetailSection('Penyebab', details[1].replaceFirst('Penyebab: ', '')),
            _buildDetailSection('Solusi', details[2].replaceFirst('Solusi: ', '')),
            _buildDetailSection('Pencegahan', details[3].replaceFirst('Pencegahan: ', '')),

            const SizedBox(height: 24),
            _buildTreatmentSteps(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ditambahkan ke favorit')),
          );
        },
        child: const Icon(Icons.favorite_border),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }

  Widget _buildTreatmentSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Langkah Penanganan:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        _buildStep('1. Isolasi tanaman yang terinfeksi'),
        _buildStep('2. Potong bagian yang terinfeksi dengan alat steril'),
        _buildStep('3. Aplikasikan pengobatan sesuai penyebab'),
        _buildStep('4. Pantau perkembangan selama 1-2 minggu'),
        _buildStep('5. Cegah penyebaran ke tanaman lain'),
      ],
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class TipDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  const TipDetailScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Langkah-langkah:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            _buildStep('1. Siapkan alat dan bahan yang diperlukan'),
            _buildStep('2. Lakukan pengamatan kondisi tanaman/lahan'),
            _buildStep('3. Terapkan solusi sesuai petunjuk'),
            _buildStep('4. Pantau perkembangan secara berkala'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Simpan ke Favorit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class TipsSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Center(
      child: Text('Hasil pencarian untuk "$query"'),
    );
  }
}