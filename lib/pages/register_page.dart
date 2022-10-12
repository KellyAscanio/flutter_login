import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController= TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userProfileController = TextEditingController();
//futuro no se ejecute en este momento sino que se ejecuta más adelante
  Future signIn() async{ //async asincronica envio peticion sin saber si me van a responder
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _userProfileController.text.trim(),
        _emailController.text.trim(),
      );
    }
  }
  //este metodo tambien esta en future por que puede que no lo utilicemos,y cuando lo utilicemos nos guarda la informacion en los campos correspondientes
  Future addUserDetails(
      String firstName,
      String lastName,
      String userProfile,
      String email,
      ) async {
    await FirebaseFirestore.instance.collection('Cuentas').add({
      'first name': firstName,
      'last name': lastName,
      'userProfile': userProfile,
      'email': email
    });
  }

  bool passwordConfirmed(){
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }else{
      return false;
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _userProfileController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text('Hola Aprendiz',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Registre sus datos a continuación',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      //controlamos donde se guardara la informacion
                      controller: _firstNameController,
                      //hacemos un campo de texto el cual tiene un borde tiene fondo blanco y cuando le damos click el borde
                      //pasa a morado y el campo dse ponde de fondo gris
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'First Name',
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Last Name',
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _userProfileController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'User Profile',
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Email",
                          fillColor: Colors.grey[200],
                          filled: true
                      ),
                    ) ,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Password",
                          fillColor: Colors.grey[200],
                          filled: true
                      ),
                    ) ,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Confirm Password",
                          fillColor: Colors.grey[200],
                          filled: true
                      ),
                    ) ,
                  ),


                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signIn, //gestiona el inicio de sesión
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                                child: Text(
                                  'Registrese Ahora',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ))),
                      )
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  <Widget> [
                      const Text(
                        '¡Soy miembro!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text('Inicia Sesión',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );

  }
}
