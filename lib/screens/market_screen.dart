import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MarketScreen()));
}

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<Map<String, dynamic>> _marketData = [
    {
      "id": 1,
      "commodity": "Beras Premium",
      "price": 12500,
      "location": "Jakarta",
      "date": "2023-11-01",
      "category": "Padi",
      "plant_type": "Padi",
      "variety": "Ciherang",
      "planting_season": "Musim Hujan",
      "planting_date": "2023-01-15",
      "harvest_date": "2023-04-20",
      "productivity": "6 ton/ha",
      "common_pests": ["Wereng coklat", "Penggerek batang"],
      "cultivation_method": "Konvensional",
      "land_area": "1.5 ha",
      "soil_type": "Lempung",
      "soil_ph": 6.2,
      "nutrient_content": {"N": "sedang", "P": "tinggi", "K": "rendah"},
      "water_availability": "Irigasi teknis",
      "elevation": "250 mdpl",
      "gps_coordinates": "-6.200000, 106.816666",
      "weather_data": {
        "temperature": {"min": 22, "max": 32},
        "rainfall": "150 mm/bulan",
        "humidity": "80%",
        "sunlight": "8 jam/hari",
        "wind_speed": "10 km/jam",
      },
      "pest_data": [
        {
          "pest_name": "Wereng coklat",
          "symptoms": "Daun menguning, tanaman kerdil",
          "control_method": "Pestisida sistemik",
          "attack_history": "Serangan ringan bulan lalu",
        },
      ],
      "fertilization": [
        {
          "fertilizer_type": "NPK",
          "dosage": "300 kg/ha",
          "schedule": "2 minggu setelah tanam",
        },
      ],
      "watering": {"frequency": "2 hari sekali", "volume": "5 cm genangan"},
      "production": {
        "yield": "9 ton",
        "production_cost": "Rp15.000.000",
        "selling_price": "Rp12.500/kg",
        "profit": "Rp97.500.000",
        "harvest_time": "90 HST",
        "quality": "Grade A",
      },
      "market_data": {
        "daily_price": "Rp12.000-Rp13.000/kg",
        "demand": "Tinggi",
        "supply": "Cukup",
        "distribution_chain": "Petani → Pengumpul → Pasar Induk",
        "nearest_market": "Pasar Induk Kramat Jati",
        "trending": true,
      },
      "farmer_data": {
        "name": "Budi Santoso",
        "age": 45,
        "gender": "Laki-laki",
        "farmer_group": "Kelompok Tani Sumber Rejeki",
        "experience": "15 tahun",
        "contact": "081234567890",
        "address": "Desa Sukamaju, Kec. Cibitung, Kab. Bekasi",
      },
    },
  ];

  final List<String> _categories = [
    'Padi',
    'Sayuran',
    'Bumbu',
    'Kacang-kacangan',
    'Palawija',
    'Peternakan',
    'Umbi-umbian',
    'Buah',
    'Perkebunan',
  ];

  final List<String> _plantingSeasons = [
    'Musim Hujan',
    'Musim Kemarau',
    'Sepanjang Tahun',
  ];

  final List<String> _cultivationMethods = [
    'Konvensional',
    'Organik',
    'Hidroponik',
    'Vertikultur',
  ];

  final List<String> _soilTypes = [
    'Lempung',
    'Pasir',
    'Liat',
    'Gambut',
    'Berpasir',
  ];

  final List<String> _waterAvailability = [
    'Irigasi teknis',
    'Irigasi semi teknis',
    'Tadah hujan',
    'Pompa air',
  ];

  final List<String> _marketDemand = ['Tinggi', 'Sedang', 'Rendah'];
  final List<String> _marketSupply = ['Banyak', 'Cukup', 'Sedikit'];
  final List<String> _qualityLevels = ['Grade A', 'Grade B', 'Grade C'];

  void _navigateToDetail(Map<String, dynamic> commodityData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CommodityDetailScreen(
              commodityData: commodityData,
              onEdit: (editedData) => _editCommodity(editedData),
              onDelete: () => _deleteCommodity(commodityData['id']),
            ),
      ),
    );
  }

  void _addNewCommodity() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CommodityEditScreen(
              commodityData: null,
              categories: _categories,
              plantingSeasons: _plantingSeasons,
              cultivationMethods: _cultivationMethods,
              soilTypes: _soilTypes,
              waterAvailability: _waterAvailability,
              marketDemand: _marketDemand,
              marketSupply: _marketSupply,
              qualityLevels: _qualityLevels,
              onSave: (newData) => _addCommodity(newData),
            ),
      ),
    );
  }

  void _addCommodity(Map<String, dynamic> newData) {
    setState(() {
      _marketData.add({
        ...newData,
        "id": DateTime.now().millisecondsSinceEpoch,
        "date": DateTime.now().toString().split(' ')[0],
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Komoditas berhasil ditambahkan')),
    );
  }

  void _editCommodity(Map<String, dynamic> editedData) {
    setState(() {
      int index = _marketData.indexWhere(
        (item) => item['id'] == editedData['id'],
      );
      if (index != -1) {
        _marketData[index] = editedData;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perubahan berhasil disimpan')),
    );
  }

  void _deleteCommodity(int id) {
    setState(() {
      _marketData.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Komoditas telah dihapus')));
    Navigator.pop(context); // Close detail screen if deleting from there
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistem Informasi Pertanian'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewCommodity,
            tooltip: 'Tambah Data',
          ),
        ],
      ),
      body:
          _marketData.isEmpty
              ? const Center(
                child: Text(
                  'Tidak ada data tersedia',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: _marketData.length,
                itemBuilder: (context, index) {
                  final item = _marketData[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () => _navigateToDetail(item),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _getCategoryIcon(item['category']),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item['commodity'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _deleteCommodity(item['id']),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              Icons.monetization_on,
                              'Harga: Rp${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            ),
                            _buildInfoRow(
                              Icons.location_on,
                              'Lokasi: ${item['location']}',
                            ),
                            _buildInfoRow(
                              Icons.category,
                              'Kategori: ${item['category']}',
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Informasi Tambahan:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            _buildInfoRow(
                              Icons.agriculture,
                              'Varietas: ${item['variety'] ?? '-'}',
                            ),
                            _buildInfoRow(
                              Icons.landscape,
                              'Luas Lahan: ${item['land_area'] ?? '-'}',
                            ),
                            _buildInfoRow(
                              Icons.people,
                              'Petani: ${item['farmer_data']?['name'] ?? '-'}',
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _navigateToDetail(item),
                                child: const Text('Lihat Detail →'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _getCategoryIcon(String category) {
    switch (category) {
      case 'Padi':
        return const Icon(Icons.grass, color: Colors.green, size: 30);
      case 'Sayuran':
        return const Icon(Icons.eco, color: Colors.lightGreen, size: 30);
      case 'Bumbu':
        return const Icon(Icons.kitchen, color: Colors.orange, size: 30);
      case 'Kacang-kacangan':
        return const Icon(Icons.pentagon, color: Colors.brown, size: 30);
      case 'Palawija':
        return const Icon(Icons.agriculture, color: Colors.amber, size: 30);
      case 'Peternakan':
        return const Icon(Icons.pets, color: Colors.red, size: 30);
      case 'Umbi-umbian':
        return const Icon(Icons.park, color: Colors.purple, size: 30);
      case 'Buah':
        return const Icon(Icons.apple, color: Colors.redAccent, size: 30);
      case 'Perkebunan':
        return const Icon(Icons.forest, color: Colors.deepOrange, size: 30);
      default:
        return const Icon(Icons.shopping_basket, color: Colors.green, size: 30);
    }
  }
}

class CommodityDetailScreen extends StatelessWidget {
  final Map<String, dynamic> commodityData;
  final Function(Map<String, dynamic>) onEdit;
  final Function() onDelete;

  const CommodityDetailScreen({
    super.key,
    required this.commodityData,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(commodityData['commodity']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEdit(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Informasi Dasar'),
            _buildDetailCard([
              _buildDetailItem('Nama Komoditas', commodityData['commodity']),
              _buildDetailItem('Harga', 'Rp${commodityData['price']}'),
              _buildDetailItem('Lokasi', commodityData['location']),
              _buildDetailItem('Kategori', commodityData['category']),
              _buildDetailItem('Tanggal', commodityData['date']),
            ]),

            _buildSectionTitle('Data Tanaman'),
            _buildDetailCard([
              _buildDetailItem('Jenis Tanaman', commodityData['plant_type']),
              _buildDetailItem('Varietas', commodityData['variety']),
              _buildDetailItem('Musim Tanam', commodityData['planting_season']),
              _buildDetailItem('Tanggal Tanam', commodityData['planting_date']),
              _buildDetailItem('Tanggal Panen', commodityData['harvest_date']),
              _buildDetailItem('Produktivitas', commodityData['productivity']),
              _buildDetailItem(
                'Metode Budidaya',
                commodityData['cultivation_method'],
              ),
              _buildDetailItem(
                'Hama Umum',
                (commodityData['common_pests'] as List?)?.join(', ') ?? '-',
              ),
            ]),

            _buildSectionTitle('Data Lahan/Kebun'),
            _buildDetailCard([
              _buildDetailItem('Luas Lahan', commodityData['land_area']),
              _buildDetailItem('Jenis Tanah', commodityData['soil_type']),
              _buildDetailItem(
                'pH Tanah',
                commodityData['soil_ph']?.toString(),
              ),
              _buildDetailItem(
                'Kandungan N',
                commodityData['nutrient_content']?['N'] ?? '-',
              ),
              _buildDetailItem(
                'Kandungan P',
                commodityData['nutrient_content']?['P'] ?? '-',
              ),
              _buildDetailItem(
                'Kandungan K',
                commodityData['nutrient_content']?['K'] ?? '-',
              ),
              _buildDetailItem(
                'Ketersediaan Air',
                commodityData['water_availability'],
              ),
              _buildDetailItem('Ketinggian', commodityData['elevation']),
              _buildDetailItem(
                'Koordinat GPS',
                commodityData['gps_coordinates'],
              ),
            ]),

            _buildSectionTitle('Data Cuaca & Iklim'),
            _buildDetailCard([
              _buildDetailItem(
                'Suhu Min-Max',
                '${commodityData['weather_data']?['temperature']?['min']}°C - '
                    '${commodityData['weather_data']?['temperature']?['max']}°C',
              ),
              _buildDetailItem(
                'Curah Hujan',
                commodityData['weather_data']?['rainfall'] ?? '-',
              ),
              _buildDetailItem(
                'Kelembapan',
                commodityData['weather_data']?['humidity'] ?? '-',
              ),
              _buildDetailItem(
                'Sinar Matahari',
                commodityData['weather_data']?['sunlight'] ?? '-',
              ),
              _buildDetailItem(
                'Kecepatan Angin',
                commodityData['weather_data']?['wind_speed'] ?? '-',
              ),
            ]),

            _buildSectionTitle('Data Hama & Penyakit'),
            ...?_buildPestData(commodityData['pest_data']),

            _buildSectionTitle('Pemupukan & Penyiraman'),
            _buildDetailCard([
              _buildDetailItem(
                'Frekuensi Penyiraman',
                commodityData['watering']?['frequency'] ?? '-',
              ),
              _buildDetailItem(
                'Volume Air',
                commodityData['watering']?['volume'] ?? '-',
              ),
              ...?_buildFertilizationData(commodityData['fertilization']),
            ]),

            _buildSectionTitle('Data Produksi'),
            _buildDetailCard([
              _buildDetailItem(
                'Hasil Panen',
                commodityData['production']?['yield'] ?? '-',
              ),
              _buildDetailItem(
                'Biaya Produksi',
                commodityData['production']?['production_cost'] ?? '-',
              ),
              _buildDetailItem(
                'Harga Jual',
                commodityData['production']?['selling_price'] ?? '-',
              ),
              _buildDetailItem(
                'Keuntungan',
                commodityData['production']?['profit'] ?? '-',
              ),
              _buildDetailItem(
                'Waktu Panen',
                commodityData['production']?['harvest_time'] ?? '-',
              ),
              _buildDetailItem(
                'Kualitas',
                commodityData['production']?['quality'] ?? '-',
              ),
            ]),

            _buildSectionTitle('Data Pasar'),
            _buildDetailCard([
              _buildDetailItem(
                'Harga Harian',
                commodityData['market_data']?['daily_price'] ?? '-',
              ),
              _buildDetailItem(
                'Permintaan',
                commodityData['market_data']?['demand'] ?? '-',
              ),
              _buildDetailItem(
                'Penawaran',
                commodityData['market_data']?['supply'] ?? '-',
              ),
              _buildDetailItem(
                'Rantai Distribusi',
                commodityData['market_data']?['distribution_chain'] ?? '-',
              ),
              _buildDetailItem(
                'Pasar Terdekat',
                commodityData['market_data']?['nearest_market'] ?? '-',
              ),
              _buildDetailItem(
                'Sedang Tren',
                (commodityData['market_data']?['trending'] ?? false)
                    ? 'Ya'
                    : 'Tidak',
              ),
            ]),

            _buildSectionTitle('Data Petani'),
            _buildDetailCard([
              _buildDetailItem(
                'Nama Petani',
                commodityData['farmer_data']?['name'] ?? '-',
              ),
              _buildDetailItem(
                'Umur',
                commodityData['farmer_data']?['age']?.toString() ?? '-',
              ),
              _buildDetailItem(
                'Jenis Kelamin',
                commodityData['farmer_data']?['gender'] ?? '-',
              ),
              _buildDetailItem(
                'Kelompok Tani',
                commodityData['farmer_data']?['farmer_group'] ?? '-',
              ),
              _buildDetailItem(
                'Pengalaman',
                commodityData['farmer_data']?['experience'] ?? '-',
              ),
              _buildDetailItem(
                'Kontak',
                commodityData['farmer_data']?['contact'] ?? '-',
              ),
              _buildDetailItem(
                'Alamat',
                commodityData['farmer_data']?['address'] ?? '-',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CommodityEditScreen(
              commodityData: commodityData,
              categories: const [],
              plantingSeasons: const [],
              cultivationMethods: const [],
              soilTypes: const [],
              waterAvailability: const [],
              marketDemand: const [],
              marketSupply: const [],
              qualityLevels: const [],
              onSave: onEdit,
            ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const Text(': ', style: TextStyle(fontWeight: FontWeight.w500)),
          Expanded(flex: 3, child: Text(value ?? '-')),
        ],
      ),
    );
  }

  List<Widget>? _buildPestData(List<dynamic>? pestData) {
    if (pestData == null || pestData.isEmpty) {
      return [
        _buildDetailCard([
          const Text(
            'Tidak ada data hama/penyakit',
            style: TextStyle(color: Colors.grey),
          ),
        ]),
      ];
    }

    return pestData.map((pest) {
      return _buildDetailCard([
        _buildDetailItem('Jenis Hama', pest['pest_name']),
        _buildDetailItem('Gejala', pest['symptoms']),
        _buildDetailItem('Metode Pengendalian', pest['control_method']),
        _buildDetailItem('Riwayat Serangan', pest['attack_history']),
      ]);
    }).toList();
  }

  List<Widget>? _buildFertilizationData(List<dynamic>? fertData) {
    if (fertData == null || fertData.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(
            'Tidak ada data pemupukan',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    return fertData.map((fert) {
      return Column(
        children: [
          _buildDetailItem('Jenis Pupuk', fert['fertilizer_type']),
          _buildDetailItem('Dosis', fert['dosage']),
          _buildDetailItem('Jadwal', fert['schedule']),
        ],
      );
    }).toList();
  }
}

class CommodityEditScreen extends StatefulWidget {
  final Map<String, dynamic>? commodityData;
  final List<String> categories;
  final List<String> plantingSeasons;
  final List<String> cultivationMethods;
  final List<String> soilTypes;
  final List<String> waterAvailability;
  final List<String> marketDemand;
  final List<String> marketSupply;
  final List<String> qualityLevels;
  final Function(Map<String, dynamic>) onSave;

  const CommodityEditScreen({
    super.key,
    this.commodityData,
    required this.categories,
    required this.plantingSeasons,
    required this.cultivationMethods,
    required this.soilTypes,
    required this.waterAvailability,
    required this.marketDemand,
    required this.marketSupply,
    required this.qualityLevels,
    required this.onSave,
  });

  @override
  State<CommodityEditScreen> createState() => _CommodityEditScreenState();
}

class _CommodityEditScreenState extends State<CommodityEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData =
        widget.commodityData != null
            ? Map<String, dynamic>.from(widget.commodityData!)
            : {
              "commodity": "",
              "price": 0,
              "location": "",
              "category":
                  widget.categories.isNotEmpty ? widget.categories[0] : "",
              "plant_type": "",
              "variety": "",
              "planting_season":
                  widget.plantingSeasons.isNotEmpty
                      ? widget.plantingSeasons[0]
                      : "",
              "planting_date": "",
              "harvest_date": "",
              "productivity": "",
              "common_pests": [],
              "cultivation_method":
                  widget.cultivationMethods.isNotEmpty
                      ? widget.cultivationMethods[0]
                      : "",
              "land_area": "",
              "soil_type":
                  widget.soilTypes.isNotEmpty ? widget.soilTypes[0] : "",
              "soil_ph": 6.0,
              "nutrient_content": {"N": "sedang", "P": "sedang", "K": "sedang"},
              "water_availability":
                  widget.waterAvailability.isNotEmpty
                      ? widget.waterAvailability[0]
                      : "",
              "elevation": "",
              "gps_coordinates": "",
              "weather_data": {
                "temperature": {"min": 0, "max": 0},
                "rainfall": "",
                "humidity": "",
                "sunlight": "",
                "wind_speed": "",
              },
              "pest_data": [],
              "fertilization": [],
              "watering": {"frequency": "", "volume": ""},
              "production": {
                "yield": "",
                "production_cost": "",
                "selling_price": "",
                "profit": "",
                "harvest_time": "",
                "quality":
                    widget.qualityLevels.isNotEmpty
                        ? widget.qualityLevels[0]
                        : "",
              },
              "market_data": {
                "daily_price": "",
                "demand":
                    widget.marketDemand.isNotEmpty
                        ? widget.marketDemand[0]
                        : "",
                "supply":
                    widget.marketSupply.isNotEmpty
                        ? widget.marketSupply[0]
                        : "",
                "distribution_chain": "",
                "nearest_market": "",
                "trending": false,
              },
              "farmer_data": {
                "name": "",
                "age": 0,
                "gender": "Laki-laki",
                "farmer_group": "",
                "experience": "",
                "contact": "",
                "address": "",
              },
            };
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSave(_formData);
      Navigator.pop(context);
    }
  }

  void _addPest() {
    showDialog(
      context: context,
      builder: (context) {
        final pestNameController = TextEditingController();
        final symptomsController = TextEditingController();
        final controlMethodController = TextEditingController();
        final attackHistoryController = TextEditingController();

        return AlertDialog(
          title: const Text('Tambah Data Hama/Penyakit'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: pestNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Hama/Penyakit',
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: symptomsController,
                  decoration: const InputDecoration(labelText: 'Gejala'),
                ),
                TextFormField(
                  controller: controlMethodController,
                  decoration: const InputDecoration(
                    labelText: 'Metode Pengendalian',
                  ),
                ),
                TextFormField(
                  controller: attackHistoryController,
                  decoration: const InputDecoration(
                    labelText: 'Riwayat Serangan',
                  ),
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
                  if (_formData['pest_data'] == null) {
                    _formData['pest_data'] = [];
                  }
                  _formData['pest_data'].add({
                    "pest_name": pestNameController.text,
                    "symptoms": symptomsController.text,
                    "control_method": controlMethodController.text,
                    "attack_history": attackHistoryController.text,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _editPest(int index) {
    final pest = _formData['pest_data'][index];
    final pestNameController = TextEditingController(text: pest['pest_name']);
    final symptomsController = TextEditingController(text: pest['symptoms']);
    final controlMethodController = TextEditingController(
      text: pest['control_method'],
    );
    final attackHistoryController = TextEditingController(
      text: pest['attack_history'],
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Data Hama/Penyakit'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: pestNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Hama/Penyakit',
                    ),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: symptomsController,
                    decoration: const InputDecoration(labelText: 'Gejala'),
                  ),
                  TextFormField(
                    controller: controlMethodController,
                    decoration: const InputDecoration(
                      labelText: 'Metode Pengendalian',
                    ),
                  ),
                  TextFormField(
                    controller: attackHistoryController,
                    decoration: const InputDecoration(
                      labelText: 'Riwayat Serangan',
                    ),
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
                    _formData['pest_data'][index] = {
                      "pest_name": pestNameController.text,
                      "symptoms": symptomsController.text,
                      "control_method": controlMethodController.text,
                      "attack_history": attackHistoryController.text,
                    };
                  });
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  void _deletePest(int index) {
    setState(() {
      _formData['pest_data'].removeAt(index);
    });
  }

  void _addFertilization() {
    showDialog(
      context: context,
      builder: (context) {
        final typeController = TextEditingController();
        final dosageController = TextEditingController();
        final scheduleController = TextEditingController();

        return AlertDialog(
          title: const Text('Tambah Data Pemupukan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Jenis Pupuk'),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: dosageController,
                  decoration: const InputDecoration(labelText: 'Dosis'),
                ),
                TextFormField(
                  controller: scheduleController,
                  decoration: const InputDecoration(labelText: 'Jadwal'),
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
                  if (_formData['fertilization'] == null) {
                    _formData['fertilization'] = [];
                  }
                  _formData['fertilization'].add({
                    "fertilizer_type": typeController.text,
                    "dosage": dosageController.text,
                    "schedule": scheduleController.text,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _editFertilization(int index) {
    final fert = _formData['fertilization'][index];
    final typeController = TextEditingController(text: fert['fertilizer_type']);
    final dosageController = TextEditingController(text: fert['dosage']);
    final scheduleController = TextEditingController(text: fert['schedule']);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Data Pemupukan'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: typeController,
                    decoration: const InputDecoration(labelText: 'Jenis Pupuk'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: dosageController,
                    decoration: const InputDecoration(labelText: 'Dosis'),
                  ),
                  TextFormField(
                    controller: scheduleController,
                    decoration: const InputDecoration(labelText: 'Jadwal'),
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
                    _formData['fertilization'][index] = {
                      "fertilizer_type": typeController.text,
                      "dosage": dosageController.text,
                      "schedule": scheduleController.text,
                    };
                  });
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  void _deleteFertilization(int index) {
    setState(() {
      _formData['fertilization'].removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.commodityData == null ? 'Tambah Komoditas' : 'Edit Komoditas',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informasi Dasar'),
              _buildTextField('Nama Komoditas', 'commodity'),
              _buildNumberField('Harga', 'price'),
              _buildTextField('Lokasi', 'location'),
              if (widget.categories.isNotEmpty)
                _buildDropdown('Kategori', 'category', widget.categories),

              _buildSectionTitle('Data Tanaman'),
              _buildTextField('Jenis Tanaman', 'plant_type'),
              _buildTextField('Varietas', 'variety'),
              if (widget.plantingSeasons.isNotEmpty)
                _buildDropdown(
                  'Musim Tanam',
                  'planting_season',
                  widget.plantingSeasons,
                ),
              _buildTextField('Tanggal Tanam', 'planting_date'),
              _buildTextField('Tanggal Panen', 'harvest_date'),
              _buildTextField('Produktivitas', 'productivity'),
              if (widget.cultivationMethods.isNotEmpty)
                _buildDropdown(
                  'Metode Budidaya',
                  'cultivation_method',
                  widget.cultivationMethods,
                ),
              _buildMultiSelectField('Hama Umum', 'common_pests'),

              _buildSectionTitle('Data Lahan/Kebun'),
              _buildTextField('Luas Lahan', 'land_area'),
              if (widget.soilTypes.isNotEmpty)
                _buildDropdown('Jenis Tanah', 'soil_type', widget.soilTypes),
              _buildNumberField('pH Tanah', 'soil_ph'),
              _buildDropdown('Kandungan N', 'nutrient_content.N', [
                'rendah',
                'sedang',
                'tinggi',
              ]),
              _buildDropdown('Kandungan P', 'nutrient_content.P', [
                'rendah',
                'sedang',
                'tinggi',
              ]),
              _buildDropdown('Kandungan K', 'nutrient_content.K', [
                'rendah',
                'sedang',
                'tinggi',
              ]),
              if (widget.waterAvailability.isNotEmpty)
                _buildDropdown(
                  'Ketersediaan Air',
                  'water_availability',
                  widget.waterAvailability,
                ),
              _buildTextField('Ketinggian', 'elevation'),
              _buildTextField('Koordinat GPS', 'gps_coordinates'),

              _buildSectionTitle('Data Cuaca & Iklim'),
              _buildNumberField('Suhu Minimum', 'weather_data.temperature.min'),
              _buildNumberField(
                'Suhu Maksimum',
                'weather_data.temperature.max',
              ),
              _buildTextField('Curah Hujan', 'weather_data.rainfall'),
              _buildTextField('Kelembapan', 'weather_data.humidity'),
              _buildTextField('Sinar Matahari', 'weather_data.sunlight'),
              _buildTextField('Kecepatan Angin', 'weather_data.wind_speed'),

              _buildSectionTitle('Data Hama & Penyakit'),
              ..._buildPestList(),
              ElevatedButton(
                onPressed: _addPest,
                child: const Text('Tambah Hama/Penyakit'),
              ),

              _buildSectionTitle('Pemupukan & Penyiraman'),
              _buildTextField('Frekuensi Penyiraman', 'watering.frequency'),
              _buildTextField('Volume Air', 'watering.volume'),
              ..._buildFertilizationList(),
              ElevatedButton(
                onPressed: _addFertilization,
                child: const Text('Tambah Pemupukan'),
              ),

              _buildSectionTitle('Data Produksi'),
              _buildTextField('Hasil Panen', 'production.yield'),
              _buildTextField('Biaya Produksi', 'production.production_cost'),
              _buildTextField('Harga Jual', 'production.selling_price'),
              _buildTextField('Keuntungan', 'production.profit'),
              _buildTextField('Waktu Panen', 'production.harvest_time'),
              if (widget.qualityLevels.isNotEmpty)
                _buildDropdown(
                  'Kualitas',
                  'production.quality',
                  widget.qualityLevels,
                ),

              _buildSectionTitle('Data Pasar'),
              _buildTextField('Harga Harian', 'market_data.daily_price'),
              if (widget.marketDemand.isNotEmpty)
                _buildDropdown(
                  'Permintaan',
                  'market_data.demand',
                  widget.marketDemand,
                ),
              if (widget.marketSupply.isNotEmpty)
                _buildDropdown(
                  'Penawaran',
                  'market_data.supply',
                  widget.marketSupply,
                ),
              _buildTextField(
                'Rantai Distribusi',
                'market_data.distribution_chain',
              ),
              _buildTextField('Pasar Terdekat', 'market_data.nearest_market'),
              SwitchListTile(
                title: const Text('Sedang Tren'),
                value: _formData['market_data']?['trending'] ?? false,
                onChanged: (value) {
                  setState(() {
                    _formData['market_data']['trending'] = value;
                  });
                },
              ),

              _buildSectionTitle('Data Petani'),
              _buildTextField('Nama Petani', 'farmer_data.name'),
              _buildNumberField('Umur', 'farmer_data.age'),
              _buildDropdown('Jenis Kelamin', 'farmer_data.gender', [
                'Laki-laki',
                'Perempuan',
              ]),
              _buildTextField('Kelompok Tani', 'farmer_data.farmer_group'),
              _buildTextField('Pengalaman', 'farmer_data.experience'),
              _buildTextField('Kontak', 'farmer_data.contact'),
              _buildTextField('Alamat', 'farmer_data.address'),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Simpan Data',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String fieldPath) {
    List<String> pathParts = fieldPath.split('.');
    dynamic currentData = _formData;

    // Navigate through the nested structure
    for (int i = 0; i < pathParts.length - 1; i++) {
      if (currentData[pathParts[i]] == null) {
        currentData[pathParts[i]] = {};
      }
      currentData = currentData[pathParts[i]];
    }

    final fieldName = pathParts.last;
    final initialValue = currentData[fieldName]?.toString() ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
        onSaved: (value) {
          // Navigate through the nested structure again
          dynamic data = _formData;
          for (int i = 0; i < pathParts.length - 1; i++) {
            if (data[pathParts[i]] == null) {
              data[pathParts[i]] = {};
            }
            data = data[pathParts[i]];
          }
          data[pathParts.last] = value;
        },
      ),
    );
  }

  Widget _buildNumberField(String label, String fieldPath) {
    List<String> pathParts = fieldPath.split('.');
    dynamic currentData = _formData;

    // Navigate through the nested structure
    for (int i = 0; i < pathParts.length - 1; i++) {
      if (currentData[pathParts[i]] == null) {
        currentData[pathParts[i]] = {};
      }
      currentData = currentData[pathParts[i]];
    }

    final fieldName = pathParts.last;
    final initialValue = currentData[fieldName]?.toString() ?? '0';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
        onSaved: (value) {
          dynamic data = _formData;
          for (int i = 0; i < pathParts.length - 1; i++) {
            if (data[pathParts[i]] == null) {
              data[pathParts[i]] = {};
            }
            data = data[pathParts[i]];
          }

          if (value != null && value.isNotEmpty) {
            if (value.contains('.')) {
              data[pathParts.last] = double.parse(value);
            } else {
              data[pathParts.last] = int.parse(value);
            }
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String label, String fieldPath, List<String> items) {
    List<String> pathParts = fieldPath.split('.');
    dynamic currentData = _formData;

    // Navigate through the nested structure
    for (int i = 0; i < pathParts.length - 1; i++) {
      if (currentData[pathParts[i]] == null) {
        currentData[pathParts[i]] = {};
      }
      currentData = currentData[pathParts[i]];
    }

    final fieldName = pathParts.last;
    final currentValue = currentData[fieldName]?.toString() ?? items.first;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items:
            items.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        onChanged: (newValue) {
          setState(() {
            dynamic data = _formData;
            for (int i = 0; i < pathParts.length - 1; i++) {
              if (data[pathParts[i]] == null) {
                data[pathParts[i]] = {};
              }
              data = data[pathParts[i]];
            }
            data[pathParts.last] = newValue;
          });
        },
      ),
    );
  }

  Widget _buildMultiSelectField(String label, String fieldPath) {
    List<String> pathParts = fieldPath.split('.');
    dynamic currentData = _formData;

    // Navigate through the nested structure
    for (int i = 0; i < pathParts.length - 1; i++) {
      if (currentData[pathParts[i]] == null) {
        currentData[pathParts[i]] = {};
      }
      currentData = currentData[pathParts[i]];
    }

    final fieldName = pathParts.last;
    if (currentData[fieldName] == null) {
      currentData[fieldName] = [];
    }
    final currentItems = List<String>.from(currentData[fieldName] ?? []);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                currentItems.map((item) {
                  return Chip(
                    label: Text(item),
                    onDeleted: () {
                      setState(() {
                        currentData[fieldName].remove(item);
                      });
                    },
                  );
                }).toList(),
          ),
          TextButton(
            onPressed: () async {
              final newItem = await showDialog<String>(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    title: const Text('Tambah Item'),
                    content: TextField(
                      controller: controller,
                      decoration: const InputDecoration(labelText: 'Item Baru'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            Navigator.pop(context, controller.text);
                          }
                        },
                        child: const Text('Tambah'),
                      ),
                    ],
                  );
                },
              );

              if (newItem != null && newItem.isNotEmpty) {
                setState(() {
                  currentData[fieldName].add(newItem);
                });
              }
            },
            child: const Text('+ Tambah Item'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPestList() {
    if (_formData['pest_data'] == null || _formData['pest_data'].isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Tidak ada data hama/penyakit',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    return _formData['pest_data'].asMap().entries.map((entry) {
      final index = entry.key;
      final pest = entry.value;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text(pest['pest_name']),
          subtitle: Text(pest['symptoms']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _editPest(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () => _deletePest(index),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildFertilizationList() {
    if (_formData['fertilization'] == null ||
        _formData['fertilization'].isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Tidak ada data pemupukan',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ];
    }

    return _formData['fertilization'].asMap().entries.map((entry) {
      final index = entry.key;
      final fert = entry.value;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text(fert['fertilizer_type']),
          subtitle: Text('${fert['dosage']} - ${fert['schedule']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _editFertilization(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () => _deleteFertilization(index),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
