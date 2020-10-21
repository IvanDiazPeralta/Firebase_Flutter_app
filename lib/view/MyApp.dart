import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stateful_app/view/MyApp.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  List<String> lista = ['nombre1', 'nombre2','nombre3'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Móviles',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Primera App'),
          elevation: 1,
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Project').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) return Text("LOADING...");
            if(snapshot.data.documents.length == 0){
              return Center(
                child: Text('No documents'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length(),
              itemBuilder: (BuildContext context, int index){
                DocumentSnapshot data = snapshot.data.documents[index];
                return ListTile(
                  title: Text(
                    data['projectName'],
                  ),
                  subtitle: Text(data['author']),
                  trailing: Text(data['votes'].toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}