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

  get id => this._id;

  set id(value) => this._id = value;

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get descricao => this._descricao;

  set descricao(value) => this._descricao = value;

  get dataInicio => this._dataInicio;

  set dataInicio(value) => this._dataInicio = value;

  get horarioInicio => this._horarioInicio;

  set horarioInicio(value) => this._horarioInicio = value;

  get dataFim => this._dataFim;

  set dataFim(value) => this._dataFim = value;

  get horarioFim => this._horarioFim;

  set horarioFim(value) => this._horarioFim = value;

  get cargaHoraria => this._cargaHoraria;

  set cargaHoraria(value) => this._cargaHoraria = value;

  get numeroMaximoParticipantes => this._numeroMaximoParticipantes;

  set numeroMaximoParticipantes(value) =>
      this._numeroMaximoParticipantes = value;

  get dataCriacao => this._dataCriacao;

  set dataCriacao(value) => this._dataCriacao = value;

  get dataAutorizacao => this._dataAutorizacao;

  set dataAutorizacao(value) => this._dataAutorizacao = value;

  get idOrganizador => this._idOrganizador;

  set idOrganizador(value) => this._idOrganizador = value;

  get idUnidade => this._idUnidade;

  set idUnidade(value) => this._idUnidade = value;
}
