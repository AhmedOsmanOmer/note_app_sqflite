import 'package:flutter/material.dart';
import 'package:note_app_sqflite/db.dart';
import 'package:note_app_sqflite/login.dart';
import 'package:note_app_sqflite/main.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});
  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController pin = TextEditingController();
  TextEditingController cpin = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue[50],
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/note.png"),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    obscureText: _passwordVisible,
                    keyboardType: TextInputType.number,
                    controller: pin,
                    validator: (val) {
                      if (val == null) {
                        return "PIN Required";
                      } else if (val.length < 4) {
                        return "Short PIN";
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      label: const Text("PIN"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    obscureText: _passwordVisible,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val != pin.text) {
                        return "PIN Not Match";
                      } else if (val == null) {
                        return "PIN Required";
                      }
                    },
                    controller: cpin,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      label: const Text("Confirm PIN"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                      onTap: () {
                        final formState = formKey.currentState;
                        if (formState!.validate()) {
                          formState.save();
                          pref.setString('pin', pin.text);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const Login()),
                              (route) => false);
                        }
                      },
                      child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
