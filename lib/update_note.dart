import 'package:flutter/material.dart';
import 'package:note_app_sqflite/db.dart';
import 'package:note_app_sqflite/home.dart';

class UpdateNote extends StatefulWidget {
  final int id;
  final String title;
  final String note;
  const UpdateNote(
      {super.key, required this.id, required this.title, required this.note});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Db db = Db();
  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue[50],
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    if (val == "") {
                      return "Note Required";
                    }
                  },
                  controller: title,
                  decoration: InputDecoration(
                    label: const Text("Note"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val == "") {
                      return "Title Required";
                    }
                  },
                  controller: note,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(fontSize: 20),
                    label: const Text("Note Title"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  maxLines: 15, //or null
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final formState = formKey.currentState;
                    if (formState!.validate()) {
                      formState.save();
                      var response = await db.updateData(
                          "Update 'notes' SET 'title'='${title.text}','note'='${note.text}' WHERE id=${widget.id}");
                      var res2 = await db.readData("SELECT * FROM notes");
                      print(res2);
                      Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const Home()),
                              (route) => false);
                    }
                  },
                  child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
