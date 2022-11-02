# mis_libros

MIs Libros project

pasos:

1-crear un nuevo directorio en lib

2-En el nuevo directorio crear las páginas que tendra la app:
    -Splash: logo de la app
    -Login: registro o inicio de usuario:
    -Register: registro de nuevo usuario.

3-Con el comando (s), seleccionar stateful y añadir la libreria 'package: flutter/material.dart' o 
flutter/cupertino.dart -> esto segun el dispositivo sea android o IOS.



4-Modificar el main.dart:
    -Eliminar todo lo relacionado a myhome.
    -En home colocar la pagina principal de registro.

5- Creamos el icono de la app y el logo.
    -Para el icono descargamos, convertimos, extraemos y remplazamos los archivos 'mipmap' en la carpeta main/res
    -para el logo creamos un nuevo directorio en la raíz principal del proyecto llamada 'assets'
     en esta carpeta va todo lo relacionado a los archivos multimedia de la app.
    -Copiamos la imagen del logo descargada y la pegamos en la carpeta assets

6- En el archivo 'pubspec.yaml':
    -en la dependencia flutter: agregar la ruta donde se encuentra el archivo multimedia (logo en este caso)
    assets:
      - assets/images/ (guion debe estar separado del nombre de la carpeta)
    -presionar 'pubget'.

7-






## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
