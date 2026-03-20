import 'package:flutter/material.dart';
import 'package:module_a_101/controller/controller.dart';

bool nameleng(String leng) {
  return 2 <= leng.length && leng.length <= 20;
}

bool agetrue(String age) {
  return int.tryParse(age) != null;
}


Widget inputField(BuildContext context, String hint,String err,bool name) {

  return Container(
  width: 300,
  child: TextField(
  controller: name ?  Controller.namecon : Controller.agecon,
    onEditingComplete: () {
    FocusScope.of(context).unfocus();
      if (name ? nameleng(Controller.namecon.text) : agetrue(Controller.agecon.text)){
        Controller.current.value += 1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err),duration: Duration(seconds: 5)));
      }
    },
    style: TextStyle(
      color: Colors.white,
      fontSize: 18
    ),

    decoration: InputDecoration(


      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey)
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 18,

      )
    ),
  ),
);
}