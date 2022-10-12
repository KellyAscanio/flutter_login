import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_password_page.dart';
/*widget: es cada objeto que se coloca en la aplicación, genera clases es una clase
Tiene una serie de capaz(Layout)*/
class LoginPage extends StatefulWidget { //se usa cuando se crea algo que pueda cambiar su estado
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible= true;
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();
  //metodo de inicio de sesion
  Future logIn() async{ //se usa future porque no se configura de forma local sino que depende de una maquina.
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    );
  }
  @override /*La anotación @override se aplica a los métodos de instancia, captadores de instancia,
   establecedores de instancia y variables de instancia (campos). */
   void dispose() { // se llama cuando este objeto y su estado se eliminan del árbol de forma permanente y nunca se volverán a construir.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) { /*cuando lo construyo nos dice en que entorno o estado está
  el obj "atrás, en el medio, delante o arriba" */
    return Scaffold( //La arquitectura,distribución de la interfaz, se define en donde va a ser ubicado cada widget.
      backgroundColor: Colors.greenAccent[100],
      body: SafeArea( //body: cuerpo del scaffold, safearea:Un widget que inserta a su hijo con
        // suficiente relleno para evitar intrusiones por parte del sistema operativo.
        child: Center(
          child: SingleChildScrollView( //scroll
          child: Column( //widget flexible permite crear diseños flexibles en dirección vertical ( Column).
            mainAxisAlignment: MainAxisAlignment.center, //MainAxisAlignment alinea sus elementos secundarios verticalmente
            children: [
              const Icon(
                  Icons.switch_access_shortcut_add,
                  size: 100),
              Text('Hola Aprendiz', //El Textwidget le permite crear una serie de texto con estilo dentro de su aplicación.
                style: GoogleFonts.oswald(
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 10), //se usa para establecer restricciones de tamaño para el widget secundario.
              const Text(
                '¡Bienvenido, nos alegra tenerte de vuelta!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20), //se usa para establecer restricciones de tamaño para el widget secundario.
              Padding(//agrega relleno o espacio vacío alrededor de un widget o un montón de widgets.
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField( //entrada de texto
                  controller: _emailController, //controlador para una campo de texto editable
                  obscureText: false, //permite ver el texto.
                  decoration: InputDecoration( //diseño
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Email",
                    fillColor: Colors.grey[200],
                    filled: true
                  ),
                ) ,
              ),
              SizedBox(height: 10),//se usa para establecer restricciones de tamaño para el widget secundario.
              Padding( //agrega relleno o espacio vacío alrededor de un widget o un montón de widgets.
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField( //entrada de texto
                  controller: _passwordController, //controlador para un campo de texto editable.
                  obscureText: true, //no permite ver el texto.
                  decoration: InputDecoration( //diseño
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
              const SizedBox(height: 10), //se usa para establecer restricciones de tamaño para el widget secundario.
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row( //row widget flexible permite crear diseños flexibles en dirección horizontal ( Row).
                    mainAxisAlignment: MainAxisAlignment. end,
                    children: [
                      GestureDetector(/*no tiene una representación visual sino que detecta gestos realizados por el usuario.
                      Cuando el usuario toca el Container, GestureDetectorllama a su onTap()devolución de llamada,
                      en este caso imprimiendo un mensaje a la consola*/
                        onTap: (){ //devolucion de llamada a la pagina especificada
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return ForgotPasswordPage();
                          }
                          ),
                          );
                        },
                        child: const Text( //texto
                            '¿Olvido su contraseña?',
                            style: TextStyle( //diseño
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
                        ),
                      )
                    ],
                  ),
              ),


              const SizedBox(height: 20), //se usa para establecer restricciones de tamaño para el widget secundario.
              Padding( //agrega relleno o espacio vacío alrededor de un widget o un montón de widgets.
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector( //detecta gestos realizados
                  onTap: logIn, //gestiona el inicio de sesión
                child: Container( //caja
                    decoration: BoxDecoration( //diseño
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(//texto centrado
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ))),
                 )
              ),
              const SizedBox(height: 20), //se usa para establecer restricciones de tamaño para el widget secundario.
              Row( //row widget flexible permite crear diseños flexibles en dirección horizontal ( Row).
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget> [
                  const Text('¿No tiene cuenta?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 GestureDetector( //detector de gestos
                  onTap: widget.showRegisterPage, //devolucion de llamada
                  child: const Text('¡Registrese ahora!', //text
                    style: TextStyle(//diseño
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