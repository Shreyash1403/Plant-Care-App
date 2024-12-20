import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Card(
            child: ListTile(
              title: Text('Shreyash'),
              subtitle: Text('shreyash@example.com'),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (bool value) {}),
          ),
        ],
      ),
    );
  }
}
