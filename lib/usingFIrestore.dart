import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsingFirestore extends StatelessWidget {
  UsingFirestore({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    debugPrint(_firestore.collection('Users').id);
    debugPrint(
      _firestore.collection('Users').doc().id,
    ); //don't do this in the add method because the ID isn't known until after the add is complete
    return Scaffold(
      appBar: AppBar(title: const Text('Cloud Firestore')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                addData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Add Data(Add)', style: TextStyle(fontSize: 25)),
            ),
            ElevatedButton(
              onPressed: () {
                setData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Add Data(Set)', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }

  void addData() async {
    // Function to add data to Firestore
    Map<String, dynamic> addedUser = <String, dynamic>{};
    addedUser['name'] = 'Rose';
    addedUser['age'] = 20;
    addedUser['citizen'] = true;
    addedUser['address'] = {'country': 'Canada', 'city': 'Ottawa'};
    addedUser['visited countries'] = FieldValue.arrayUnion([
      'Russia',
      'Brazil',
      'China',
    ]);
    addedUser['dateTime'] = FieldValue.serverTimestamp();
    await _firestore.collection('users').add(addedUser);
  }

  void setData() async {
    var newId = _firestore.collection('users').doc().id;
    await _firestore.doc('users/$newId').set({
      'name': 'David',
      'job': 'Doctor',
      'id': newId,
    }); //a doc is created with a new ID
    await _firestore.doc('users/6h9qOch8r4yxSRX7fwfK').set({
      'job': 'student',
      'age': FieldValue.increment(2), //increments and decrements are possible
    }, SetOptions(merge: true));
  }

  void updateData() async {
    await _firestore.doc('users/6h9qOch8r4yxSRX7fwfK').update({
      'job': 'Teacher',
      'name': 'Olivia',
      'gender': 'woman',
    });
  }

  void deleteData() async {
    await _firestore.doc('users/6h9qOch8r4yxSRX7fwfK').update({
      'gender': FieldValue.delete(),
    });
    //await _firestore.doc('users/6h9qOch8r4yxSRX7fwfK').delete();
  }

  void readDataOneTime() async {
    var usersData = await _firestore.collection('users').get();
    debugPrint(usersData.size.toString());
  }
}
