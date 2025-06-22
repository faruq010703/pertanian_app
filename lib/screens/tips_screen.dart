import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tips Pertanian',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TipsScreen(),
    );
  }
}

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final List<Map<String, dynamic>> _favoriteTips = [];

  void _addToFavorites(Map<String, dynamic> tip) {
    setState(() {
      if (!_favoriteTips.any((fav) => fav['title'] == tip['title'])) {
        _favoriteTips.add(tip);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${tip['title']} ditambahkan ke favorit')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${tip['title']} sudah ada di favorit')),
        );
      }
    });
  }

  void _removeFromFavorites(String title) {
    setState(() {
      _favoriteTips.removeWhere((fav) => fav['title'] == title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Pertanian'),
        actions: [
          // Icon pencarian dihapus
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoriteTips: _favoriteTips,
                    onRemove: _removeFromFavorites,
                  ),
                ),
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
              {
                'title': 'Penyiraman yang Tepat',
                'icon': Icons.water_drop,
                'color': Colors.blue,
                'description': 'Siram tanaman di pagi atau sore hari. Hindari menyiram daun secara langsung untuk mencegah jamur.',
              },
              _addToFavorites,
            ),
            _buildTipCard(
              context,
              {
                'title': 'Pemupukan Berkala',
                'icon': Icons.grass,
                'color': Colors.green,
                'description': 'Gunakan pupuk organik setiap 2 minggu. Untuk tanaman buah, gunakan pupuk tinggi fosfor saat berbunga.',
              },
              _addToFavorites,
            ),
            _buildTipCard(
              context,
              {
                'title': 'Pencahayaan Optimal',
                'icon': Icons.light_mode,
                'color': Colors.amber,
                'description': 'Kenali kebutuhan cahaya tanaman. Tanaman hias umumnya butuh cahaya tidak langsung, sementara sayuran butuh sinar matahari penuh.',
              },
              _addToFavorites,
            ),

            // Section 2: Enhanced Disease Detection
            const SizedBox(height: 24),
            _buildSectionTitle('Deteksi Penyakit Tanaman'),
            _buildDiseaseCard(
              context,
              {
                'title': 'Daun Menguning',
                'icon': Icons.warning,
                'color': Colors.amber,
                'details': [
                  'Gejala: Daun menguning, pertumbuhan terhambat',
                  'Penyebab: Kekurangan nitrogen, overwatering, atau jamur',
                  'Solusi: Periksa kelembaban tanah, beri pupuk nitrogen',
                  'Pencegahan: Jaga drainase tanah, rotasi tanaman'
                ],
              },
              _addToFavorites,
            ),
            _buildDiseaseCard(
              context,
              {
                'title': 'Bercak Hitam pada Daun',
                'icon': Icons.bug_report,
                'color': Colors.red,
                'details': [
                  'Gejala: Bercak hitam/coklat dengan pinggiran kuning',
                  'Penyebab: Jamur antraknosa atau bakteri',
                  'Solusi: Potong daun terinfeksi, semprot fungisida alami',
                  'Pencegahan: Hindari penyiraman dari atas, jaga sirkulasi udara'
                ],
              },
              _addToFavorites,
            ),
            _buildDiseaseCard(
              context,
              {
                'title': 'Tanaman Layu',
                'icon': Icons.sick,
                'color': Colors.brown,
                'details': [
                  'Gejala: Tanaman layu meski tanah cukup air',
                  'Penyebab: Akar busuk atau penyakit layu fusarium',
                  'Solusi: Periksa akar, ganti media tanam jika busuk',
                  'Pencegahan: Gunakan media tanam steril, jangan overwatering'
                ],
              },
              _addToFavorites,
            ),

            // Section 3: Land Maintenance
            const SizedBox(height: 24),
            _buildSectionTitle('Perawatan Lahan'),
            _buildLandTipCard(
              context,
              {
                'title': 'Rotasi Tanaman',
                'icon': Icons.autorenew,
                'description': 'Berganti jenis tanaman setiap musim untuk menjaga kesuburan tanah dan mengurangi hama.',
              },
              _addToFavorites,
            ),
            _buildLandTipCard(
              context,
              {
                'title': 'Pengolahan Tanah',
                'icon': Icons.agriculture,
                'description': 'Gemburkan tanah sebelum menanam dan tambahkan kompos untuk meningkatkan aerasi dan nutrisi.',
              },
              _addToFavorites,
            ),
            _buildLandTipCard(
              context,
              {
                'title': 'Pengendalian Gulma',
                'icon': Icons.forest,
                'description': 'Cabut gulma secara rutin atau gunakan mulsa organik untuk menekan pertumbuhannya.',
              },
              _addToFavorites,
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

  Widget _buildTipCard(
    BuildContext context,
    Map<String, dynamic> tip,
    Function(Map<String, dynamic>) onAddFavorite,
  ) {
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
                color: (tip['color'] ?? Colors.green).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(tip['icon'] ?? Icons.help_outline, color: tip['color'] ?? Colors.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tip['description'] ?? 'No description available',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () => onAddFavorite(tip),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(
    BuildContext context,
    Map<String, dynamic> disease,
    Function(Map<String, dynamic>) onAddFavorite,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiseaseDetailScreen(
                title: disease['title'] ?? 'Unknown Disease',
                icon: disease['icon'] ?? Icons.warning,
                color: disease['color'] ?? Colors.red,
                details: disease['details'] ?? ['No details available'],
                onAddFavorite: () => onAddFavorite(disease),
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
                      color: (disease['color'] ?? Colors.red).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(disease['icon'] ?? Icons.warning, 
                            color: disease['color'] ?? Colors.red, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      disease['title'] ?? 'Unknown Disease',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () => onAddFavorite(disease),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Disease details summary
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (disease['details'] != null && disease['details'].isNotEmpty) 
                        ? disease['details'][0] 
                        : 'No details available',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (disease['details'] != null && disease['details'].length > 1)
                        ? disease['details'][1]
                        : 'No details available',
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

  Widget _buildLandTipCard(
    BuildContext context,
    Map<String, dynamic> tip,
    Function(Map<String, dynamic>) onAddFavorite,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(tip['icon'] ?? Icons.help_outline, color: Colors.green),
        title: Text(
          tip['title'] ?? 'No Title',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(tip['description'] ?? 'No description available'),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () => onAddFavorite(tip),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TipDetailScreen(
                title: tip['title'] ?? 'No Title',
                description: tip['description'] ?? 'No description available',
                onAddFavorite: () => onAddFavorite(tip),
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
  final VoidCallback onAddFavorite;

  const DiseaseDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.details,
    required this.onAddFavorite,
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
            _buildDetailSection('Gejala', details.isNotEmpty ? details[0].replaceFirst('Gejala: ', '') : 'No symptoms info'),
            _buildDetailSection('Penyebab', details.length > 1 ? details[1].replaceFirst('Penyebab: ', '') : 'No cause info'),
            _buildDetailSection('Solusi', details.length > 2 ? details[2].replaceFirst('Solusi: ', '') : 'No solution info'),
            _buildDetailSection('Pencegahan', details.length > 3 ? details[3].replaceFirst('Pencegahan: ', '') : 'No prevention info'),

            const SizedBox(height: 24),
            _buildTreatmentSteps(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddFavorite,
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
  final VoidCallback onAddFavorite;

  const TipDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.onAddFavorite,
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
                onPressed: onAddFavorite,
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

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteTips;
  final Function(String) onRemove;

  const FavoritesScreen({
    super.key,
    required this.favoriteTips,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Favorit'),
      ),
      body: favoriteTips.isEmpty
          ? const Center(
              child: Text('Belum ada tips favorit'),
            )
          : ListView.builder(
              itemCount: favoriteTips.length,
              itemBuilder: (context, index) {
                final tip = favoriteTips[index];
                return ListTile(
                  leading: Icon(
                    tip['icon'] ?? Icons.help_outline,
                    color: tip['color'] ?? Colors.green,
                  ),
                  title: Text(tip['title'] ?? 'No Title'),
                  subtitle: Text(
                    tip['description'] ?? 
                    (tip['details'] != null && tip['details'].isNotEmpty ? tip['details'][0] : 'No description'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => onRemove(tip['title'] ?? ''),
                  ),
                  onTap: () {
                    if (tip['details'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiseaseDetailScreen(
                            title: tip['title'] ?? 'Unknown Disease',
                            icon: tip['icon'] ?? Icons.warning,
                            color: tip['color'] ?? Colors.red,
                            details: tip['details'] ?? ['No details available'],
                            onAddFavorite: () {}, // Empty callback for favorites
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TipDetailScreen(
                            title: tip['title'] ?? 'No Title',
                            description: tip['description'] ?? 'No description available',
                            onAddFavorite: () {}, // Empty callback for favorites
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}