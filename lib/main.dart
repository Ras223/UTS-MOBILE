import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 254, 254, 254),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Campus {
  final String name;
  final String imageUrl;
  final String description;

  Campus({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExplorePage()),
                );
              },
              child: const Text('Explore'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text('Profile'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  final List<Campus> campuses = [
    Campus(
      name: 'ITI',
      imageUrl: 'asset/iti.jpg',
      description:
          'Institut Teknologi Indonesia merupakan perguruan tinggi swasta yang berlokasi di Kecamatan Setu, Kota Tangerang Selatan',
    ),
    Campus(
      name: 'UNPAM',
      imageUrl: 'asset/pam.jpg',
      description:
          'Universitas Pamulang disingkat UNPAM adalah salah satu perguruan tinggi swasta terbesar di Banten. Universitas Pamulang merupakan perguruan tinggi yang dikelola oleh Yayasan Sasmita Jaya yang didirikan oleh Dr. H. Darsono',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CampusSearchDelegate(campuses),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: campuses.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    campuses[index].imageUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    campuses[index].name,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    campuses[index].description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampusDetailPage(
                      campusName: campuses[index].name,
                      imageUrl: campuses[index].imageUrl,
                      description: campuses[index].description,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CampusSearchDelegate extends SearchDelegate<Campus?> {
  final List<Campus> campuses;

  CampusSearchDelegate(this.campuses);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final filteredCampuses = campuses
        .where(
            (campus) => campus.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredCampuses.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredCampuses[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CampusDetailPage(
                  campusName: filteredCampuses[index].name,
                  imageUrl: filteredCampuses[index].imageUrl,
                  description: filteredCampuses[index].description,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CampusDetailPage extends StatelessWidget {
  final String campusName;
  final String imageUrl;
  final String description;

  const CampusDetailPage({
    Key? key,
    required this.campusName,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campusName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              campusName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(), // This will push the button to the bottom
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TourPage(campusName: campusName),
                    ),
                  );
                },
                child: Text('Tour This Campus'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourPage extends StatefulWidget {
  final String campusName;

  const TourPage({super.key, required this.campusName});

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  bool hasBoughtFood = false;
  bool hasAllergy = false;
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour ${widget.campusName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Apakah kamu membeli makanan?'),
              value: hasBoughtFood,
              onChanged: (bool? value) {
                setState(() {
                  hasBoughtFood = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Apakah kamu mempunyai alergi?'),
              value: hasAllergy,
              onChanged: (bool? value) {
                setState(() {
                  hasAllergy = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Accept Terms and Conditions'),
              value: acceptTerms,
              onChanged: (bool? value) {
                setState(() {
                  acceptTerms = value ?? false;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: acceptTerms
                  ? () {
                      // Handle confirm booking logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking confirmed!'),
                        ),
                      );
                    }
                  : null, // Disable button if terms are not accepted
              child: Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(' asset\profile.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                'Rizky Aditya Syahputra',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'NIM: 1152200021',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: const Center(
        child: Text('Settings Page Content'),
      ),
    );
  }
}
