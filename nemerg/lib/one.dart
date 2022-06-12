import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class F extends StatefulWidget {
  F({Key? key}) : super(key: key);

  @override
  State<F> createState() => _FState();
}

class _FState extends State<F> {
  var formstate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Geri bildirim"),),

body: Form(
key:formstate, child: Column(children: [
TextFormField(
autovalidateMode: AutovalidateMode.always,


)

],), 



),




    );
  }
}
