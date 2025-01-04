import 'package:flutter/material.dart';


class LoadingIndicatorDialogMessage {
  static final LoadingIndicatorDialogMessage _singleton = LoadingIndicatorDialogMessage._internal();
  late BuildContext _context;
  bool isDisplayed = false;

  factory LoadingIndicatorDialogMessage() {
    return _singleton;
  }

  LoadingIndicatorDialogMessage._internal();

  show(BuildContext context, String text ) {
    if(isDisplayed) {
      return;
    }
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          _context = context;
          isDisplayed = true;
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              children: [
                Center(
                  child: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 7), child: Text(text)),
                    ],
                  ),
                )
              ] ,
            ),
          );
        }
    );
  }

  dismiss() {
    if(isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}