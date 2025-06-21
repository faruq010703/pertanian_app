import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pertanian',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _soilMoisture = 65;
  bool _isWatering = false;
  DateTime? _lastWateredTime;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _weatherForecast = [
    {'day': 'Hari Ini', 'icon': Icons.wb_sunny, 'temp': '28°C/23°C', 'rainChance': 20},
    {'day': 'Besok', 'icon': Icons.cloud, 'temp': '27°C/22°C', 'rainChance': 40},
    {'day': 'Lusa', 'icon': Icons.thunderstorm, 'temp': '26°C/21°C', 'rainChance': 70},
  ];

  Color _getMoistureColor(int moisture) {
    if (moisture < 30) return Colors.red;
    if (moisture < 60) return Colors.orange;
    if (moisture < 80) return Colors.green;
    return Colors.blue;
  }

  String _getMoistureStatus(int moisture) {
    if (moisture < 30) return 'Sangat Kering';
    if (moisture < 60) return 'Perlu Disiram Segera';
    if (moisture < 80) return 'Kelembaban Ideal';
    return 'Terlalu Basah';
  }

  Future<void> _showWateringDialog() async {
    final shouldWater = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Penyiraman'),
        content: const Text('Apakah Anda yakin ingin menyiram tanaman sekarang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, Siram Sekarang'),
          ),
        ],
      ),
    );

    if (shouldWater == true) {
      _waterPlants();
    }
  }

  void _waterPlants() {
    setState(() {
      _isWatering = true;
      _lastWateredTime = DateTime.now();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isWatering = false;
        _soilMoisture = 80;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Penyiraman berhasil dilakukan!')),
      );
    });
  }

  void _refreshData() {
    setState(() {
      _soilMoisture = (65 + DateTime.now().second % 10 - 5).clamp(20, 90);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data diperbarui')),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return 'Belum pernah disiram';
    return 'Terakhir disiram: ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nextWateringTime = _soilMoisture < 60 
      ? 'Segera' 
      : 'Besok ${DateTime.now().add(const Duration(days: 1)).hour.toString().padLeft(2, '0')}:00';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Pertanian'), // Changed from 'Beranda Pertanian'
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Card - simplified without duplicate title
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny, size: 50, color: Colors.amber),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '28°C',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Cerah Berawan'),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Kelembaban: 75%'),
                        const Text('Peluang Hujan: 20%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Soil Moisture Card - simplified
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _soilMoisture / 100,
                      backgroundColor: Colors.grey[200],
                      color: _getMoistureColor(_soilMoisture),
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_soilMoisture%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getMoistureStatus(_soilMoisture),
                          style: TextStyle(
                            color: _getMoistureColor(_soilMoisture),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Watering Schedule Card - simplified
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Penyiraman Berikutnya'),
                      subtitle: Text(nextWateringTime),
                      trailing: ElevatedButton(
                        onPressed: _isWatering ? null : _showWateringDialog,
                        child: _isWatering
                            ? const CircularProgressIndicator()
                            : const Text('Siram Sekarang'),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Riwayat Penyiraman'),
                      subtitle: Text(_formatTime(_lastWateredTime)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Weather Forecast - simplified
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _weatherForecast.map((forecast) => WeatherForecastCard(
                  day: forecast['day'] as String,
                  icon: forecast['icon'] as IconData,
                  temp: forecast['temp'] as String,
                  rainChance: forecast['rainChance'] as int,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Pestisida',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class WeatherForecastCard extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temp;
  final int rainChance;

  const WeatherForecastCard({
    super.key,
    required this.day,
    required this.icon,
    required this.temp,
    required this.rainChance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(day),
              const SizedBox(height: 8),
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 8),
              Text(temp),
            ],
          ),
        ),
      ),
    );
  }
}