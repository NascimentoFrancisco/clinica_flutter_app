import 'package:clinica1/models/agenda.dart';
import 'package:clinica1/models/cliente.dart';
import 'package:clinica1/models/consultas.dart';
import 'package:clinica1/models/especialidade.dart';
import 'package:clinica1/models/medico.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  //construtor com acesso privado
  DB._();
  //Criar uma instancia privada
  static final DB instance = DB._();
  //instancia do sqlite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'clinica.db'),
      version: 2,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_especialidadeMedico);
    await db.execute(_medico);
    await db.execute(_agendaMedico);
    await db.execute(_cliente);
    await db.execute(_consulta);
  }

  String get _especialidadeMedico => '''
  CREATE TABLE especialidade(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
  );
  ''';

  String get _medico => '''
    CREATE TABLE medico(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      crm TEXT NOT NULL, 
      email TEXT NOT NULL, 
      telefone TEXT NOT NULL, 
      especialidade_id INTEGER NOT NULL,
      FOREIGN KEY(especialidade_id) REFERENCES especialidade(id)
    );
  ''';
  
  String get _agendaMedico => '''
  CREATE TABLE agenda(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data TEXT NOT NULL,
      horario TEXT NOT NULL, 
      medico_id INTEGER NOT NULL,
      FOREIGN KEY(medico_id) REFERENCES medico (id)
    );
  ''';

  String get _cliente => '''
  CREATE TABLE cliente(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nome TEXT NOT NULL, 
      cpf TEXT NOT NULL, 
      email TEXT NOT NULL,
      sexo TEXT NOT NULL,
      telefone  TEXT NOT NULL
    );
  ''';

  String get _consulta => '''
  CREATE TABLE consulta(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      agendaMedico_id INTEGER NOT NULL,
      cliente_id INTEGER NOT NULL,
      FOREIGN KEY(agendaMedico_id) REFERENCES agenda (id), 
      FOREIGN KEY(cliente_id)  REFERENCES cliente (id)
  );
  ''';

  Future<void> InsereEspecialidade(Especialidades, especialidade) async {
    final Database db = await instance.database;
    await db.insert(
      'especialidade',
      especialidade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> InsereMedico(Medico, medico) async {
    final Database db = await instance.database;
    await db.insert('medico', medico.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> InsereAgendaMedico(Agendas, agenda) async {
    final Database db = await instance.database;
    await db.insert('agenda', agenda.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> InsereCliente(Cliente, cliente) async {
    final Database db = await instance.database;
    await db.insert('cliente', cliente.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> InsereConsulta(Consultas, consulta) async {
    final Database db = await instance.database;
    await db.insert('consulta', consulta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Especialidades>> ListaEspecialidade() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('especialidade');
    return List.generate(maps.length, (i) {
      return Especialidades(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
      );
    });
  }

  Future<List<Medico>> ListaMedico() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('medico');
    return List.generate(maps.length, (i) {
      return Medico(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          crm: maps[i]['crm'],
          email: maps[i]['email'],
          telefone: maps[i]['telefone'],
          especialidade_id: maps[i]['especialidade_id'],
        );
    });
  }

  Future<List<Agendas>> ListaAgendas() async{
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('agenda');
    return List.generate(maps.length, (i) {
      return Agendas(
          id:maps[i]['id'],
          data:maps[i]['data'], 
          horario:maps[i]['horario'],
          medico_id:maps[i]['medico_id'],
        ); 
    }); 
  }

  Future<List<Cliente>> ListaCliente() async{
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('cliente');
    return List.generate(maps.length, (i) {
      return Cliente(
          id:maps[i]['id'], 
          nome:maps[i]['nome'], 
          cpf:maps[i]['cpf'], 
          email:maps[i]['email'], 
          sexo:maps[i]['sexo'], 
          telefone:maps[i]['telefone'],
        );
    });
  }

  Future<List<Consultas>> ListaConsultas() async{
    final Database db = await instance.database;
    final List<Map<String,dynamic>> maps = await db.query('consulta');
    return List.generate(maps.length, (i) {
      return Consultas(
          id:maps[i]['id'], 
          agendaMedico_id:maps[i]['agendaMedico_id'],
          cliente_id:maps[i]['cliente_id'],
        );
    });
  }

  Future<void> updateEspecialidade(Especialidades especialidade) async {
    final db = await instance.database;
    await db.update(
      'especialidade',
      especialidade.toMap(),
      where: 'id = ?',
      whereArgs: [especialidade.id],
    );
  }

  Future<void> updateMEdico(Medico medico) async {
    final db = await instance.database;
    await db.update(
      'medico',
      medico.toMap(),
      where: 'id = ?',
      whereArgs: [medico.id],
    );
  }

  Future<void> updateAgenda(Agendas agenda) async {
    final db = await instance.database;
    await db.update(
      'agenda',
      agenda.toMap(),
      where: 'id = ?',
      whereArgs: [agenda.id],
    );
  }

  Future<void> updateCleinte(Cliente cliente) async {
    final db = await instance.database;
    await db.update(
      'cliente',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> updateConsulta(Consultas consulta) async {
    final db = await instance.database;
    await db.update(
      'consulta',
      consulta.toMap(),
      where: 'id = ?',
      whereArgs: [consulta.id],
    );
  }

  Future<void> deleteEspecialidade(int id) async {
    final db = await database;
    await db.delete(
      'especialidade',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMedico(int id) async {
    final db = await database;
    await db.delete(
      'medico',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAgenda(int id) async {
    final db = await database;
    await db.delete(
      'agenda',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCliente(int id) async {
    final db = await database;
    await db.delete(
      'cliente',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteConsulta(int id) async {
    final db = await database;
    await db.delete(
      'consulta',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Métedo para fechar e encerrar a comunicação com o banco de dados
  Future FecharBanco() async {
    final db = await instance.database;
    db.close();
  }

}
