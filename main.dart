import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fuldata_base/screen/retriew.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  runs(),
    );
  }
}

class runs extends StatefulWidget {
  const runs({super.key});

  @override
  State<runs> createState() => _runsState();
}

class _runsState extends State<runs> {
  final key_1 = GlobalKey<FormState>();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> adds() async {
    try {
      var url = "http://10.0.2.2/full/full_table.php";
      var response = await http
          .post(Uri.parse(url), body: {"user": t1.text, "pass": t2.text});
      var res = jsonDecode(response.body);
      if (res == true) {
        t1.clear();
        t2.clear();
        // ignore: use_build_context_synchronously
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "Record is Successfully Added");
      }
    } catch (e) {}
  }

  Widget txt1() {
    return TextFormField(
      controller: t1,
      validator: (value) {
        if (value == null || value.length < 2) {
          return ('empty');
        }
        return null;
      },
    );
  }

  Widget txt2() {
    return TextFormField(
      controller: t2,
      validator: (value) {
        if (value == null || value.length < 1) {
          return ('empty');
        }
        return null;
      },
    );
  }

  Widget btn_submit() {
    return ElevatedButton(
        onPressed: () {
          if (key_1.currentState!.validate()) {
            key_1.currentState!.save();
            adds();
          }
        },
        child: Text('Submit'));
  }

  Widget btn_retriw() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => retriew()),
          );
        },
        child:const Text("view"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: key_1,
          child: Column(
            children: [txt1(), txt2(), btn_submit(), btn_retriw()],
          ),
        ),
      ),
    );
  }
}
