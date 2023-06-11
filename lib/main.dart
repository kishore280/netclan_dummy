import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _navigateToDisplayPage() {
    final name = _nameController.text;
    final location = _locationController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(name: name, location: location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _navigateToDisplayPage,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final List<String> availabilityOptions = [
    'Availble | Hey Let Us Connect',
    'Away | Stay Discreet And Watch',
    'Busy | Do Not Disturb | Will Catch Up Later',
    'SOS | Emergency!Need Assistance!HELP',
  ];
  String? _selectedOption;

  final List<String> purposeOptions = [
    'Coffee',
    'Business',
    'Hobbies',
    'Frienship',
    'Movies',
    'Dining',
    'Dating',
  ];
  List<bool> _selectedPurpose = List.filled(7, false);

  TextEditingController _statusController = TextEditingController();
  int _characterCount = 0;
  int _maxCharacters = 250;
  int _selectedDistance = 50;

  @override
  void initState() {
    super.initState();
    _statusController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _statusController.removeListener(_updateCharacterCount);
    _statusController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _statusController.text.length;
    });
  }

  void _onDistanceChanged(double value) {
    setState(() {
      _selectedDistance = value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refine'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Availability',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text(
                        'Select an option',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ...availabilityOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: 12),
              Text(
                'Add Your Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _statusController,
                maxLength: _maxCharacters,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your status',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$_characterCount/$_maxCharacters',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 12),
              Text(
                'Select Hyper local Distance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Slider(
                min: 1,
                max: 300,
                value: _selectedDistance.toDouble(),
                onChanged: _onDistanceChanged,
                divisions: 99,
                label: '$_selectedDistance km',
                onChangeStart: (double value) {
                  setState(() {
                    _selectedDistance = value.round();
                  });
                },
                onChangeEnd: (double value) {
                  setState(() {
                    _selectedDistance = value.round();
                  });
                },
                activeColor: Colors.green.shade300,
                inactiveColor: Colors.grey,
              ),
              SizedBox(height: 8),
              Text('Selected Distance: $_selectedDistance km'),

              SizedBox(height: 12),
              Text(
                'Select Purpose',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(purposeOptions.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedPurpose[index] = !_selectedPurpose[index];
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (_selectedPurpose[index]) {
                            return Colors.green.shade300;
                          }
                          return Colors.grey;
                        }),
                        minimumSize: MaterialStateProperty.all<Size>(Size(80, 30)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                      child: Text(
                        purposeOptions[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous page
                  },
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    minimumSize: MaterialStateProperty.all<Size>(Size(180, 40)),
                  ),
                  child: Text(
                    'Save & Explore',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








class DisplayPage extends StatefulWidget {
  final String name;
  final String location;

  const DisplayPage({required this.name, required this.location});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}
enum NoteSection {
  Personal,
  Business,
  Merchant,
}


class _DisplayPageState extends State<DisplayPage>
    with SingleTickerProviderStateMixin {
  String _name = '';
  String _location = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _location = widget.location;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _editName(BuildContext context) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String newName = '';
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = newName;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editLocation(BuildContext context) async {
    final newLocation = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String newLocation = '';
        return AlertDialog(
          title: Text('Edit Location'),
          content: TextField(
            onChanged: (value) {
              newLocation = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _location = newLocation;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addCard() async {
  final newCardData = await showDialog<NoteCardData>(
    context: context,
    builder: (BuildContext context) {
      String username = '';
      String userLocation = '';
      String note = '';
      String? photoUrl;

      Future<void> _pickImage() async {
        final imagePicker = ImagePicker();
        final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          setState(() {
            photoUrl = pickedImage.path;
          });
          
        }
      }

      return SingleChildScrollView(
        child: AlertDialog(
          title: Text('Add Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: photoUrl != null
                    ? Image.file(
                        File(photoUrl!),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                onChanged: (value) {
                  userLocation = value;
                },
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                onChanged: (value) {
                  note = value;
                },
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newCard = NoteCardData(
                  username: username,
                  userLocation: userLocation,
                  note: note,
                  photoUrl: photoUrl,
                );
                if (_tabController.index == 0) {
                  setState(() {
                    _personalCards.add(newCard);
                  });
                } else if (_tabController.index == 1) {
                  setState(() {
                    _businessCards.add(newCard);
                  });
                } else if (_tabController.index == 2) {
                  setState(() {
                    _merchantCards.add(newCard);
                  });
                }
                Navigator.pop(context, newCard);
              },
              child: Text('Add'),
            ),
          ],
        ),
      );
    },
  );
}







  Future<void> _showOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.note_add),
                title: Text('Add Notes'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Add Notes action
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text('Jobs'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Jobs action
                },
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Groups'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Groups action
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Dating'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle Dating action
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Howdy $_name !!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(
                  _location,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,MaterialPageRoute(builder: (context)=>NewScreen()),
                ).then((value) => {null});
              // Handle refine action
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Personal'),
            Tab(text: 'Business'),
            Tab(text: 'Merchant'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade300,
              ),
              child: Text(
                _name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Name'),
              onTap: () => _editName(context),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Edit Location'),
              onTap: () => _editLocation(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle Settings action
              },
            ),
            ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
          );
        },
      ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'All Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Personal section
                  Container(
                    child: ListView.builder(
                      itemCount: _personalCards.length,
                      itemBuilder: (context, index) {
                        final noteCardData = _personalCards[index];
                        return NoteCard(data: noteCardData);
                      },
                    ),
                  ),
                  // Business section
                  Container(
                    child: ListView.builder(
                      itemCount: _businessCards.length,
                      itemBuilder: (context, index) {
                        final noteCardData = _businessCards[index];
                        return NoteCard(data: noteCardData);
                      },
                    ),
                  ),
                  // Merchant section
                  Container(
                    child: ListView.builder(
                      itemCount: _merchantCards.length,
                      itemBuilder: (context, index) {
                        final noteCardData = _merchantCards[index];
                        return NoteCard(data: noteCardData);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
    _addCard();
  },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Handle Home action
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Handle Search action
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle Notifications action
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle Settings action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final NoteCardData data;

  const NoteCard({required this.data});

  double _generateRandomValue() {
    final random = Random();
    return random.nextDouble();
  }

  String _generateRandomDistance() {
    final random = Random();
    final minValue = random.nextInt(500);
    final maxValue = minValue + random.nextInt(500);
    return 'Within $minValue-$maxValue m';
  }

  @override
  Widget build(BuildContext context) {
    final randomValue = _generateRandomValue();
    final randomDistance = _generateRandomDistance();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (data.photoUrl != null)
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      backgroundImage: FileImage(File(data.photoUrl!)),
                    ),
                  ),
                if (data.assetPath != null)
                  Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(data.assetPath!),
                      radius: 24.0,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        data.userLocation,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              randomDistance,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: randomValue,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade200),
            ),
            SizedBox(height: 8),
            Text(data.note),
          ],
        ),
      ),
    );
  }
}


class NoteCardData {
  final String username;
  final String userLocation;
  final String note;
  final String? photoUrl; // Added field for photo URL
  final String? assetPath;

  NoteCardData({
    required this.username,
    required this.userLocation,
    required this.note,
    this.photoUrl,
    this.assetPath, // Initialize the field with null
  });
}

List<NoteCardData> _personalCards = [
  NoteCardData(
    username: 'John Doe',
    userLocation: 'New York, USA',
    note: 'Remember to buy groceries.',
    assetPath: 'images/as.jpg'
    ),
  NoteCardData(
    username: 'Jane Smith',
    userLocation: 'London, UK',
    note: 'Call mom for her birthday.',
    assetPath: 'images/ass.jpg'
  ),
];

List<NoteCardData> _businessCards = [
  NoteCardData(
    username: 'David Johnson',
    userLocation: 'San Francisco, USA',
    note: 'Prepare presentation for client meeting.',
    assetPath: 'images/ass.jpg'
  ),
  NoteCardData(
    username: 'Emily Brown',
    userLocation: 'Sydney, Australia',
    note: 'Follow up with potential leads.',
    assetPath:'images/as.jpg'
  ),
];

List<NoteCardData> _merchantCards = [
  NoteCardData(
    username: 'Michael Lee',
    userLocation: 'Tokyo, Japan',
    note: 'Order new inventory for the store.',
    assetPath:'images/as.jpg'
  ),
  NoteCardData(
    username: 'Sophia Garcia',
    userLocation: 'Mexico City, Mexico',
    note: 'Promote special discount offers.',
    assetPath:'images/ass.jpg'
  ),
];

void main() {
  runApp(MaterialApp(
    title: 'Netclan',
    debugShowCheckedModeBanner: false,
   theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green, // 60% Green
          onPrimary: Colors.white,
          secondary: Colors.white, // 30% White
          onSecondary: Colors.black,
          error: Colors.yellow, // 10% Yellow
          onError: Colors.black,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.grey,
          onSurface: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green, // 60% Green
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // 60% Green
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        // progressBarTheme: ProgressBarThemeData(
        //   color: Colors.green, // 60% Green
        // ),
      ),
    home: LoginPage(),
  ));
}
