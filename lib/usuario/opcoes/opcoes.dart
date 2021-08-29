import 'package:flutter/material.dart';

import '../participante/participante.dart';
import 'mudarEmail.dart';
import 'mudarNome.dart';
import 'mudarSenha.dart';

class Opcoes extends StatefulWidget {
  final Participante _usuario;
  final String _url;
  Opcoes(Participante usuario, String url)
      : this._usuario = usuario,
        _url = url;

  @override
  _OpcoesState createState() => _OpcoesState();
}

class _OpcoesState extends State<Opcoes> {
  final Color _buttonColor = Color(0x61000000);
  final Color _borderColor = Colors.teal[600]!;
  final Color _appBarBackground = Colors.teal[800]!;
  final Color _backgroundColor = Colors.grey[800]!;
  final Color _accentColor = Colors.deepOrange[500]!;
  final Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: _borderColor,
              padding: EdgeInsets.fromLTRB(10, 66, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 100,
                  ),
                  Text(
                    widget._usuario.nome,
                    style: TextStyle(
                      color: _textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget._usuario.email,
                    style: TextStyle(
                        color: _textColor,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                  (widget._usuario.curso != "")
                      ? Text(
                          widget._usuario.curso,
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: _accentColor,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MudarEmail(widget._usuario, widget._url),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(_buttonColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: _borderColor),
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mail),
                    Text(
                      "   Alterar E-mail",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MudarSenha(widget._usuario, widget._url),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(_buttonColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: _borderColor),
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.lock),
                    Text(
                      "   Alterar Senha",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                onPressed: () async {
                  String newName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MudarNome(widget._usuario, widget._url),
                    ),
                  );
                  setState(() {
                    widget._usuario.nome = newName;
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(_buttonColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: _borderColor),
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      "   Alterar Nome",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                onPressed: _getOut,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(_buttonColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: _borderColor),
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Text(
                      "   Sair",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _sobreInfo(),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(_buttonColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: _borderColor),
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    Text(
                      "   Sobre",
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getOut() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          content: Text(
            "Você quer mesmo sair da sua conta?",
            style: TextStyle(
              color: _textColor,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "SIM",
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "NÃO",
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sobreInfo() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          "Sobre",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: _appBarBackground,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(
          "Aplicativo desenvolvido por Clenilson Jose Silva de Sousa como projeto para a disciplina Desenvolvimento Para Dispositivos Móveis, do curso Tecnologia da Informação da Universidade Federal do Rio Grande do Norte." +
              "\n\nO banco de dados utilizado pela aplicação foi desenvolvido em parceria com Italo Teixeira de Lima, aluno do mesmo curso.",
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16, color: _textColor),
        ),
      ),
    );
  }

  void onPressed() {}
}
