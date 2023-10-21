import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fuldata_base/main.dart';
import 'package:http/http.dart' as http;
import 'package:fuldata_base/screen/update.dart';

class retriew extends StatefulWidget {
  @override
  State<retriew> createState() => _retriewState();
}

class _retriewState extends State<retriew> {
  List userdata = [];

  Future<void> start() async {
    var url = "http://10.0.2.2/full/full1.php";
    var responce = await http.get(Uri.parse(url));
    setState(() {
      userdata = jsonDecode(responce.body);
    });
  }

  Future<void> deleted(String id) async {
    var urli = "http://10.0.2.2/full/full2.php";

    try {
      var res = await http.post(Uri.parse(urli), body: {
        "id": id,
      });
      var respon = jsonDecode(res.body);
      if (respon == true) {
        start();
      }
    } catch (e) {}
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => runs())));
            },
          ),
        ),
        body: ListView.builder(
            itemCount: userdata.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => updated(
                                  userdata[index]["user_name"],
                                  userdata[index]["user_password"],
                                  userdata[index]["user_id"])));
                    },
                    title: Text(userdata[index]["user_name"]),
                    subtitle: Text(userdata[index]["user_password"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleted(userdata![index]["user_id"]);
                      },
                    )),
              );
            }));
  }
}
