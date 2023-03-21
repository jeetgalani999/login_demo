import 'package:flutter/material.dart';

class google_home extends StatefulWidget {
  String name;
  String email;
  String url;


  google_home(this.name, this.email, this.url);

  @override
  State<google_home> createState() => _google_homeState();
}

class _google_homeState extends State<google_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
            child: ListTile(
              leading: Image(image: NetworkImage(widget.url)),
            title: Text(widget.name),
              subtitle: Text(widget.email),
            )),
      ),
    );
  }
}
