import 'package:flutter/material.dart';
import 'package:flutter_application/note_model.dart';

class NoteForm extends StatefulWidget {
  final Function(Note) onSubmit;
  final Note? initialNote;

  NoteForm({required this.onSubmit, this.initialNote, Key? key})
      : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    contentController = TextEditingController();

    if (widget.initialNote != null) {
      titleController.text = widget.initialNote!.title ?? '';
      contentController.text = widget.initialNote!.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: contentController,
          decoration: InputDecoration(labelText: 'Content'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(
              Note(
                id: widget.initialNote?.id,

                // id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleController.text,
                content: contentController.text,
                dateTime: DateTime.now(),
              ),
            );
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
