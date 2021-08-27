class Evento {
  String _id;
  String _nome;
  String _descricao;
  String _dataInicio;
  String _horarioInicio;
  String _dataFim;
  String _horarioFim;
  String _cargaHoraria;
  String _numeroMaximoParticipantes;
  String _dataCriacao;
  String _dataAutorizacao;
  String _idOrganizador;
  String _idUnidade;

  Evento(
      String id,
      String nome,
      String descricao,
      String dataInicio,
      String horarioInicio,
      String dataFim,
      String horarioFim,
      String cargaHoraria,
      String numeroMaximoParticipantes,
      String dataCriacao,
      String dataAutorizacao,
      String idOrganizador,
      String idUnidade)
      : _id = id,
        _nome = nome,
        _descricao = descricao,
        _dataInicio = dataInicio,
        _horarioInicio = horarioInicio,
        _dataFim = dataFim,
        _horarioFim = horarioFim,
        _cargaHoraria = cargaHoraria,
        _numeroMaximoParticipantes = numeroMaximoParticipantes,
        _dataCriacao = dataCriacao,
        _dataAutorizacao = dataAutorizacao,
        _idOrganizador = idOrganizador,
        _idUnidade = idUnidade;

  String get id => this._id;

  String get nome => this._nome;

  String get descricao => this._descricao;

  String get dataInicio => this._dataInicio;

  String get horarioInicio => this._horarioInicio;

  String get dataFim => this._dataFim;

  String get horarioFim => this._horarioFim;

  String get cargaHoraria => this._cargaHoraria;

  String get numeroMaximoParticipantes => this._numeroMaximoParticipantes;

  String get dataCriacao => this._dataCriacao;

  String get dataAutorizacao => this._dataAutorizacao;

  String get idOrganizador => this._idOrganizador;

  String get idUnidade => this._idUnidade;
}
