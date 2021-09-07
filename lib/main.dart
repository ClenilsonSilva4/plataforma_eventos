import 'package:flutter/material.dart';

import 'acesso/login.dart';

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
    return Login(url);

    //Entra direto na interface do participante
    /* return InterfaceParticipante(
      Participante("2", "Participante 2", "teste7@teste.com", "ansfisoanfsa",
          "testando", "Curso Teste"),
      url,
    ); */

    //Interface Organizador
    /* return InterfaceOrganizador(
      Organizador(
        "1",
        "Organizador1",
        "teste@teste.com",
        "84999999999",
        "testando",
      ),
      url,
    ); */
  }
}
