//////////////////////////////////////////////////////////////////////////////////////
// prorole_builder.dart

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/models/prorole.dart';

class ProroleBuilder extends StatelessWidget {
  const ProroleBuilder({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future<List<Prorole>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Prorole>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final prorole = snapshot.data![index];
              return _buildProroleCard(prorole, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildProroleCard(Prorole prorole, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(
                prorole.id.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
				  Text(
                    prorole.id.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    prorole.description,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    prorole.active.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    prorole.rightid.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  	
                  //Text(prorole.{COLUMN.NAME}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
