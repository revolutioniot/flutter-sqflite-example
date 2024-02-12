///////////////////////////////////////////////////////////////
// prorole_form_page.dart


import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/models/prorole.dart';
import 'package:flutter_sqflite_example/services/database_service.dart';

class ProroleFormPage extends StatefulWidget {
  const ProroleFormPage({Key? key}) : super(key: key);

  @override
  _ProroleFormPageState createState() => _ProroleFormPageState();
}

class _ProroleFormPageState extends State<ProroleFormPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();
  final TextEditingController _rightidController = TextEditingController();
  

  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onSave() async {
    // final id = _idController.text;
    final description = _descriptionController.text;
    final active = _activeController.text;
    final rightid = _rightidController.text;
    

    await _databaseService
        .insertProrole(Prorole(description: description, active: active == 'true', rightid: int.tryParse(rightid) ?? 0));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new prorole'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
		    TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description of the prorole here',
              ),
            ),
            SizedBox(height: 16.0),
			TextField(
              controller: _rightidController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter rightid of the prorole here',
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: Text(
                  'Save the Prorole',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

