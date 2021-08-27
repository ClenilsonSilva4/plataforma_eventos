import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../usuario.dart';

class MudarNome extends StatefulWidget {
  final Usuario _usuario;
  final String _url;
  const MudarNome(Usuario usuario, String url)
      : this._usuario = usuario,
        _url = url;

  @override
  _MudarNomeState createState() => _MudarNomeState();
}

class _MudarNomeState extends State<MudarNome> {
  final Color borderColor = Colors.teal[600]!;
  final Color fillTextFieldColor = Colors.black45;
  final Color appBarBackground = Colors.teal[800]!;
  final Color backgroundColor = Colors.grey[800]!;
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeUsuario = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Alterar Nome",
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
        backgroundColor: appBarBackground,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Nome do usuario",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  hintText: "Insira o novo nome do usuário",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: fillTextFieldColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
                controller: nomeUsuario,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.teal[600]),
                  ),
                  onPressed: () {
                    sendData(nomeUsuario.text.toString());
                    Navigator.pop(context, nomeUsuario.text.toString());
                  },
                  child: const Text("ALTERAR"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendData(String novoNome) async {
    var getURL = Uri.parse(widget._url + "setNomeUsuario.php");
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final Map<String, String> body = {
      "nome": novoNome,
      "id": widget._usuario.id
    };

    await http.post(
      getURL,
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
