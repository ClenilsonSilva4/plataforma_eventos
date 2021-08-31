import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CriarEvento extends StatefulWidget {
  final String _idUsuario;
  final String _url;
  const CriarEvento(String idUsuario, String url)
      : _idUsuario = idUsuario,
        _url = url;

  @override
  _CriarEventoState createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nomeEvento = TextEditingController();
  TextEditingController _descricaoEvento = TextEditingController();
  TextEditingController _dataInicio = TextEditingController();
  TextEditingController _horarioInicio = TextEditingController();
  TextEditingController _dataFim = TextEditingController();
  TextEditingController _horarioFim = TextEditingController();
  TextEditingController _cargaHoraria = TextEditingController();
  TextEditingController _numeroParticipantes = TextEditingController();

  Color fillTextFieldColor = Colors.black45;
  Color borderColor = Colors.tealAccent;
  Color appBarBackground = Colors.teal[800]!;
  Color textColor = Colors.white;
  Color buttonColor = Colors.deepOrange[800]!;

  late List _unidades;
  late DateTime _inicioEvento;
  late String _listValue;

  String _getUnidadeID() {
    for (var getUnidade in _unidades) {
      print(getUnidade);
      if (getUnidade.containsValue(_listValue)) {
        return getUnidade["id_usuario"]!;
      }
    }
    return "";
  }

  String _getStringForDB(String dateLocal) {
    var splitedString = dateLocal.split("/");
    return splitedString.elementAt(2) +
        "-" +
        splitedString.elementAt(1) +
        "-" +
        splitedString.elementAt(0);
  }

  void _sendEventDB() async {
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var criacao = DateTime.now();
    final Map<String, String> body = {
      "nome": _nomeEvento.text.toString(),
      "descrição": _descricaoEvento.text.toString(),
      "carga_horaria": _cargaHoraria.text.toString(),
      "participantes": _numeroParticipantes.text.toString(),
      "data_inicio": _getStringForDB(_dataInicio.text.toString()),
      "horario_inicio": _horarioInicio.text.toString(),
      "data_fim": _getStringForDB(_dataFim.text.toString()),
      "horario_fim": _horarioFim.text.toString(),
      "organizador": widget._idUsuario,
      "unidade": _getUnidadeID(),
      "data_criacao": criacao.year.toString() +
          "-" +
          criacao.month.toString() +
          "-" +
          criacao.day.toString(),
      "data_autorizacao": "Aguardando",
    };

    var getURL = Uri.parse(widget._url + "criarEvento.php");

    http.Response response = await http.post(
      getURL,
      headers: header,
      body: json.encode(body),
    );

    if (response.body.toString().contains("<br />")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "Não foi possível criar o evento",
              style: TextStyle(color: textColor),
            ),
            actions: <Widget>[
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _sendEventDB();
                },
                child: Text(
                  "Tentar Novamente",
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Evento criado com sucesso",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 280.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          backgroundColor: buttonColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Criar Novo Evento",
          style: TextStyle(color: textColor, fontSize: 20),
        ),
        backgroundColor: appBarBackground,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.length < 10) {
                      return "Insira um título maior para o seu evento.";
                    }
                  },
                  controller: _nomeEvento,
                  style: TextStyle(color: Colors.white),
                  maxLength: 45,
                  decoration: InputDecoration(
                    labelText: "Nome",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    counterStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _descricaoEvento,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.length < 100) {
                      return "Insira uma descrição maior para o seu evento.";
                    }
                  },
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    hintText: "Insira a descrição do evento",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
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
                          if (date != null) {
                            _inicioEvento = date;
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
                  controller: _dataInicio,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Esse campo é obrigatório";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Data de Inicio",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then(
                      (date) {
                        setState(() {
                          if (date != null) {
                            _horarioInicio.text = date.hour.toString() + ":";
                            if (date.minute.toString() == "0") {
                              _horarioInicio.text += "00";
                            } else {
                              _horarioInicio.text += date.minute.toString();
                            }
                          }
                        });
                      },
                    );
                  },
                  readOnly: true,
                  controller: _horarioInicio,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Esse campo é obrigatório";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Horario de Inicio",
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    hintText: "Insira o horário de início do evento",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  onTap: () {
                    if (_dataInicio.text.isNotEmpty) {
                      showDatePicker(
                        context: context,
                        initialDate: _inicioEvento,
                        firstDate: _inicioEvento,
                        lastDate: DateTime(2050),
                      ).then((date) {
                        setState(() {
                          if (date != null) {
                            _dataFim.text = date.day.toString() +
                                "/" +
                                date.month.toString() +
                                "/" +
                                date.year.toString();
                          }
                        });
                      });
                    }
                  },
                  readOnly: true,
                  controller: _dataFim,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Esse campo é obrigatório";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Data de Encerramento",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then(
                      (date) {
                        setState(() {
                          if (date != null) {
                            _horarioFim.text = date.hour.toString() + ":";
                            if (date.minute.toString() == "0") {
                              _horarioFim.text += "00";
                            } else {
                              _horarioFim.text += date.minute.toString();
                            }
                          }
                        });
                      },
                    );
                  },
                  readOnly: true,
                  controller: _horarioFim,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Esse campo é obrigatório";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Horario de Inicio",
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    hintText: "Insira o horário de início do evento",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _cargaHoraria,
                  style: TextStyle(color: Colors.white),
                  validator: (value) => validateMandatoryCamps(value!),
                  maxLength: 3,
                  decoration: InputDecoration(
                    labelText: "Carga Horaria",
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    hintText: "Insira a carga horaria do evento",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    counterStyle: TextStyle(color: Colors.white),
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _numeroParticipantes,
                  style: TextStyle(color: Colors.white),
                  validator: (value) => validateMandatoryCamps(value!),
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Quantidade de Vagas",
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    hintText: "Insira a quantidade de vagas para o evento",
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: borderColor),
                    ),
                    counterStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              FutureBuilder<List>(
                future: _getNomeUnidades("getUnidadesAcademicas.php"),
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
                        items: snapshot.data
                            .map<DropdownMenuItem<String>>((value) {
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
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendEventDB();
                  }
                },
                child: const Text("CRIAR"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateMandatoryCamps(String value) {
    if (value.length == 0) {
      return "Esse campo é obrigatório";
    } else if (int.tryParse(value) == null) {
      return "O valor inserido precisa ser um número";
    }
    var getInt = int.parse(value);

    if (getInt == 0) {
      return "O valor tem que ser maior que zero";
    }

    return null;
  }

  Future<List> _getNomeUnidades(String requestURL) async {
    var getURL = Uri.parse(widget._url + requestURL);

    http.Response response = await http.get(getURL);
    List items = json.decode(response.body);

    _listValue = items.first["nome"];
    _unidades = items;

    return items;
  }
}
