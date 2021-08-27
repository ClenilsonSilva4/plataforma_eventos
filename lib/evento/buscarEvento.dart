import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const local = "http://192.168.0.2:80/projeto/";

class BuscarEvento extends StatefulWidget {
  BuscarEvento({Key? key}) : super(key: key);

  @override
  _BuscarEventoState createState() => _BuscarEventoState();
}

class _BuscarEventoState extends State<BuscarEvento> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nomeEvento = TextEditingController();
  TextEditingController _dataInicio = TextEditingController();
  TextEditingController _dataFim = TextEditingController();
  Future<List>? unidades;

  late DateTime inicioEvento;
  late String _listValue;

  final Color fillTextFieldColor = Colors.black45;
  final Color borderColor = Colors.tealAccent;
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 5.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Nome do Evento",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  hintText: "Insira o nome do evento",
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
                controller: _nomeEvento,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextFormField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2050),
                  ).then(
                    (date) {
                      setState(() {
                        if (date == null) {
                          _dataInicio.clear();
                        } else {
                          inicioEvento = date;
                          _dataInicio.text = date.day.toString() +
                              "/" +
                              date.month.toString() +
                              "/" +
                              date.year.toString();
                        }
                      });
                    },
                  );
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Data de Inicio do Evento",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  hintText: "Insira a data de início do evento",
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
                controller: _dataInicio,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextFormField(
                onTap: onTap,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Data de Encerramento do Evento",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  hintText: (_dataInicio.text.isNotEmpty)
                      ? "Insira a data de encerramento do evento"
                      : "Insira primeiro a data de inicio",
                  hintStyle: (_dataInicio.text.isNotEmpty)
                      ? TextStyle(
                          color: Colors.white,
                        )
                      : TextStyle(color: Colors.red),
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
                controller: _dataFim,
                style: TextStyle(color: Colors.white),
              ),
            ),
            FutureBuilder<List>(
              future: unidades,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasError &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Unidade Acadêmica",
                        labelStyle: TextStyle(
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
                      value: _listValue,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFFFFFFFF),
                      ),
                      iconSize: 24,
                      style: TextStyle(color: textColor),
                      dropdownColor: Colors.black.withOpacity(0.8),
                      onChanged: (String? newValue) {
                        setState(() {
                          _listValue = newValue!;
                        });
                      },
                      items:
                          snapshot.data.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value["nome"].toString(),
                          child: Text(value["nome"]),
                        );
                      }).toList(),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
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
                  onPressed: onPressed,
                  child: const Text("PESQUISAR"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    unidades = _getUnidades("getUnidadesAcademicas.php");
    super.initState();
  }

  Future<List> _getUnidades(String requestURL) async {
    var getURL = Uri.parse(local + requestURL);

    http.Response response = await http.get(getURL);
    List items = json.decode(response.body);

    _listValue = items.first["nome"];

    return items;
  }

  void onTap() {
    if (_dataInicio.text.isNotEmpty) {
      showDatePicker(
        context: context,
        initialDate: inicioEvento,
        firstDate: inicioEvento,
        lastDate: DateTime(2050),
      ).then((date) {
        setState(() {
          if (date == null) {
            _dataFim.clear();
          } else {
            _dataFim.text = date.day.toString() +
                "/" +
                date.month.toString() +
                "/" +
                date.year.toString();
          }
        });
      });
    }
  }

  void onPressed() {}
}
