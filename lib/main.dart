import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _stagiaires =
      FirebaseFirestore.instance.collection('stagiaires');

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _num_telController = TextEditingController();
  Future<Void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nomController.text = documentSnapshot['nom'];
      _prenomController.text = documentSnapshot['prenom'];
      _mailController.text = documentSnapshot['mail'];
      _num_telController.text = documentSnapshot['num_tel'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                //prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prenom'),
                ),
                TextField(
                  controller: _mailController,
                  decoration: const InputDecoration(labelText: 'Mail'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _num_telController,
                  decoration: const InputDecoration(
                    labelText: 'num_tel',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String nom = _nomController.text;
                    final String prenom = _prenomController.text;
                    final String mail = _mailController.text;
                    final double? num_tel =
                        double.tryParse(_num_telController.text);
                    if (num_tel != null) {
                      await _stagiaires.doc(documentSnapshot!.id).update({
                        "nom": nom,
                        "prenom": prenom,
                        "mail": mail,
                        "num_tel": num_tel
                      });
                      _nomController.text = '';
                      _prenomController.text = '';
                      _mailController.text = '';
                      _num_telController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
    throw FormatException();
  }

  Future<Void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nomController.text = documentSnapshot['nom'];
      _prenomController.text = documentSnapshot['prenom'];
      _mailController.text = documentSnapshot['mail'];
      _num_telController.text = documentSnapshot['num_tel'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                //prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prenom'),
                ),
                TextField(
                  controller: _mailController,
                  decoration: const InputDecoration(labelText: 'Mail'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _num_telController,
                  decoration: const InputDecoration(
                    labelText: 'num_tel',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String nom = _nomController.text;
                    final String prenom = _prenomController.text;
                    final String mail = _mailController.text;
                    final double? num_tel =
                        double.tryParse(_num_telController.text);
                    if (num_tel != null) {
                      await _stagiaires.add({
                        "nom": nom,
                        "prenom": prenom,
                        "mail": mail,
                        "num_tel": num_tel
                      });
                      _nomController.text = '';
                      _prenomController.text = '';
                      _mailController.text = '';
                      _num_telController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
    throw FormatException();
  }

  Future<Void> _delete(String productId) async {
    await _stagiaires.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully ddeleted a product')));
    throw FormatException();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: _stagiaires.snapshots(), //build cnx
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: ((context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                      title: Text(documentSnapshot['nom']['prenom']['mail']),
                      subtitle: Text(documentSnapshot['num_tel'].toString()),
                      trailing: SizedBox(
                          width: 100,
                          child: Row(children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id))
                          ]))),
                );
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
