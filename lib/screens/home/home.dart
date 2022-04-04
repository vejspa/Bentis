import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/%20services/auth.dart';
import 'package:untitled/%20services/database.dart';
import 'package:untitled/models/bentis.dart';
import 'package:untitled/screens/home/bentis_list.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(BuildContext context) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: const Text('botttom sheet'),

        );
      });
    };

    return StreamProvider<List<Bentis1>>.value(
      value: DatabaseService(uid:"").Bentis,
      initialData: [],
      child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Bentis'),
        backgroundColor: Colors.brown[400],
        elevation:0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          TextButton.icon(
            icon:const Icon(Icons.settings),
            label: const Text('settings'),
            onPressed:()=> _showSettingsPanel(context),
          )
        ]
      ),
          body: const BentisList(),
      )
    );
  }
}
