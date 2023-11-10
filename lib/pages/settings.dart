import 'package:flutter/material.dart';
import 'package:schedorganizer/helpers/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  late SharedPreferences prefs;
  final baseUrlController = TextEditingController();

  void setConfig() async {
    prefs = await SharedPreferences.getInstance();
    String? baseUrl = prefs.getString("baseUrl");

    if (baseUrl != null) {
      baseUrlController.text = baseUrl;
    }
  }

  @override
  void initState() {
    setConfig();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: TextFormField(
              controller: baseUrlController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.link),
                hintText: 'Write your base URL',
                labelText: 'Base URL',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                prefs.setString("baseUrl", baseUrlController.text);
                UI.snackbar(context, "Saved successfully");
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
