import 'package:flutter/material.dart';
import 'package:note_app_sqflite/db.dart';
import 'package:note_app_sqflite/home.dart';

class addNote extends StatefulWidget {
  const addNote({super.key});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Db db = Db();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
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
                      var response = await db.insertData(
                          "INSERT INTO 'notes' ('title','note') values ('${title.text}','${note.text}')");
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
                        "Save",
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
