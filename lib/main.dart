import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

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
  double? suhu;
  int? humidity;
  String? kondisi;
  List<dynamic> berita = [];

  @override
  void initState() {
    super.initState();
    ambilCuaca();
    ambilBerita();
  }

  Future<void> ambilCuaca() async {
    final url = Uri.parse('https://api.weatherapi.com/v1/current.json?key=demo&q=Jakarta');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        suhu = data['current']['temp_c'];
        humidity = data['current']['humidity'];
        kondisi = data['current']['condition']['text'];
      });
    }
  }

  Future<void> ambilBerita() async {
    final url = Uri.parse('https://newsdata.io/api/1/news?apikey=pub_295435caa3f8767f457143d176fe1a6fd20fe&q=pertanian&language=id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        berita = data['results'];
      });
    }
  }

  Future<void> bukaUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak bisa buka URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Pertanian')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text('Cuaca Hari Ini'),
              subtitle: Text(
                suhu != null
                    ? 'Suhu: ${suhu!.toStringAsFixed(1)}°C\nKelembaban: $humidity%\nKondisi: $kondisi'
                    : 'Memuat...',
              ),
              leading: const Icon(Icons.wb_sunny, color: Colors.orange, size: 40),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Berita Pertanian Terbaru',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...berita.map((item) {
            return Card(
              child: ListTile(
                title: Text(item['title'] ?? 'Tanpa Judul'),
                subtitle: Text(item['description'] ?? ''),
                onTap: () {
                  final url = item['link'];
                  if (url != null) bukaUrl(url);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
