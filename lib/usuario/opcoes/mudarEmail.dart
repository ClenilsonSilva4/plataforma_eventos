import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plataforma_eventos/usuario/usuario.dart';

class MudarEmail extends StatefulWidget {
  final Usuario _usuario;
  final String _url;

  MudarEmail(Usuario usuario, String url)
      : _usuario = usuario,
        _url = url;

  @override
  _MudarEmailState createState() => _MudarEmailState();
}

class _MudarEmailState extends State<MudarEmail> {
  final Color borderColor = Colors.teal[600]!;
  final Color fillTextFieldColor = Colors.black45;
  final Color appBarBackground = Colors.teal[800]!;
  final Color backgroundColor = Colors.grey[800]!;
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailUsuario = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Alterar E-mail",
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  hintText: "Insira o novo e-mail",
                  hintStyle: TextStyle(
                    color: textColor,
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
                controller: emailUsuario,
                style: TextStyle(color: textColor),
                validator: (value) => checarEmail(value),
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
                    if (formKey.currentState!.validate()) {
                      sendData(emailUsuario.text.toString());
                    }
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

  void sendData(String novoEmail) async {
    var geturl = Uri.parse(widget._url + "setEmailUsuario.php");
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final Map<String, String> body = {
      "email": novoEmail,
      "id": widget._usuario.id
    };

    http.Response response = await http.post(
      geturl,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.body.toString().contains("<br />")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "O e-mail inserido não está disponível",
              style: TextStyle(
                color: textColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Tentar novamente",
                  style: TextStyle(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "O e-mail foi alterado com sucesso.\nSerá necessário realizar login novamente.",
              style: TextStyle(
                color: textColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  String? checarEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Insira um e-mail";
    }

    if (email == widget._usuario.email) {
      return "O e-mail inserido é igual ao já cadastrado";
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return "Insira um e-mail válido";
    }
    return null;
  }
}
