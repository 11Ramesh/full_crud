import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuldata_base/screen/retriew.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class updated extends StatefulWidget {
  String get_x1;
  String get_x2;
  String get_x3;

  updated(this.get_x1, this.get_x2, this.get_x3);
  @override
  State<updated> createState() => _updatedState();
}

class _updatedState extends State<updated> {
  @override
  void initState() {
    x1.text = widget.get_x1;
    x2.text = widget.get_x2;
    x3.text = widget.get_x3;
    super.initState();
  }

  Future<void> updated() async {
    var urli = "http://10.0.2.2/full/table3.php";

    try {
      var res = await http.post(Uri.parse(urli), body: {
        "id": x3.text,
        "user_name": x1.text,
        "user_password": x2.text
      });
      var response = jsonDecode(res.body);
      if (response == true) {
        // ignore: use_build_context_synchronously
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "Record is Successfully Updated");
      }
    } catch (e) {}
  }

  TextEditingController x1 = TextEditingController();
  TextEditingController x2 = TextEditingController();
  TextEditingController x3 = TextEditingController();

  Widget t1() {
    return TextFormField(
      controller: x1,
      validator: (value) {},
    );
  }

  Widget t2() {
    return TextFormField(
      controller: x2,
      validator: (value) {},
    );
  }

  Widget b1() {
    return ElevatedButton(
        onPressed: () {
          updated();
        },
        child: Text("update"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => retriew())));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [t1(), t2(), b1()],
          ),
        ),
      ),
    );
  }
}
