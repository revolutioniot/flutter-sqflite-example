///////////////////////////////////////////////////////////////
// protask_form_page.dart


import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/models/protask.dart';
import 'package:flutter_sqflite_example/services/database_service.dart';

class ProtaskFormPage extends StatefulWidget {
  const ProtaskFormPage({Key? key}) : super(key: key);

  @override
  _ProtaskFormPageState createState() => _ProtaskFormPageState();
}

class _ProtaskFormPageState extends State<ProtaskFormPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _processdefinitionidController = TextEditingController();
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _issuedateController = TextEditingController();
  final TextEditingController _completedateController = TextEditingController();
  final TextEditingController _isueuseridController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usergroupidController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  

  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onSave() async {
    final id = _idController.text;
    final processdefinitionid = _processdefinitionidController.text;
    final userid = _useridController.text;
    final issuedate = _issuedateController.text;
    final completedate = _completedateController.text;
    final isueuserid = _isueuseridController.text;
    final description = _descriptionController.text;
    final usergroupid = _usergroupidController.text;
    final repeat = _repeatController.text;
    

    await _databaseService.insertProtask(Protask(processdefinitionid: int.tryParse(processdefinitionid) ?? 0,userid: int.tryParse(userid) ?? 0,issuedate: issuedate,completedate: completedate,isueuserid: int.tryParse(isueuserid) ?? 0,description: description,usergroupid: int.tryParse(usergroupid) ?? 0,repeat: false));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new protask'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
		    TextField(
              controller: _processdefinitionidController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter processdefinitionid of the protask here',
              ),
            ),
            SizedBox(height: 16.0),TextField(
              controller: _useridController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter userid of the protask here',
              ),
            ),
            SizedBox(height: 16.0),TextField(
              controller: _issuedateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter issuedate of the protask here',
              ),
            ),
            SizedBox(height: 16.0),
			TextField(
              controller: _completedateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter completedate of the protask here',
              ),
            ),
            SizedBox(height: 16.0),
			TextField(
              controller: _isueuseridController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter isueuserid of the protask here',
              ),
            ),
            SizedBox(height: 16.0),TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description of the protask here',
              ),
            ),
            SizedBox(height: 16.0),
			TextField(
              controller: _usergroupidController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter usergroupid of the protask here',
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: Text(
                  'Save the Protask',
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