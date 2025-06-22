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
      "variety": "Ciherang",
      "planting_season": "Musim Hujan",
      "land_area": "1.5 ha",
      "soil_type": "Lempung",
      "production": {
        "yield": "9 ton",
        "selling_price": "Rp12.500/kg",
      },
      "farmer_data": {
        "name": "Budi Santoso",
        "contact": "081234567890",
      },
    },
  ];

  final List<String> _categories = [
    'Padi',
    'Sayuran',
    'Bumbu',
    'Kacang-kacangan',
    'Buah',
    'Perkebunan',
  ];

  final List<String> _plantingSeasons = [
    'Musim Hujan',
    'Musim Kemarau',
  ];

  final List<String> _soilTypes = [
    'Lempung',
    'Pasir',
    'Liat',
    'Gambut',
  ];

  void _navigateToDetail(Map<String, dynamic> commodityData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommodityDetailScreen(
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
        builder: (context) => CommodityEditScreen(
          commodityData: null,
          categories: _categories,
          plantingSeasons: _plantingSeasons,
          soilTypes: _soilTypes,
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
      int index = _marketData.indexWhere((item) => item['id'] == editedData['id']);
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Komoditas telah dihapus')),
    );
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
      body: _marketData.isEmpty
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
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteCommodity(item['id']),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            Icons.monetization_on,
                            'Harga: Rp${item['price'].toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]}.',
                                )}',
                          ),
                          _buildInfoRow(
                            Icons.location_on,
                            'Lokasi: ${item['location']}',
                          ),
                          _buildInfoRow(
                            Icons.category,
                            'Kategori: ${item['category']}',
                          ),
                          _buildInfoRow(
                            Icons.agriculture,
                            'Varietas: ${item['variety'] ?? '-'}',
                          ),
                          _buildInfoRow(
                            Icons.landscape,
                            'Luas Lahan: ${item['land_area'] ?? '-'}',
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
              _buildDetailItem('Varietas', commodityData['variety']),
              _buildDetailItem('Musim Tanam', commodityData['planting_season']),
              _buildDetailItem('Luas Lahan', commodityData['land_area']),
              _buildDetailItem('Jenis Tanah', commodityData['soil_type']),
            ]),

            _buildSectionTitle('Data Produksi'),
            _buildDetailCard([
              _buildDetailItem('Hasil Panen', commodityData['production']?['yield'] ?? '-'),
              _buildDetailItem('Harga Jual', commodityData['production']?['selling_price'] ?? '-'),
            ]),

            _buildSectionTitle('Data Petani'),
            _buildDetailCard([
              _buildDetailItem('Nama Petani', commodityData['farmer_data']?['name'] ?? '-'),
              _buildDetailItem('Kontak', commodityData['farmer_data']?['contact'] ?? '-'),
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
        builder: (context) => CommodityEditScreen(
          commodityData: commodityData,
          categories: const [],
          plantingSeasons: const [],
          soilTypes: const [],
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
}

class CommodityEditScreen extends StatefulWidget {
  final Map<String, dynamic>? commodityData;
  final List<String> categories;
  final List<String> plantingSeasons;
  final List<String> soilTypes;
  final Function(Map<String, dynamic>) onSave;

  const CommodityEditScreen({
    super.key,
    this.commodityData,
    required this.categories,
    required this.plantingSeasons,
    required this.soilTypes,
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
    _formData = widget.commodityData != null
        ? Map<String, dynamic>.from(widget.commodityData!)
        : {
            "commodity": "",
            "price": 0,
            "location": "",
            "category": widget.categories.isNotEmpty ? widget.categories[0] : "",
            "variety": "",
            "planting_season": widget.plantingSeasons.isNotEmpty ? widget.plantingSeasons[0] : "",
            "land_area": "",
            "soil_type": widget.soilTypes.isNotEmpty ? widget.soilTypes[0] : "",
            "production": {
              "yield": "",
              "selling_price": "",
            },
            "farmer_data": {
              "name": "",
              "contact": "",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.commodityData == null ? 'Tambah Komoditas' : 'Edit Komoditas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
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
              _buildTextField('Varietas', 'variety'),
              if (widget.plantingSeasons.isNotEmpty)
                _buildDropdown('Musim Tanam', 'planting_season', widget.plantingSeasons),
              _buildTextField('Luas Lahan', 'land_area'),
              if (widget.soilTypes.isNotEmpty)
                _buildDropdown('Jenis Tanah', 'soil_type', widget.soilTypes),

              _buildSectionTitle('Data Produksi'),
              _buildTextField('Hasil Panen', 'production.yield'),
              _buildTextField('Harga Jual', 'production.selling_price'),

              _buildSectionTitle('Data Petani'),
              _buildTextField('Nama Petani', 'farmer_data.name'),
              _buildTextField('Kontak', 'farmer_data.contact'),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
            data[pathParts.last] = int.parse(value);
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String label, String fieldPath, List<String> items) {
    List<String> pathParts = fieldPath.split('.');
    dynamic currentData = _formData;

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
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
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
}