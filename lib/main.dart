import 'package:flutter/material.dart';
import 'package:clinica1/models/agenda.dart';
import 'package:clinica1/models/cliente.dart';
import 'package:clinica1/models/consultas.dart';
import 'package:clinica1/models/especialidade.dart';
import 'package:clinica1/models/medico.dart';
import 'package:clinica1/database/db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Criando uma especialidade
  var ortopedista = const Especialidades(id: 1,nome:'Ortopedista');
  var neurologista = const Especialidades(id: 2, nome:'Neurologista');
  var cardiologista = const Especialidades(id: 3, nome:'Cardiologista');
  var endocrinologista = const Especialidades(id: 4, nome: 'Endocrinologista');

  await DB.instance.InsereEspecialidade(Especialidades, ortopedista);
  await DB.instance.InsereEspecialidade(Especialidades, neurologista);
  await DB.instance.InsereEspecialidade(Especialidades, cardiologista);
  await DB.instance.InsereEspecialidade(Especialidades, endocrinologista);

  //Printando as especialidades do banco de dados
  print(await DB.instance.ListaEspecialidade());

  //Aadicionar médicos, um para cada especialidade
  var ana = const Medico(
    id: 1, nome:'Ana lopes',crm: '102', email:'ana@gmail.com',telefone: '99 9999-9999',especialidade_id: 1);
  var bernado = const Medico(
      id:2,nome: 'Bernado Silva',crm: '1212', email:'bernado@gmail.com', telefone: '99 8888-8888',especialidade_id: 2);
  var benta = const Medico(
      id: 3,  nome: 'Benta cunha lopes', crm: '2012', email:  'benta@gmail.com', telefone: '99 7777-7777', especialidade_id: 3);
  var gilberto = const Medico(
      id: 4, nome: 'Gilberto Nogueira', crm: '102', email: 'gilberto@gmail.com', telefone: '99 9090-6060', especialidade_id: 4);

  await DB.instance.InsereMedico(Medico, ana);
  await DB.instance.InsereMedico(Medico, bernado);
  await DB.instance.InsereMedico(Medico, benta);
  await DB.instance.InsereMedico(Medico, gilberto);

  //Printando os médicos do banco de dados
  print(await DB.instance.ListaMedico());

  //Inserir uma agenda para cada médico
  var agenda_ana = const Agendas(id: 1, data: '12/05/2022', horario: '7:00 as 9:00', medico_id: 1);
  var agenda_bernado = const Agendas(id: 2, data: '10/05/2022', horario: '14:00 as 18:00', medico_id: 2);
  var agenda_benta = const Agendas(id: 3, data: '28/04/2022', horario: '10:00 as 12:00', medico_id: 3);
  var agenda_gilberto = const Agendas(id: 4, data: '01/05/2022', horario: '13:00 as 16:00', medico_id: 4);

  await DB.instance.InsereAgendaMedico(Agendas, agenda_ana);
  await DB.instance.InsereAgendaMedico(Agendas, agenda_bernado);
  await DB.instance.InsereAgendaMedico(Agendas, agenda_benta);
  await DB.instance.InsereAgendaMedico(Agendas, agenda_gilberto);

  //Printando todas as agendas do Banco de dados
  print(await DB.instance.ListaAgendas());

  //Inserindo cliente agora
  var antanio = const Cliente(id:1, nome: 'Antônio Lima', cpf: '000.000.000-00',
      email: 'toinho@gmail.com', sexo: 'M', telefone: '99 9999-9999');
  var anastacia = const Cliente(id: 1, nome: 'Anastacia Brito', cpf: '111.111.111-11',
      email: 'anastacia@gmail.com', sexo: 'F', telefone: '99 8888-9999');
  var maisa = const Cliente(id: 1, nome: 'Maisa Cunha Lima', cpf: '222.222.222-22',
      email: 'maisao@gmail.com', sexo: 'F', telefone: '99 7777-9999');
  var pedro = const Cliente(id: 1, nome: 'Pedro Carvalho Lima', cpf: '333.333.333-33',
      email: 'pedro@gmail.com', sexo: 'M', telefone: '99 5050-9999');
  var marcos = const Cliente(id: 1, nome: 'Marcos Silva', cpf: '444.444.444-44',
      email: 'marcos@gmail.com',sexo: 'M', telefone: '99 1010-9999');

  await DB.instance.InsereCliente(Cliente, antanio);
  await DB.instance.InsereCliente(Cliente, anastacia);
  await DB.instance.InsereCliente(Cliente, maisa);
  await DB.instance.InsereCliente(Cliente, pedro);
  await DB.instance.InsereCliente(Cliente, marcos);

  //Printando todos os clientes doa banco de dados
  print(await DB.instance.ListaCliente());

  //Adicionar consultas
  var consulta_antanio = const Consultas(id: 1, agendaMedico_id: 2, cliente_id: 1);
  var consulta_anastacia = const Consultas(id: 2, agendaMedico_id: 1, cliente_id: 2);
  var consulta_maisa = const Consultas(id: 3, agendaMedico_id: 4, cliente_id: 3,);
  var consulta_pedro = const Consultas(id: 4, agendaMedico_id: 3, cliente_id: 4);
  var consulta_marcos = const Consultas(id: 5, agendaMedico_id: 1, cliente_id: 5 );
  var consulta_mateus = const Consultas(id: 6, agendaMedico_id: 1, cliente_id: 5 );//Consulta que será deletada

  DB.instance.InsereConsulta(Consultas, consulta_antanio);
  DB.instance.InsereConsulta(Consultas, consulta_anastacia);
  DB.instance.InsereConsulta(Consultas, consulta_maisa);
  DB.instance.InsereConsulta(Consultas, consulta_pedro);
  DB.instance.InsereConsulta(Consultas, consulta_marcos);
  DB.instance.InsereConsulta(Consultas, consulta_mateus);


  //Printando as consultas marcadas no banco da clinica
  print(await DB.instance.ListaConsultas());

  //Atualização e delete de alguns dos dados
  var marcos_novo = const Cliente(id: 1, nome: 'Marcos Silva', cpf: '444.444.444-44',
      email: 'marcos@gmail.com',sexo: 'M', telefone: '99 1010-1010');

  //alterando o telefone do cliente Marcos
  await DB.instance.updateCleinte(marcos_novo);
  print(await DB.instance.ListaCliente());

  // Apaganco a consulta do cliente Mateus
  await DB.instance.deleteConsulta(6);
  print(await DB.instance.ListaConsultas());
}
