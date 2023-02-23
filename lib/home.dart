import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app_sqflite/add_note.dart';
import 'package:note_app_sqflite/db.dart';
import 'package:note_app_sqflite/update_note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Db db = Db();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const addNote()),
                  );
                })),
        appBar: AppBar(
          title: const Text("Your Notes"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.blue[50],
              child: FutureBuilder(
                  future: db.readData("SELECT * FROM notes"), // async work
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data);
                            print("====================");
                            return Dismissible(
                              onDismissed: (DismissDirection direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm"),
                                      content: const Text(
                                          "Are you sure you wish to delete this item?"),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () async {
                                              await db.deleteData(
                                                  "DELETE FROM 'notes' WHERE id=${snapshot.data[index]['id']}");
                                              var res2 = await db.readData(
                                                  "SELECT * FROM notes");
                                              setState(() {});
                                              print(res2);
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text("DELETE")),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                            setState(() {});
                                          },
                                          child: const Text("CANCEL"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              direction: DismissDirection.endToStart,
                              key: UniqueKey(),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => UpdateNote(
                                              id: snapshot.data[index]['id'],
                                              note: snapshot.data[index]
                                                  ['note'],
                                              title: snapshot.data[index]
                                                  ['title'])),
                                    );
                                  },
                                  leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/note.png')),
                                  title: Text(snapshot.data[index]['title']),
                                  subtitle: Text(snapshot.data[index]['note'],
                                      maxLines: 1),
                                ),
                              ),
                            );
                          });

                      // return Text("data exist");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}
