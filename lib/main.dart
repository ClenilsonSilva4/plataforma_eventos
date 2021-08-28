import 'package:flutter/material.dart';
import 'package:plataforma_eventos/usuario/participante/interface.dart';
import 'package:plataforma_eventos/usuario/participante/participante.dart';

//import 'acesso/login.dart';

const url = "http://192.168.0.2:80/projeto/";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Plataforma de Eventos';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    //Passa pelo login
    //return Login(url);

    //Entra direto na interface do participante
    return Interface(
        Participante("2", "Participante 2", "teste7@teste.com", "ansfisoanfsa",
            "testando", "Curso Teste"),
        url);
  }
}
