import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plataforma_eventos/evento/evento.dart';

class PreencherEvento extends StatefulWidget {
  final String _idUsuario;
  final String _url;
  final Evento _event;

  PreencherEvento.criarEvento(String idUsuario, String url)
      : _idUsuario = idUsuario,
        _url = url,
        _event = new Evento("", "", "", "", "", "", "", "", "", "", "", "", "");

  PreencherEvento(String idUsuario, String url, Evento event)
      : _idUsuario = idUsuario,
        _url = url,
        _event = event;

  @override
  _PreencherEventoState createState() => _PreencherEventoState();
}

class _PreencherEventoState extends State<PreencherEvento> {
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
  late String _finalURL;
  String _action = "cria";

  @override
  void initState() {
    if (widget._event.id != "") {
      _nomeEvento.text = widget._event.nome;
      _descricaoEvento.text = widget._event.descricao;
      _cargaHoraria.text = widget._event.cargaHoraria;
      _numeroParticipantes.text = widget._event.numeroMaximoParticipantes;
      _dataInicio.text = _getStringForUser(widget._event.dataInicio);
      _horarioInicio.text = widget._event.horarioInicio;
      _dataFim.text = _getStringForUser(widget._event.dataFim);
      _horarioFim.text = widget._event.horarioFim;
      _finalURL = widget._url + "editarEvento.php";
      _action = "edita";
    }
    super.initState();
  }

  void _sendEventDB() async {
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final Map<String, String> body = {
      "id": widget._event.id,
      "nome": widget._event.nome,
      "descrição": widget._event.descricao,
      "carga_horaria": widget._event.cargaHoraria,
      "participantes": widget._event.numeroMaximoParticipantes,
      "data_inicio": widget._event.dataInicio,
      "horario_inicio": widget._event.horarioInicio,
      "data_fim": widget._event.dataFim,
      "horario_fim": widget._event.horarioFim,
      "organizador": widget._event.idOrganizador,
      "unidade": widget._event.idUnidade,
      "data_criacao": widget._event.dataCriacao,
      "data_autorizacao": widget._event.dataAutorizacao,
    };

    var getURL = Uri.parse(_finalURL);

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
              "Não foi possível " + _action + "r o evento",
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
          content: Text(
            "Evento " + _action + "do com sucesso",
            style: TextStyle(
              color: textColor,
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
          _action[0].toUpperCase() + _action.substring(1) + "r Novo Evento",
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
                    _fillEvent();
                    _sendEventDB();
                  }
                },
                child: (widget._event.id == "")
                    ? const Text("CRIAR")
                    : const Text("EDITAR"),
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

  String _getStringForUser(String dateLocal) {
    var splitedString = dateLocal.split("-");
    return splitedString.elementAt(2) +
        "/" +
        splitedString.elementAt(1) +
        "/" +
        splitedString.elementAt(0);
  }

  void _fillEvent() {
    widget._event.nome = _nomeEvento.text.toString();
    widget._event.descricao = _descricaoEvento.text.toString();
    widget._event.cargaHoraria = _cargaHoraria.text.toString();
    widget._event.numeroMaximoParticipantes =
        _numeroParticipantes.text.toString();
    widget._event.horarioInicio = _horarioInicio.text.toString();
    widget._event.dataFim = _getStringForDB(_dataFim.text.toString());
    widget._event.horarioFim = _horarioFim.text.toString();
    widget._event.idUnidade = _getUnidadeID();
    widget._event.dataInicio = _getStringForDB(_dataInicio.text.toString());

    if (widget._event.id == "") {
      var criacao = DateTime.now();
      widget._event.dataAutorizacao = "Aguardando";
      widget._event.idOrganizador = widget._idUsuario;
      widget._event.dataCriacao = criacao.year.toString() +
          "-" +
          criacao.month.toString() +
          "-" +
          criacao.day.toString();
      _finalURL = widget._url + "criarEvento.php";
    }
  }
}
