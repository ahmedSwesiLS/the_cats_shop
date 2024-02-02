import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreList extends StatelessWidget {
  const FirestoreList();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        // if (snapshot.hasData) {
        //   return Text("Document does not exist");
        // }

        if (snapshot.connectionState == ConnectionState.done) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...snapshot.data!.docs
                        .map((doc) => Text('${doc['full_name']}'))
                        .toList(),
                  ],
                ),
              ),
            ),
          );
        }

        String searchWorkText = 'نج';

        String workType = 'نجار';

        workType.contains(searchWorkText);

        return Text("loading");
      },
    );
  }
}
