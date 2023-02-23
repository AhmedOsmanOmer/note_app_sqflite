import 'package:flutter/material.dart';
import 'package:note_app_sqflite/db.dart';
import 'package:note_app_sqflite/home.dart';
import 'package:note_app_sqflite/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Db db = Db();
  TextEditingController pin = TextEditingController();
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue[50],
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
          child: Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/note.png"),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: pin,
                  keyboardType: TextInputType.number,
                  obscureText: _passwordVisible,
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
                InkWell(
                    onTap: () {
                      if (pref.getString('pin') == pin.text) {
                        pref.setString('log', 'yes');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const Home()),
                            (route) => false);
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          desc: 'Wrong PIN',
                          btnOkOnPress: () {},
                          btnOkColor: Colors.blue,
                        ).show();
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
