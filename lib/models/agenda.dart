class Agendas {
  final int id;
  final String data;
  final String horario;
  final int medico_id;

  const Agendas({required this.id, required this.data, required this.horario, required this.medico_id});

  Map<String, dynamic> toMap() {
    return {'id': id, 'data': data, 'horario': horario, 'medico_id': medico_id};
  }

  @override
  String toString() {
    return 'Agenda{ id: $id, data: $data, horario: $horario, medico_id: $medico_id}';
  }
}
