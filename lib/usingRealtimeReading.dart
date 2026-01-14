import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimeUsers extends StatelessWidget {
  RealtimeUsers({super.key});

  // Firestore instance (connection to Firebase database)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Realtime Users')),

      // StreamBuilder listens to Firestore changes in real-time
      body: StreamBuilder<QuerySnapshot>(
        // 🔹 This creates a REALTIME listener on the "users" collection
        stream: _firestore.collection('users').snapshots(),

        builder: (context, snapshot) {
          // If something went wrong
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          // While waiting for data from Firestore
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔹 All documents inside "users"
          final usersDocs = snapshot.data!.docs;

          // Display data using ListView (replaces for-loop)
          return ListView.builder(
            itemCount: usersDocs.length,
            itemBuilder: (context, index) {
              // 🔹 One user document
              final user = usersDocs[index];

              return ListTile(
                title: Text(user['name']), // String
                subtitle: Text('Age: ${user['age']}'), // int
                trailing: Icon(
                  user['citizen'] ? Icons.check : Icons.close, // bool
                ),
              );
            },
          );
        },
      ),
    );
  }
}
