// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mis_libros/pages/register_page.dart';
import 'package:mis_libros/repository/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _email = TextEditingController();
final _password = TextEditingController();

User userLoad = User.Empty();

  final FireBaseApi _fireBaseApi = FireBaseApi();

  @override
  void initState(){
   // _getUser();
    super.initState();
  }
    _getUser() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
      //userLoad = User.fromJson(userMap);
    }

     void _showMsg(String msg){
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(content: Text(msg),
      action: SnackBarAction(label: 'Aceptar', onPressed: Scaffold.hideCurrentSnackBar,)
      )
      );
  }

  void _validateUser() async{
    if(_email.text.isEmpty || _password.text.isEmpty){
      _showMsg("Debe digitar correo y contraseña");
      
    }else{
      var result = await _fireBaseApi.loginUser(_email.text, _password.text);
      String msg = "";

    switch (result) {
      case "invalid-email": {msg="Correo electrónico no válido ";
    _showMsg(msg);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));}
      break;
    case "wrong-password" : {msg = "Correo o contraseña inválida";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));}
      break;
    
    case "network-request-failed" : {msg = "No se pudo conectar, revise su conexión a internet";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));}
      break;
    default: {msg = "Ingreso exitoso, Bienvenido ";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));}
    break;
  }

      
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 100, height: 100,
              ),
              const SizedBox(height: 16.0,),

              Text("MIS LIBROS"),

              //EMAIL BOX
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
              ),

              //PASSWORD
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Contraseña'),
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(
                height: 16.0,
              ),

              ElevatedButton(
                  onPressed: () {
                    _validateUser();
                  }, child: const Text('Iniciar sesión')),

              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: const Text('Registrese'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
