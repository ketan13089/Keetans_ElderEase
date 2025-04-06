// import 'package:f1/data/notifiers.dart';
// import 'package:f1/views/pages/welcome_page.dart';
// import 'package:f1/views/widget_tree.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//  // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(valueListenable: isDarkModeNotifier, builder: (context, isDarkMode, child) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.teal,
//             brightness: isDarkMode ? Brightness.dark:Brightness.light,
//           ),
//         ),
//         home: WelcomePage(),
//       );
//     },);
//   }
// }



//demo code

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const ElderCareApp());
}

class ElderCareApp extends StatelessWidget {
  const ElderCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElderCare Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/vitals': (context) => const VitalsMonitorPage(),
        '/safety': (context) => const SafetyMonitorPage(),
        '/reminders': (context) => const ReminderPage(),
        '/communication': (context) => const CommunicationPage(),
        '/emergency': (context) => const EmergencyAlertPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  bool _textToSpeechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initTextToSpeech();

    // Simulate a reminder notification after 5 seconds
    Timer(const Duration(seconds: 5), () {
      _showReminderNotification("Time to take your blood pressure medication");
    });

    // Simulate a fall detection after 10 seconds
    Timer(const Duration(seconds: 10), () {
      _showFallDetectionAlert();
    });
  }

  Future<void> _initTextToSpeech() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5); // Slower rate for better comprehension
  }

  Future<void> _speak(String text) async {
    if (_textToSpeechEnabled) {
      await flutterTts.speak(text);
    }
  }

  void _toggleTextToSpeech() {
    setState(() {
      _textToSpeechEnabled = !_textToSpeechEnabled;
    });
    _speak(_textToSpeechEnabled
        ? "Text to speech enabled"
        : "Text to speech disabled");
  }

  void _showReminderNotification(String message) {
    _speak(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'VIEW',
          onPressed: () {
            Navigator.pushNamed(context, '/reminders');
          },
        ),
      ),
    );
  }

  void _showFallDetectionAlert() {
    _speak(
        "Fall detected! Emergency services will be notified if you don't respond.");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fall Detected!"),
          content: const Text(
              "We've detected that you may have fallen. Are you okay? If you don't respond within 30 seconds, we'll alert emergency services."),
          actions: [
            TextButton(
              child: const Text("I'm Fine"),
              onPressed: () {
                Navigator.of(context).pop();
                _speak("Alert canceled. Glad you're okay.");
              },
            ),
            TextButton(
              child: const Text("Send Help"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/emergency');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ElderCare Assistant"),
        actions: [
          IconButton(
            icon:
            Icon(_textToSpeechEnabled ? Icons.volume_up : Icons.volume_off),
            onPressed: _toggleTextToSpeech,
            tooltip: "Toggle Text-to-Speech",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Hello, Maria",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            _buildStatusCard(),
            const SizedBox(height: 24),
            _buildFeatureGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusItem(
                    Icons.favorite, "Heart Rate", "72 bpm", Colors.red),
                _buildStatusItem(
                    Icons.thermostat, "Temperature", "98.6°F", Colors.orange),
                _buildStatusItem(
                    Icons.speed, "Blood Pressure", "128/85", Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(
      IconData icon, String title, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 36),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildFeatureCard(
          'Health Monitor',
          'Track vital signs and detect anomalies',
          Icons.health_and_safety,
          Colors.blue,
              () {
            _speak("Opening Health Monitor");
            Navigator.pushNamed(context, '/vitals');
          },
        ),
        _buildFeatureCard(
          'Safety Monitor',
          'Fall detection and emergency alerts',
          Icons.security,
          Colors.red,
              () {
            _speak("Opening Safety Monitor");
            Navigator.pushNamed(context, '/safety');
          },
        ),
        _buildFeatureCard(
          'Reminders',
          'Medication and appointment reminders',
          Icons.calendar_today,
          Colors.green,
              () {
            _speak("Opening Reminders");
            Navigator.pushNamed(context, '/reminders');
          },
        ),
        _buildFeatureCard(
          'Communication',
          'Connect with family and caregivers',
          Icons.chat,
          Colors.purple,
              () {
            _speak("Opening Communication Center");
            Navigator.pushNamed(context, '/communication');
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon,
      Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Health Monitoring - Vitals Page
class VitalsMonitorPage extends StatefulWidget {
  const VitalsMonitorPage({Key? key}) : super(key: key);

  @override
  _VitalsMonitorPageState createState() => _VitalsMonitorPageState();
}

class _VitalsMonitorPageState extends State<VitalsMonitorPage> {
  final FlutterTts flutterTts = FlutterTts();
  List<Map<String, dynamic>> vitalHistory = [
    {
      'timestamp': '08:30 AM',
      'heartRate': 72,
      'bloodPressure': '128/85',
      'temperature': 98.6,
      'status': 'Normal'
    },
    {
      'timestamp': '11:45 AM',
      'heartRate': 78,
      'bloodPressure': '132/87',
      'temperature': 98.8,
      'status': 'Normal'
    },
    {
      'timestamp': '02:15 PM',
      'heartRate': 94,
      'bloodPressure': '145/95',
      'temperature': 99.1,
      'status': 'Warning'
    },
  ];

  bool anomalyDetected = false;

  @override
  void initState() {
    super.initState();

    // Simulate an anomaly detection after 3 seconds
    Timer(const Duration(seconds: 3), () {
      setState(() {
        anomalyDetected = true;
      });
      _showAnomalyAlert();
    });
  }

  void _showAnomalyAlert() {
    flutterTts.speak(
        "Anomaly detected in your vital signs. Your heart rate is elevated.");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Vital Sign Anomaly Detected!"),
          content: const Text(
              "We've detected an elevated heart rate and blood pressure. Are you feeling alright?"),
          actions: [
            TextButton(
              child: const Text("I'm Fine"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Contact Doctor"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/communication');
              },
            ),
            TextButton(
              child: const Text("Emergency"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/emergency');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Monitor"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (anomalyDetected)
              Card(
                color: Colors.red.shade100,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red.shade800, size: 32),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Anomaly detected: Elevated heart rate and blood pressure",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Text(
              "Current Vitals",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildVitalCard("Heart Rate", "94", "bpm",
                      anomalyDetected ? Colors.red : Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVitalCard("Blood Pressure", "145/95", "mmHg",
                      anomalyDetected ? Colors.red : Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildVitalCard(
                      "Temperature", "99.1", "°F", Colors.orange),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVitalCard("SpO2", "97", "%", Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Vital Signs History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildVitalHistoryList(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Update Vital Signs"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Simulate refreshing data
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Refreshing vital signs data...")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, String unit, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 16,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalHistoryList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vitalHistory.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = vitalHistory[index];
          final isWarning = item['status'] == 'Warning';

          return ListTile(
            title: Text(
              "Recorded at ${item['timestamp']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "HR: ${item['heartRate']} bpm | BP: ${item['bloodPressure']} | Temp: ${item['temperature']}°F",
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isWarning ? Colors.red.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item['status'],
                style: TextStyle(
                  color:
                  isWarning ? Colors.red.shade800 : Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Safety Monitoring - Fall Detection
class SafetyMonitorPage extends StatefulWidget {
  const SafetyMonitorPage({Key? key}) : super(key: key);

  @override
  _SafetyMonitorPageState createState() => _SafetyMonitorPageState();
}

class _SafetyMonitorPageState extends State<SafetyMonitorPage> {
  final FlutterTts flutterTts = FlutterTts();

  List<Map<String, dynamic>> safetyEvents = [
    {
      'type': 'Location',
      'status': 'Home',
      'timestamp': '08:30 AM',
      'details': 'Living Room'
    },
    {
      'type': 'Movement',
      'status': 'Active',
      'timestamp': '09:45 AM',
      'details': 'Walking'
    },
    {
      'type': 'Fall Detection',
      'status': 'Alert',
      'timestamp': '10:15 AM',
      'details': 'Possible fall detected'
    },
  ];

  bool monitoringActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Safety Monitor"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    "Fall Detection",
                    monitoringActive ? "Active" : "Inactive",
                    Icons.accessibility_new,
                    monitoringActive ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFeatureCard(
                    "Location Tracking",
                    monitoringActive ? "Active" : "Inactive",
                    Icons.location_on,
                    monitoringActive ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildFeatureCard(
                    "Movement Detection",
                    monitoringActive ? "Active" : "Inactive",
                    Icons.directions_walk,
                    monitoringActive ? Colors.orange : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFeatureCard(
                    "Emergency Button",
                    "Ready",
                    Icons.emergency,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Safety Events",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSafetyEventsList(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(monitoringActive ? Icons.pause : Icons.play_arrow),
              label: Text(
                  monitoringActive ? "Pause Monitoring" : "Resume Monitoring"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor:
                monitoringActive ? Colors.orange : Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  monitoringActive = !monitoringActive;
                });

                flutterTts.speak(monitoringActive
                    ? "Safety monitoring activated"
                    : "Safety monitoring paused");
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.emergency, color: Colors.red),
              label: const Text("EMERGENCY HELP",
                  style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                flutterTts.speak("Emergency help requested");
                Navigator.pushNamed(context, '/emergency');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Safety Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.green.shade800, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "SECURE",
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Current Location:"),
                Text("Home - Living Room",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Last Movement:"),
                Text("2 minutes ago",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Connected Devices:"),
                Text("4 Active", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      String title, String status, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyEventsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: safetyEvents.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final event = safetyEvents[index];
          final isAlert = event['status'] == 'Alert';

          IconData iconData;
          Color iconColor;

          switch (event['type']) {
            case 'Fall Detection':
              iconData = Icons.accessibility_new;
              iconColor = Colors.red;
              break;
            case 'Location':
              iconData = Icons.location_on;
              iconColor = Colors.blue;
              break;
            case 'Movement':
              iconData = Icons.directions_walk;
              iconColor = Colors.green;
              break;
            default:
              iconData = Icons.info;
              iconColor = Colors.grey;
          }

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(iconData, color: iconColor),
            ),
            title: Text(
              "${event['type']} - ${event['timestamp']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(event['details']),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isAlert ? Colors.red.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                event['status'],
                style: TextStyle(
                  color: isAlert ? Colors.red.shade800 : Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Reminders Page
class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final FlutterTts flutterTts = FlutterTts();

  List<Map<String, dynamic>> reminders = [
    {
      'title': 'Take Blood Pressure Medication',
      'time': '08:00 AM',
      'description': 'Lisinopril - 1 tablet with water',
      'completed': true,
      'category': 'Medication'
    },
    {
      'title': 'Doctor Appointment',
      'time': '02:30 PM',
      'description': 'Dr. Johnson - Annual checkup',
      'completed': false,
      'category': 'Appointment'
    },
    {
      'title': 'Take Cholesterol Medication',
      'time': '08:00 PM',
      'description': 'Atorvastatin - 1 tablet with dinner',
      'completed': false,
      'category': 'Medication'
    },
  ];

  @override
  void initState() {
    super.initState();

    // Simulate a new reminder notification
    Timer(const Duration(seconds: 3), () {
      _showReminderNotification("Time to take your medication");
    });
  }

  void _showReminderNotification(String message) {
    flutterTts.speak(message);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.notifications_active, color: Colors.orange.shade700),
              const SizedBox(width: 8),
              const Text("Reminder"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Take Blood Pressure Medication",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text("Lisinopril - 1 tablet with water"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 4),
                  Text("Now", style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Snooze"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Mark as Completed"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  reminders[0]['completed'] = true;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Schedule",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("3 Reminders"),
                        Text(
                          "1 Completed",
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                final bool isCompleted = reminder['completed'] as bool;

                IconData categoryIcon;
                Color categoryColor;

                switch (reminder['category']) {
                  case 'Medication':
                    categoryIcon = Icons.medication;
                    categoryColor = Colors.blue;
                    break;
                  case 'Appointment':
                    categoryIcon = Icons.calendar_today;
                    categoryColor = Colors.purple;
                    break;
                  default:
                    categoryIcon = Icons.notifications;
                    categoryColor = Colors.orange;
                }

                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: categoryColor.withOpacity(0.2),
                      child: Icon(categoryIcon, color: categoryColor),
                    ),
                    title: Text(
                      reminder['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration:
                        isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(reminder['description'] as String),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              reminder['time'] as String,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Checkbox(
                      value: isCompleted,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onChanged: (bool? value) {
                        setState(() {
                          reminder['completed'] = value!;
                        });
                        if (value == true) {
                          flutterTts.speak("Marked as completed");
                        }
                      },
                    ),
                    onTap: () {
                      // Show reminder details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Add new reminder
        },
      ),
    );
  }
}

// Communication Page
class CommunicationPage extends StatefulWidget {
  const CommunicationPage({Key? key}) : super(key: key);

  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage>
    with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late TabController _tabController;

  List<Map<String, dynamic>> contacts = [
    {
      'name': 'Dr. Johnson',
      'role': 'Primary Physician',
      'imageUrl': 'https://via.placeholder.com/150',
      'lastContact': '2 days ago',
      'phone': '(555) 123-4567',
    },
    {
      'name': 'Sarah (Daughter)',
      'role': 'Family',
      'imageUrl': 'https://via.placeholder.com/150',
      'lastContact': '4 hours ago',
      'phone': '(555) 987-6543',
    },
    {
      'name': 'Mike (Caregiver)',
      'role': 'Home Health Aide',
      'imageUrl': 'https://via.placeholder.com/150',
      'lastContact': 'Yesterday',
      'phone': '(555) 456-7890',
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      'sender': 'Sarah (Daughter)',
      'message': 'How are you feeling today?',
      'timestamp': '4 hours ago',
      'isRead': true,
    },
    {
      'sender': 'Dr. Johnson',
      'message': 'Remember to take your blood pressure medication',
      'timestamp': '2 days ago',
      'isRead': true,
    },
    {
      'sender': 'Mike (Caregiver)',
      'message': 'I\'ll be there tomorrow at 10am',
      'timestamp': 'Yesterday',
      'isRead': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Communication"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "CONTACTS"),
            Tab(text: "MESSAGES"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContactsTab(),
          _buildMessagesTab(),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuickContactsRow(),
          const SizedBox(height: 24),
          const Text(
            "All Contacts",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      contact['name'].toString().substring(0, 1),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                  title: Text(
                    contact['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(contact['role'] as String),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "Last contact: ${contact['lastContact']}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chat, color: Colors.blue),
                        onPressed: () {
                          // Open chat
                          _showChatDialog(contact['name'] as String);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.video_call, color: Colors.green),
                        onPressed: () {
                          // Start video call
                          _showVideoCallDialog(contact['name'] as String);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickContactsRow() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    contact['name'].toString().substring(0, 1),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  contact['name'].toString().split(' ')[0],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessagesTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isUnread = !(message['isRead'] as bool);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isUnread ? Colors.blue.shade50 : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor:
                    isUnread ? Colors.blue.shade200 : Colors.grey.shade200,
                    child: Text(
                      message['sender'].toString().substring(0, 1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUnread
                            ? Colors.blue.shade800
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                  title: Text(
                    message['sender'] as String,
                    style: TextStyle(
                      fontWeight:
                      isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(message['message'] as String),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            message['timestamp'] as String,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: isUnread
                      ? Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  )
                      : null,
                  onTap: () {
                    // Open message
                    _showChatDialog(message['sender'] as String);

                    // Mark as read
                    setState(() {
                      message['isRead'] = true;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("New Message"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              // Create new message
            },
          ),
        ),
      ],
    );
  }

  void _showChatDialog(String contactName) {
    flutterTts.speak("Opening chat with $contactName");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      contactName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: const [
                      _ChatBubble(
                        message: "Hello, how are you feeling today?",
                        isUser: false,
                        time: "10:15 AM",
                      ),
                      _ChatBubble(
                        message: "I'm doing well, thank you for asking!",
                        isUser: true,
                        time: "10:17 AM",
                      ),
                      _ChatBubble(
                        message: "Did you take your medication this morning?",
                        isUser: false,
                        time: "10:18 AM",
                      ),
                      _ChatBubble(
                        message: "Yes, I took it at 8:00 AM as scheduled.",
                        isUser: true,
                        time: "10:20 AM",
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // Send message
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVideoCallDialog(String contactName) {
    flutterTts.speak("Starting video call with $contactName");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        contactName.substring(0, 1),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      contactName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("Calling..."),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCallButton(Icons.mic_off, Colors.grey),
                    _buildCallButton(Icons.videocam_off, Colors.grey),
                    _buildCallButton(Icons.volume_up, Colors.grey),
                    _buildCallButton(Icons.call_end, Colors.red, onTap: () {
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCallButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String time;

  const _ChatBubble({
    required this.message,
    required this.isUser,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Emergency Alert Page
class EmergencyAlertPage extends StatefulWidget {
  const EmergencyAlertPage({Key? key}) : super(key: key);

  @override
  _EmergencyAlertPageState createState() => _EmergencyAlertPageState();
}

class _EmergencyAlertPageState extends State<EmergencyAlertPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool _alertSent = false;
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    flutterTts.speak("Emergency mode activated");

    // Start countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
          _sendEmergencyAlert();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _sendEmergencyAlert() {
    if (!_alertSent) {
      setState(() {
        _alertSent = true;
      });

      flutterTts
          .speak("Emergency alert sent to caregivers and emergency services");
    }
  }

  void _cancelEmergencyAlert() {
    _timer?.cancel();
    flutterTts.speak("Emergency alert cancelled");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text("Emergency Alert"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emergency,
                size: 80,
                color: _alertSent ? Colors.red.shade300 : Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                _alertSent
                    ? "Emergency Alert Sent"
                    : "Emergency Alert will be sent in",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (!_alertSent)
                Text(
                  "$_countdown seconds",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
              const SizedBox(height: 24),
              if (_alertSent)
                _buildAlertSentInfo()
              else
                ElevatedButton.icon(
                  icon: const Icon(Icons.cancel),
                  label: const Text("CANCEL EMERGENCY"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _cancelEmergencyAlert,
                ),
              const SizedBox(height: 24),
              if (_alertSent)
                OutlinedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text("Return to Home"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade800,
                    side: BorderSide(color: Colors.red.shade800),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertSentInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Help is on the way!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildNotifiedContact(
                "Emergency Services", "Dispatched", Icons.local_hospital),
            const SizedBox(height: 12),
            _buildNotifiedContact("Dr. Johnson", "Notified", Icons.person),
            const SizedBox(height: 12),
            _buildNotifiedContact(
                "Sarah (Daughter)", "On her way", Icons.family_restroom),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              "Your location and medical information have been shared with emergency responders.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifiedContact(String name, String status, IconData icon) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade800),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.check_circle, color: Colors.green),
      ],
    );
  }
}
