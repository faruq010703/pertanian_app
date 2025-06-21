import 'package:flutter/material.dart';
import 'login_screen.dart';

// Add this class outside of your ProfileScreen class
class FarmingFeature {
  final IconData icon;
  final String title;
  final String details;

  FarmingFeature({
    required this.icon,
    required this.title,
    required this.details,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Agus Setiawan';
  String userRole = 'Petani Cabai Organik';
  String userLocation = 'Jawa Barat, Indonesia';
  String farmType = 'Budidaya Cabai Organik';
  String landArea = '2 Hektar';
  String joinDate = 'Januari 2022';
  String userBio =
      'Petani cabai organik dengan sistem irigasi tetes modern. Fokus pada pertanian berkelanjutan.';
  String profileImageUrl = 'https://example.com/farmer-avatar.jpg';

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
            // Editable Profile Header Section
            _buildProfileHeader(),
            const SizedBox(height: 24),
            
            // Editable User Information Section
            _buildUserInfoSection(),
            const SizedBox(height: 24),
            
            // Farming Features Section
            _buildFarmingFeaturesSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEditProfileDialog,
        child: const Icon(Icons.edit),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GestureDetector(
      onTap: _changeProfilePicture,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(profileImageUrl),
            child: profileImageUrl.isEmpty
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                userRole,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(userLocation),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Usaha Tani',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildInfoItem(Icons.agriculture, 'Jenis Usaha', farmType),
        _buildInfoItem(Icons.landscape, 'Luas Lahan', landArea),
        _buildInfoItem(Icons.calendar_today, 'Bergabung Sejak', joinDate),
        _buildInfoItem(Icons.description, 'Deskripsi', userBio),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.green[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmingFeaturesSection() {
    // Define farming features data
    final List<FarmingFeature> features = [
      FarmingFeature(
        icon: Icons.wb_sunny,
        title: 'Monitoring Iklim',
        details: 'Suhu: 28°C\nKelembaban: 75%',
      ),
      FarmingFeature(
        icon: Icons.calendar_month,
        title: 'Kalender Tanam',
        details: 'Tanam: 5 Jun\nPanen: 15 Ags',
      ),
      FarmingFeature(
        icon: Icons.attach_money,
        title: 'Catatan Keuangan',
        details: 'Pendapatan: Rp12.5jt\nPengeluaran: Rp8.2jt',
      ),
      FarmingFeature(
        icon: Icons.insights,
        title: 'Analisis Tanah',
        details: 'pH: 6.2\nNitrogen: Sedang',
      ),
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
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            return _buildFeatureCard(
              features[index].icon,
              features[index].title,
              features[index].details,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String details) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 30, color: Colors.green[700]),
            Column(
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
                  details,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Foto Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Foto'),
              onTap: () {
                // Implement camera functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                // Implement gallery picker functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Masukkan URL Gambar'),
              onTap: () {
                Navigator.pop(context);
                _showImageUrlDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImageUrlDialog() {
    TextEditingController urlController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Masukkan URL Gambar'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(hintText: 'https://example.com/image.jpg'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                profileImageUrl = urlController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    TextEditingController nameController = TextEditingController(text: userName);
    TextEditingController roleController = TextEditingController(text: userRole);
    TextEditingController locationController = TextEditingController(text: userLocation);
    TextEditingController farmTypeController = TextEditingController(text: farmType);
    TextEditingController landAreaController = TextEditingController(text: landArea);
    TextEditingController bioController = TextEditingController(text: userBio);

    showDialog(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(labelText: 'Peran/Pekerjaan'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Lokasi'),
              ),
              TextField(
                controller: farmTypeController,
                decoration: const InputDecoration(labelText: 'Jenis Usaha Tani'),
              ),
              TextField(
                controller: landAreaController,
                decoration: const InputDecoration(labelText: 'Luas Lahan'),
              ),
              TextField(
                controller: bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Deskripsi/Bio'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userRole = roleController.text;
                  userLocation = locationController.text;
                  farmType = farmTypeController.text;
                  landArea = landAreaController.text;
                  userBio = bioController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}