import 'package:flutter/material.dart';

Widget emptyStringPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Warning!!!',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Please speak something to search."),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Close',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget noMatchPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Not Found!!!',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Sorry. No matching song found."),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Close',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget noInternetPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Error!!!',
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Not Connected to Internet.",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Close',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget noPreviewPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'OOOPS!!!',
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Sorry. The Preview for this song is not available yet."),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Close',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
