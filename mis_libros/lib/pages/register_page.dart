// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_libros/repository/firebase_api.dart';
//import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { masculino, femenino }

class _RegisterPageState extends State<RegisterPage> {

  final FireBaseApi _firebaseApi = FireBaseApi();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
 

  Genre? _genre = Genre.masculino;

  bool _aventura = false;
  bool _fantasia = false;
  bool _terror = false;

  String buttonMsg = "Fecha de nacimiento";
  String _date = "";

  String _dateConverter(DateTime newDate){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }
  void _showSelectDate() async{
    final DateTime? newDate = await showDatePicker(context: context, initialDate: DateTime(2022,8), 
                                                  firstDate: DateTime(1900,1), 
                                                  lastDate: DateTime(2022,12),
                                                  helpText: "Fecha de nacimiento");
    if(newDate !=null){
      setState(() {
        _date = _dateConverter(newDate);
        buttonMsg = "Fecha de nacimiento: ${_date.toString()}";
      });
    }
  }

  void _showMsg(String msg){
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(content: Text(msg),
      action: SnackBarAction(label: 'Aceptar', onPressed: Scaffold.hideCurrentSnackBar,)
      )
      );
  }

void _saveUser(User user) async {
  var result = await _firebaseApi.createUser(user);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));

}

//SALVAR UN NUEVO USUARIO EN LA PAGINA DE REGISTRO
  void _registerUser(User user) async{
    //SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.setString("user", jsonEncode(user));

  //LLAMAR A LA API FIREBASE
  var result = await _firebaseApi.registerUser(user.email, user.password);

  //MOSTRAR ERRORES EN PANTALLA
  String msg = "";

  
  switch (result) {
    case "invalid-email": {msg="El correo electrónico está mal escrito";
    _showMsg(msg);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));}
      break;
    case "weak-password" : {msg = "Ingrese una contraseña mínimo de 6 caracteres";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));}
      break;
    case "email-already-in-use" : {msg = "El correo ya está en uso";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));}
      break;
    case "network-request-failed" : {msg = "No se pudo conectar, revise su conexión a internet";
    _showMsg(msg);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));}
      break;
    default: {msg = "Usuario creado con éxito";
    user.uid = result;
    _saveUser(user);
    _showMsg(msg);//Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
    }
    break;
  }
    



  }

  void _onRegisterButtonClicked() { 
    setState(() {

      
      if (_password.text == _repPassword.text){
      String genre = "Masculino";
      if(_genre == Genre.femenino) {
        genre = "Femenino";
      }

      String favoritos= "";
      if(_aventura) favoritos = "$favoritos Aventura";
      if(_fantasia) favoritos = "$favoritos Fantasia";
      if(_terror) favoritos = "$favoritos Terror";
      var user = User("",_name.text, _email.text, _password.text, genre,favoritos, _date);
      _registerUser(user);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
      }
      else{
        _showMsg("Las contraseñas no coinciden");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50,),
                const Image(image: AssetImage('assets/images/logo.png'),
                width: 100, height: 100,),

                Text('MIS LIBROS'),
                const SizedBox(height: 16.0 //Para agregar un espacio
                    ),

                //NAME TEXTFIELD
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),

                //EMAIL TEXTFIELD
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),

                //PASSWORD TEXTFIELD
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingrese contraseña'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),

                //RECONFIRMATION PASSWORD TEXFIELD
                TextFormField(
                  controller: _repPassword,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingrese contraseña nuevamente'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),

                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Masculino'),
                        leading: Radio<Genre>(
                          value: Genre.masculino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Femenino'),
                        leading: Radio<Genre>(
                          value: Genre.femenino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ], //eliminar
                ),

                const Text('Generos favoritos', style: TextStyle(fontSize: 20),
                ),

                //CHECKBOX AVENTURA
                CheckboxListTile(title: const Text('Aventura'),value: _aventura,
                selected: _aventura,
                onChanged: (bool? value){
                  setState(() {
                    _aventura = value!;
                  });
                },),


                //CHECKBOX FANTASIA
                   CheckboxListTile(title: const Text('Fantasia'),value: _fantasia,
                selected: _fantasia,
                onChanged: (bool? value){
                  setState(() {
                    _fantasia = value!;
                  });
                },),

                //CHECKBOX TERROR
                   CheckboxListTile(title: const Text('Terror'),value: _terror,
                selected: _terror,
                onChanged: (bool? value){
                  setState(() {
                    _terror = value!;
                  });
                },),

                //BUTTON DATE 
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _showSelectDate();
                  },
                  child: Text(buttonMsg),
                ),

                //REGISTER BUTTON
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _onRegisterButtonClicked();
                  },
                  child: const Text('Registrarse'),
                ),


                
              ],
            ),
          ))),
    );
  }
}
