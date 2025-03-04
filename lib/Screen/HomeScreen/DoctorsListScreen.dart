import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({Key? key}) : super(key: key);

  @override
  _DoctorsListScreenState createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  List<dynamic> doctors = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    const String apiUrl = "https://api-doctor.clingroup.net/api/doctors";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          doctors = json.decode(response.body)['doctors'];
          isLoading = false;
        });
      } else {
        showErrorSnackbar("Failed to load doctors. Status code: ${response.statusCode}");
      }
    } catch (e) {
      showErrorSnackbar("Error: $e");
    }
  }

  Future<void> searchDoctors(String query) async {
    if (query.isEmpty) return;
    final String searchUrl = "https://api-doctor.clingroup.net/api/doctors/search?query=$query";

    try {
      final response = await http.get(Uri.parse(searchUrl));
      if (response.statusCode == 200) {
        setState(() {
          doctors = json.decode(response.body)['doctors'];
        });
      } else {
        showErrorSnackbar("Search failed. Status code: ${response.statusCode}");
      }
    } catch (e) {
      showErrorSnackbar("Search Error: $e");
    }
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Doctors List'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors by name...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchDoctors(_searchController.text.trim()),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : doctors.isEmpty
                    ? const Center(child: Text("No doctors available."))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return DoctorCard(doctor: doctor);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  double doctorRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchDoctorRating();
  }

  Future<void> fetchDoctorRating() async {
    final String doctorId = widget.doctor['id'].toString();
    final String url = "https://api-doctor.clingroup.net/api/doctor/$doctorId/ratings";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          doctorRating = data['average_rating']?.toDouble() ?? 0.0;
        });
      } else {
        debugPrint("Failed to load rating. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching rating: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doctor['name'] ?? 'No Name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text("Specialization: ${widget.doctor['specialization'] ?? 'N/A'}"),
            Text("Email: ${widget.doctor['email'] ?? 'N/A'}"),
            Text("License Number: ${widget.doctor['license_number'] ?? 'N/A'}"),
            Text("Verified: ${widget.doctor['is_verified'] == 1 ? 'Yes' : 'No'}"),
            const SizedBox(height: 10),
            RatingBarIndicator(
              rating: doctorRating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 25.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}
