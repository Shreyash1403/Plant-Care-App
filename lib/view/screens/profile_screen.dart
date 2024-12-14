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
          Card(
            child: ListTile(
              title: const Text('Shreyash'),
              subtitle: const Text('shreyash@example.com'),
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (bool value) {}),
          ),
        ],
      ),
    );
  }
}
