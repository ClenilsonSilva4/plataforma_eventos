import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plataforma_eventos/usuario/usuario.dart';

class MudarSenha extends StatefulWidget {
  final Usuario _usuario;
  final String _url;

  MudarSenha(Usuario usuario, String url)
      : _usuario = usuario,
        _url = url;

  @override
  _MudarSenhaState createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha> {
  bool _passwordVisibility = true;
  TextEditingController _passwordUser = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color borderColor = Colors.teal[600]!;
  final Color fillTextFieldColor = Colors.black45;
  final Color appBarBackground = Colors.teal[800]!;
  final Color backgroundColor = Colors.grey[800]!;
  final Color textColor = Colors.white;

  void _showPassword() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      _passwordUser = _passwordUser;
      _formKey = _formKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Alterar Senha",
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
        backgroundColor: appBarBackground,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: TextFormField(
                controller: _passwordUser,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: _showPassword,
                    icon: (_passwordVisibility)
                        ? Icon(
                            Icons.visibility_rounded,
                            color: textColor,
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            color: textColor,
                          ),
                  ),
                  labelText: "Senha",
                  labelStyle: TextStyle(color: textColor),
                  hintText: "Insira a senha",
                  hintStyle: TextStyle(color: textColor),
                  fillColor: fillTextFieldColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
                style: TextStyle(color: textColor),
                validator: (value) => checarSenha(value),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange[800]),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendData(_passwordUser.text.toString());
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

  String? checarSenha(String? novaSenha) {
    if (novaSenha == null || novaSenha.isEmpty) {
      return "Insira uma senha";
    }

    if (novaSenha == widget._usuario.senha) {
      return "A senha inserida é igual a já cadastrada";
    }

    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&]).{8,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(novaSenha)) {
      return "Insira uma senha válida";
    }
  }

  void sendData(String novaSenha) async {
    var geturl = Uri.parse(widget._url + "setSenhaUsuario.php");
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final Map<String, String> body = {
      "senha": novaSenha,
      "id": widget._usuario.id
    };

    http.Response response = await http.post(
      geturl,
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body.toString());

    if (response.body.toString().contains("<br />")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "Não foi possível alterar a senha",
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
              "A senha foi alterada com sucesso.\nSerá necessário realizar login novamente.",
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
}
