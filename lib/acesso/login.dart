import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plataforma_eventos/usuario/participante/interface.dart';

import 'package:plataforma_eventos/usuario/participante/participante.dart';
import 'package:plataforma_eventos/usuario/organizador/organizador.dart';
import 'package:plataforma_eventos/usuario/unidade_academica/unidadeAcademica.dart';

class Login extends StatefulWidget {
  final String _url;
  const Login(String url) : _url = url;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisibility = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _keepConnected = false;
  var _usuario;

  final Color? _containerColor = Colors.teal[900];
  final Color? _fillTextFieldColor = Colors.grey[900];
  final Color _borderColor = Colors.tealAccent;
  final Color _iconsNTextColor = Colors.white;

  void _showPassword() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      _email = _email;
      _password = _password;
      _formKey = _formKey;
      _keepConnected = _keepConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Plataforma de Eventos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _containerColor,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Icon(
                Icons.account_box_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: _iconsNTextColor),
                  hintText: "Insira o seu e-mail",
                  hintStyle: TextStyle(color: _iconsNTextColor),
                  fillColor: _fillTextFieldColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                ),
                style: TextStyle(color: _iconsNTextColor),
                validator: (value) => checarEmail(value),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextFormField(
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: _showPassword,
                    icon: (_passwordVisibility)
                        ? Icon(
                            Icons.visibility_rounded,
                            color: _iconsNTextColor,
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            color: _iconsNTextColor,
                          ),
                  ),
                  labelText: "Senha",
                  labelStyle: TextStyle(color: _iconsNTextColor),
                  hintText: "Insira a senha",
                  hintStyle: TextStyle(color: _iconsNTextColor),
                  fillColor: _fillTextFieldColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                ),
                style: TextStyle(color: _iconsNTextColor),
                validator: (value) => checarSenha(value),
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _keepConnected,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        _keepConnected = !_keepConnected;
                        _passwordVisibility = _passwordVisibility;
                        _email = _email;
                        _password = _password;
                        _formKey = _formKey;
                      },
                    );
                  },
                  side: BorderSide(color: _iconsNTextColor),
                ),
                Text(
                  "Mantenha conectado",
                  style: TextStyle(
                    color: _iconsNTextColor,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: TextButton(
                    child: Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                        color: _iconsNTextColor,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[600]),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate())
                    checarAcesso(
                        _email.text.toString(), _password.text.toString());
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Ainda não possui cadastro?",
                        style: TextStyle(
                          color: _iconsNTextColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange[900]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void checarAcesso(String email, String senha) async {
    _usuario = await _getUsuario(email, senha);

    if (_usuario is Participante) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Interface(_usuario, widget._url),
        ),
      );
    }
  }

  Future _getUsuario(String email, String senha) async {
    var geturl = Uri.parse(widget._url + "getUsuario.php");
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Map<String, String> body = {"email": email, "senha": senha};

    http.Response response = await http.post(
      geturl,
      headers: header,
      body: jsonEncode(body),
    );

    if (response.body.toString().contains("<br />") ||
        response.body.toString().contains("[]")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "Usuário não encontrado",
              style: TextStyle(
                color: _iconsNTextColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(color: _iconsNTextColor),
                ),
              ),
            ],
          );
        },
      );
    } else {
      var usuario = json.decode(response.body)[0];
      body = {"id": usuario["id_usuario"]};
      geturl = Uri.parse(widget._url + "getTipoUsuario.php");

      response = await http.post(
        geturl,
        headers: header,
        body: jsonEncode(body),
      );
      var tipoUsuario = json.decode(response.body);

      if (tipoUsuario.containsKey("curso")) {
        return Participante(
          usuario["id_usuario"],
          usuario["nome"],
          email,
          usuario["telefone"],
          senha,
          tipoUsuario["curso"],
        );
      } else if (tipoUsuario.containsKey("Organizador")) {
        return Organizador(
          usuario["id_usuario"],
          usuario["nome"],
          email,
          usuario["telefone"],
          senha,
        );
      } else if (tipoUsuario.containsKey("Unidade")) {
        return UnidadeAcademica(
          usuario["id_usuario"],
          usuario["nome"],
          email,
          usuario["telefone"],
          senha,
        );
      }
    }
  }

  String? checarEmail(String? email) {
    // Null or empty string is invalid
    if (email == null || email.isEmpty) {
      return "Insira o e-mail";
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return "Insira um e-mail válido";
    }
    return null;
  }

  String? checarSenha(String? senha) {
    if (senha == null || senha.isEmpty) {
      return "Insira a Senha";
    }

    /* const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&]).{8,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(senha)) {
      return "Insira uma senha válida";
    } */
  }
}
