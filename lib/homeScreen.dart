import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("CountryName").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data[index];
                    return ListTile(
                      title: Text(data["Name"]),
                    );
                  });
            }));
  }
}
