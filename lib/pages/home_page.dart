import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //creamos un array de los usuarios
  List<String> docIds = [];
//realizamos un metodo future el cual nos busca las cuentas y las muestra por pantalla
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Cuentas')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      docIds.add(document.reference.id);
    }));
  }
//initState nos sirve para mantener actualizado
//AAAAAA
  /*@override
  void initState(){
    getDocId();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    //le damos un mejor diseño con Scaffold
    return Scaffold(
      //creamos un header
      appBar: AppBar(
        //centramos en texto el cual va a tener la cuenta de email que ingreso
        title: Center(
          child: Text(
            'Inicio sesion  ${user.email!}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        actions: [
          //Nos devuelve a la hoja principal
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      //lo que hacemos en este body es hacer una lista con los usuarios que tenemos guardados en el firebase
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GetUsername(
                            documentId: docIds[index],
                          ),
                          tileColor: Colors.grey[200],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
