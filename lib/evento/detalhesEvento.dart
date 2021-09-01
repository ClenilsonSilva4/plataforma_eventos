import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/evento.dart';

class DetalhesEvento extends StatefulWidget {
  final Evento _evento;
  final String _typeDetail;
  final _function;
  const DetalhesEvento(Evento evento, String typeDetail, function)
      : _evento = evento,
        _function = function,
        _typeDetail = typeDetail;

  @override
  _DetalhesEventoState createState() => _DetalhesEventoState();
}

class _DetalhesEventoState extends State<DetalhesEvento> {
  final Color _textsDarkBackground = Colors.white;
  final Color _appBarBackground = Colors.teal[800]!;
  final Color _backgroundColor = Colors.grey[800]!;
  final Color _containerColor = Colors.grey[700]!;
  final Color _backgroundColorBotao = Colors.deepOrange[800]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.topLeft,
          child: Text(
            widget._evento.nome,
            style: TextStyle(color: _textsDarkBackground, fontSize: 20),
            maxLines: 2,
          ),
        ),
        backgroundColor: _appBarBackground,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Descrição",
              style: TextStyle(
                color: _textsDarkBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                widget._evento.descricao,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Inicio do Evento",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                "Dia: " +
                    widget._evento.dataInicio +
                    "\nHora: " +
                    widget._evento.horarioInicio,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Encerramento do Evento",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                "Dia: " +
                    widget._evento.dataFim +
                    "\nHora: " +
                    widget._evento.horarioFim,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Vagas Restantes",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                widget._evento.numeroMaximoParticipantes + " vagas",
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Carga horária",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                widget._evento.cargaHoraria + "h",
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          getActionButton(widget._typeDetail, context, widget._function),
    );
  }

  FloatingActionButton? getActionButton(
      String buttonMessage, BuildContext context, var function) {
    if (buttonMessage.contains("editar") ||
        buttonMessage.contains("inscrever")) {
      return FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey[700],
                content: Text(
                  "Deseja " + buttonMessage + "?",
                  style: TextStyle(
                    color: _textsDarkBackground,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => function,
                        ),
                      );
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(
                      "Sim",
                      style: TextStyle(color: _textsDarkBackground),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Não",
                      style: TextStyle(color: _textsDarkBackground),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: (buttonMessage.contains("editar"))
            ? Icon(
                Icons.edit_rounded,
                color: _textsDarkBackground,
                size: 30,
              )
            : Icon(
                Icons.add_circle_outline,
                color: _textsDarkBackground,
                size: 30,
              ),
        tooltip: buttonMessage,
        backgroundColor: _backgroundColorBotao,
      );
    }
  }
}
