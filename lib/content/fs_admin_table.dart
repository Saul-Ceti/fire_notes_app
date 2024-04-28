import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class FsAdminTable extends StatelessWidget {
  FsAdminTable({super.key});
  // live firestore query
  final tweetCollection = FirebaseFirestore.instance.collection("tweet");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin table"),
      ),
      body: FirestoreDataTable(
        query: tweetCollection,
        columnLabels: {
          "description": Text("Descripcion"),
          "osystem": Text("OS"),
          "picture": Text("Imagen"),
          "public": Text("Visible"),
          "username": Text("Usuario"),
          "stars": Text("Likes"),
          "title": Text("Titulo"),
          "publishedAt": Text("Fecha"),
        },
      ),
    );
  }
}
