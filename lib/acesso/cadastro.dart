import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plataforma_eventos/usuario/organizador/interfaceOrganizador.dart';
import 'package:plataforma_eventos/usuario/participante/interfaceParticipante.dart';

import 'package:plataforma_eventos/usuario/participante/participante.dart';
import 'package:plataforma_eventos/usuario/organizador/organizador.dart';

class Cadastro extends StatefulWidget {
  final String _url;
  const Cadastro(String url) : _url = url;

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _passwordVisibility = true;
  TextEditingController _nome = TextEditingController();
  TextEditingController _curso = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _keepConnected = false;
  String _userValue = "Organizador";

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
            "Realizar Cadastro",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: _containerColor,
        ),
        body: SingleChildScrollView(
          child: Form(
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextFormField(
                    controller: _nome,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(color: _iconsNTextColor),
                      hintText: "Insira o seu nome",
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
                    validator: (value) {
                      if (value!.length < 5) {
                        return "Por favor, insira um nome maior";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Usuário",
                      labelStyle: TextStyle(
                        color: _iconsNTextColor,
                      ),
                      filled: true,
                      fillColor: _fillTextFieldColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                    ),
                    value: _userValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFFFFFFFF),
                    ),
                    iconSize: 24,
                    style: TextStyle(color: _iconsNTextColor),
                    dropdownColor: Colors.black.withOpacity(0.8),
                    onChanged: (String? newValue) {
                      setState(() {
                        _userValue = newValue!;
                      });
                    },
                    items: <String>["Participante", "Organizador"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                (_userValue.contains("Participante"))
                    ? Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          controller: _curso,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            labelText: "Curso",
                            labelStyle: TextStyle(color: _iconsNTextColor),
                            hintText: "Insira o seu nome do seu curso",
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
                          validator: (value) {
                            if (value!.length < 5) {
                              return "O nome do curso está muito pequeno";
                            }
                          },
                        ),
                      )
                    : Container(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange[900]),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) checarAcesso();
                    },
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void checarAcesso() async {
    var usuario = await _getUsuario();
    if (_userValue == "Participante") {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterfaceParticipante(usuario!, widget._url),
        ),
      );
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterfaceOrganizador(usuario!, widget._url),
        ),
      );
    }
  }

  Future _getUsuario() async {
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Map<String, String> body;
    var geturl;

    if (_userValue == "Participante") {
      geturl = Uri.parse(widget._url + "criarParticipante.php");
      body = {
        "email": _email.text.toString(),
        "senha": _password.text.toString(),
        "nome": _nome.text.toString(),
        "curso": _curso.text.toString(),
      };
    } else {
      geturl = Uri.parse(widget._url + "criarOrganizador.php");
      body = {
        "email": _email.text.toString(),
        "senha": _password.text.toString(),
        "nome": _nome.text.toString(),
      };
    }

    http.Response response = await http.post(
      geturl,
      headers: header,
      body: jsonEncode(body),
    );

    if (response.body.toString().contains("<br />")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "Não foi possível realizar o cadastro",
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

      if (_userValue == "Participante") {
        return Participante(
          usuario["id_usuario"],
          _nome.text.toString(),
          _email.text.toString(),
          _password.text.toString(),
          _curso.text.toString(),
        );
      } else if (_userValue == "Organizador") {
        return Organizador(
          usuario["id_usuario"],
          _nome.text.toString(),
          _email.text.toString(),
          _password.text.toString(),
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

    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&]).{8,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(senha)) {
      return "Insira uma senha válida";
    }
  }
}
