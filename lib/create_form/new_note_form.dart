import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes_app/create_form/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key});

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  var _titleC = TextEditingController();
  var _descrC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva nota"),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          if (notesProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else
            return Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  SizedBox(height: 24),
                  notesProvider.getSelectedImage != null
                      ? Image.file(notesProvider.getSelectedImage!)
                      : Container(),
                  TextField(
                    controller: _titleC,
                    decoration: InputDecoration(
                      label: Text("Title"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: _descrC,
                    decoration: InputDecoration(
                      label: Text("Descripcion"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(height: 24),
                  MaterialButton(
                    child: Text("Seleccionar imagen"),
                    onPressed: () {
                      // TODO: hacer que el provider abra camara para tomar foto
                    },
                  ),
                  MaterialButton(
                    child: Text("Guardar"),
                    onPressed: () async {
                      Map<String, dynamic> noteContent = {};
                      noteContent = {
                        "color": "${Colors.green.toString()}",
                        "createdAt": Timestamp.fromDate(DateTime.now()),
                        "type": "normal",
                        "userId": FirebaseAuth.instance.currentUser!.uid,
                        "data": {
                          "audios": [],
                          "images": [],
                          "details": _descrC.text,
                          "title": _titleC.text,
                        }
                      };
                      notesProvider.createNewNote(noteContent).then((success) {
                        if (success) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Guardado con exito!!"),
                              ),
                            );
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("No se pudo guardar!!"),
                              ),
                            );
                        }
                      });
                    },
                  )
                ],
              ),
            );
        },
      ),
    );
  }
}
