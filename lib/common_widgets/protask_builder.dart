//////////////////////////////////////////////////////////////////////////////////////
// protask_builder.dart

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/models/protask.dart';

class ProtaskBuilder extends StatelessWidget {
  const ProtaskBuilder({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future<List<Protask>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Protask>>(
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
              final protask = snapshot.data![index];
              return _buildProtaskCard(protask, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildProtaskCard(Protask protask, BuildContext context) {
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
                protask.id.toString(),
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
                    protask.id.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.processdefinitionid.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.userid.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.issuedate,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.completedate,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.isueuserid.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.description,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.usergroupid.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  Text(
                    protask.repeat.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
				  	
                  //Text(protask.{COLUMN.NAME}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}