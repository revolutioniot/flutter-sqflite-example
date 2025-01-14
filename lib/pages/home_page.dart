import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/common_widgets/dog_builder.dart';
import 'package:flutter_sqflite_example/common_widgets/breed_builder.dart';
import 'package:flutter_sqflite_example/common_widgets/prorole_builder.dart';
import 'package:flutter_sqflite_example/common_widgets/protask_builder.dart';
import 'package:flutter_sqflite_example/models/breed.dart';
import 'package:flutter_sqflite_example/models/dog.dart';
import 'package:flutter_sqflite_example/pages/breed_form_page.dart';
import 'package:flutter_sqflite_example/models/prorole.dart';
import 'package:flutter_sqflite_example/pages/prorole_form_page.dart';
import 'package:flutter_sqflite_example/pages/dog_form_page.dart';
import 'package:flutter_sqflite_example/services/database_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_sqflite_example/models/protask.dart';
import 'package:flutter_sqflite_example/pages/protask_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Protask>> _getProtasks() async {
    return await _databaseService.protasks();
  }

  Future<List<Dog>> _getDogs() async {
    return await _databaseService.dogs();
  }

  Future<List<Breed>> _getBreeds() async {
    return await _databaseService.breeds();
  }

  Future<List<Prorole>> _getProroles() async {
    return await _databaseService.proroles();
  }

  Future<void> _onDogDelete(Dog dog) async {
    await _databaseService.deleteDog(dog.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dog Database'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Dogs'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Breeds'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Proroles'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Protasks'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DogBuilder(
              future: _getDogs(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => DogFormPage(dog: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onDogDelete,
            ),
            BreedBuilder(
              future: _getBreeds(),
            ),
            ProroleBuilder(
              future: _getProroles(),
            ),
            ProtaskBuilder(
              future: _getProtasks(),
            ),

          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
              Navigator.of(context)
                .push(
                  MaterialPageRoute(
                  builder: (_) => ProtaskFormPage(),
                  fullscreenDialog: true,
                  ),
                )
                .then((_) => setState(() {}));
              },
              heroTag: 'addProtask',
              child: FaIcon(FontAwesomeIcons.plus),
            ),
            SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => ProroleFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addProrole',
              child: FaIcon(FontAwesomeIcons.plus),
            ),
            SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => BreedFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addBreed',
              child: FaIcon(FontAwesomeIcons.plus),
            ),
            SizedBox(height: 12.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => DogFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addDog',
              child: FaIcon(FontAwesomeIcons.paw),
            ),
          ],
        ),
      ),
    );
  }
}
