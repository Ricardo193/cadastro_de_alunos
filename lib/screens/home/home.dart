import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/repository/student/studentdb_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _registerController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de alunos"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Matrícula do aluno",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _registerController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Nome do aluno",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email do aluno",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: saveRegister,
                child: Text("Cadastrar aluno"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveRegister() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String message;

    //validação
    if (!EmailValidator.validate(email)) {
      //não é valido
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mesagem do sistema"),
          content: Text("Email inválido!!!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
    } else {
      //valido
      Student student = Student(
        name: name,
        email: email,
      );

      var repository = StudentDBRepository();

      int id = await repository.insert(student);

      if (id != 0) {
        message = "Tudo certo!!";
      } else {
        message = "Deu ruim";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mesagem do sistema"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
    }
  }
}
