import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class FirestoreExample extends StatefulWidget {
  const FirestoreExample({super.key});

  @override
  State<FirestoreExample> createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference users = firestore.collection('users');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'full name',
              labelText: 'full name',
            ),
            controller: fullNameController,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'company',
              labelText: 'company',
            ),
            controller: companyController,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'age',
              labelText: 'age',
            ),
            controller: ageController,
          ),
          TextButton(
            onPressed: () {
              users.add({
                'full_name': fullNameController.text,
                'company': companyController.text,
                'age': ageController.text,
              });
            },
            child: Text(
              "Add User",
            ),
          ),
        ],
      ),
    );
  }
}
