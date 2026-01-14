import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}*/

class FirestoreExample extends StatelessWidget {
  FirestoreExample({super.key});

  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  // 🔹 ADD (auto ID)
  Future<void> addUser() async {
    await users.add({
      'name': 'Jimi',
      'role': 'Mobile Engineer',
      'age': 24,
      'skills': ['Flutter'],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 SET (manual ID)
  Future<void> setUser() async {
    await users.doc('user_1').set({'name': 'Jimi', 'role': 'Flutter Dev'});
  }

  // 🔹 SET with MERGE
  Future<void> mergeUser() async {
    await users.doc('user_1').set({'age': 25}, SetOptions(merge: true));
  }

  // 🔹 UPDATE
  Future<void> updateUser() async {
    await users.doc('user_1').update({
      'role': 'Senior Flutter Dev',
      'age': FieldValue.increment(1),
    });
  }

  // 🔹 ARRAY ADD
  Future<void> addSkill() async {
    await users.doc('user_1').update({
      'skills': FieldValue.arrayUnion(['Firebase']),
    });
  }

  // 🔹 ARRAY REMOVE
  Future<void> removeSkill() async {
    await users.doc('user_1').update({
      'skills': FieldValue.arrayRemove(['Flutter']),
    });
  }

  // 🔹 DELETE
  Future<void> deleteUser() async {
    await users.doc('user_1').delete();
  }

  // 🔹 READ ONCE
  Future<void> readUsersOnce() async {
    QuerySnapshot snapshot = await users.get();
    for (var doc in snapshot.docs) {
      debugPrint(doc.data().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Methods')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: addUser, child: const Text('Add')),
            ElevatedButton(onPressed: setUser, child: const Text('Set')),
            ElevatedButton(
              onPressed: mergeUser,
              child: const Text('Set Merge'),
            ),
            ElevatedButton(onPressed: updateUser, child: const Text('Update')),
            ElevatedButton(onPressed: addSkill, child: const Text('Array Add')),
            ElevatedButton(
              onPressed: removeSkill,
              child: const Text('Array Remove'),
            ),
            ElevatedButton(onPressed: deleteUser, child: const Text('Delete')),
            ElevatedButton(onPressed: readUsersOnce, child: const Text('Read')),
          ],
        ),
      ),
    );
  }
}
