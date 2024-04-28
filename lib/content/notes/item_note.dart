import 'package:fire_notes_app/create_form/edit_note_form.dart';
import 'package:fire_notes_app/create_form/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemNote extends StatelessWidget {
  final String noteId;
  final Map<String, dynamic> noteContent;
  
  ItemNote({
    Key? key,
    required this.noteId,
    required this.noteContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditNoteForm(noteContent: noteContent, noteId: noteId)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(noteContent["data"]["title"]),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Eliminar el registro y si esta eliminado mostrar un snackbar
                Provider.of<NotesProvider>(context, listen: false).removeExistingNote(noteId).then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Nota eliminada"),
                      ),
                    );
                  }
                });                
              },
            ),
          ],
        ),
      ),
    );
  }
}
