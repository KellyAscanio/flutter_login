import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController= TextEditingController();

  Future passwordResert() async{ //se usa future porque no se configura de forma local sino que depende de una maquina.
    var cuentaEmail= _emailController.text.trim();//.trim cadena sin ningún espacio en blanco inicial ni final.
    //implementamos try-catch para controlar errores de email el enviar correos de restablecimiento.
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: cuentaEmail);
      showDialog<void>(
          context: context,
          barrierDismissible: true,// Si puede descartar esta ruta tocando la barrera modal.
          builder: (BuildContext dialogContext){
            return AlertDialog( //Muestra un mensaje o una pantalla
            title: const Text('Recuperación de contraseña'),
              content: Text('Un email fue enviado a la cuenta $cuentaEmail'),
              actions: <Widget> [
                TextButton(
                    child: const Text('Cerrar'),
                    onPressed: (){
                      Navigator.of(dialogContext).pop();
                    },
                ),
              ],
            );
          },
      );
    }
    on FirebaseAuthException catch(e){
      print(e);
      showDialog<void>(
          context: context,
          barrierDismissible: true, //descarta una ruta
          builder: (BuildContext dialogContext){
            return AlertDialog( //Muestra un mensaje o una pantalla
              title: const Text('Firebase Error'),
              content: Text('Email error:$e'),
              actions: <Widget> [
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: (){
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          }
      );
    }

  }

  @override /*La anotación @override se aplica a los métodos de instancia, captadores de instancia,
   establecedores de instancia y variables de instancia (campos). */
  void dispose() { // se llama cuando este objeto y su estado se eliminan del árbol de forma permanente y nunca se volverán a construir.
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( //La arquitectura,distribución de la interfaz, se define en donde va a ser ubicado cada widget.
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ), //barra superior
      body: Column(//widget flexible permite crear diseños flexibles en dirección vertical ( Column).
        mainAxisAlignment: MainAxisAlignment.center, //alineación
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Text(
                'Ingrese su email para enviarle un email de restablecimiento de contraseña.',
                textAlign:  TextAlign.center,
                style: TextStyle(fontSize: 20),
            )
          ),
          const SizedBox(height: 10), //se usa para establecer restricciones de tamaño para el widget secundario.
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
          const SizedBox(height: 14), //se usa para establecer restricciones de tamaño para el widget secundario.
          MaterialButton(onPressed:passwordResert,
            color: Colors.deepPurple[200],
            child: const Text('Restablecer contraseña',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            ),
          )
        ],

      ),
    );
  }
}
