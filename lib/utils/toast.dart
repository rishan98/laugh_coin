import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ShowToast{
     void showToastSuccess(String msg){
       Fluttertoast.showToast(
           msg: msg,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 5,
           backgroundColor: Colors.green,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }

     void showToastError(String msg){
       Fluttertoast.showToast(
           msg: msg,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 8,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }


}