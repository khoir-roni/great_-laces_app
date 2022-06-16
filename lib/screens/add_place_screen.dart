import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = 'Add Place Screen';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        children: [
          Text('User Inputs....'),
          RaisedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("Add Place"),
          )
        ],
      ),
    );
  }
}
