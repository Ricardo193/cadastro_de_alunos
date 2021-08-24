import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/models/db_local.dart';
import 'package:cadastro_de_alunos/repository/student/student_repository.dart';
import 'package:sqflite/sqflite.dart';

class StudentDBRepository implements StudentRepository {
  @override
  late DBLocal dblocal;

  StudentDBRepository() {
    dblocal = DBLocal(
      table: "students",
    );
  }

  @override
  Future<Student> find(int id) async {
    Database database = await dblocal.getConnection();
    var data = await database.query(
      dblocal.table,
      where: "id=",
      whereArgs: [id],
    );
    database.close();
    return Student.fromMap(data.first);
  }

  @override
  Future<List<Student>> findAll() async {
    Database database = await dblocal.getConnection();
    var data = await database.query(
      dblocal.table,
    );
    database.close();
    return data.map((map) => Student.fromMap(map)).toList();
  }

  @override
  Future<int> insert(Student entity) async {
    Database database = await dblocal.getConnection();
    int result = await database.insert(dblocal.table, entity.toMap());
    database.close();
    return result;
  }

  @override
  Future<int> remove({
    required String condition,
    required List conditionValues,
  }) async {
    Database database = await dblocal.getConnection();
    int result = await database.delete(
      dblocal.table,
      where: condition,
      whereArgs: conditionValues,
    );
    database.close();
    return result;
  }

  @override
  Future<int> update({
    required Student entity,
    required String condition,
    required List conditionValues,
  }) async {
    Database database = await dblocal.getConnection();
    int result = await database.update(
      dblocal.table,
      entity.toMap(),
      where: condition,
      whereArgs: conditionValues,
    );
    database.close();
    return result;
  }
}
