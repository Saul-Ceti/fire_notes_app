import 'package:fire_notes_app/create_form/notes_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNoteForm extends StatefulWidget {
  final String noteId;
  final Map<String, dynamic> noteContent;

  const EditNoteForm({
    super.key, 
    required this.noteId,
    required this.noteContent
  });

  @override
  State<EditNoteForm> createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  var _titleC = TextEditingController();
  var _descrC = TextEditingController();

  @override
  void initState() {
    _titleC.text = widget.noteContent["data"]["title"];
    _descrC.text = widget.noteContent["data"]["details"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar nota"),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          if (notesProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          else{
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
                      label: Text("Titulo"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: _descrC,
                    decoration: InputDecoration(
                      label: Text("Detalles"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(height: 24),
                  MaterialButton(
                    child: Text("Guardar"),
                    onPressed: () async {
                      String noteId = widget.noteId;
                      Map<String, dynamic> noteContent = {};
                      noteContent = {
                        "data": {
                          "title": _titleC.text,
                          "details": _descrC.text,
                        },
                        "userId": FirebaseAuth.instance.currentUser!.uid,
                      };
                      notesProvider.editExistingNote(noteContent, noteId).then((success) {
                        if (success) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Editado con exito!!"),
                              ),
                            );
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("No se pudo editar!!"),
                              ),
                            );
                        }
                      });
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );  
  }
}