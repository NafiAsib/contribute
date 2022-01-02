import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contribute/presentation/widgets/drawer.dart';
import 'package:contribute/presentation/widgets/project_widget.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Stream<QuerySnapshot> _projectStream =
      FirebaseFirestore.instance.collection('projects').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-project');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      //   body: Padding(
      //     padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      //     child: ListView.separated(
      //       separatorBuilder: (BuildContext context, int index) =>
      //           const SizedBox(height: 20),
      //       itemCount: 10,
      //       itemBuilder: (BuildContext context, int index) {
      //         return const Project();
      //       },
      //     ),
      //   ),
      // );
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _projectStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      Project(
                        maintainer: data['maintainer'],
                        name: data['name'],
                        topics: data['topics'],
                        issues: data['noOfIssues'],
                        fork: data['noOfForks'],
                        description: data['description'],
                        beginner: data['beginner'],
                        intermediate: data['intermediate'],
                        expert: data['expert'],
                        maintainerImage: data['maintainerImage'],
                        url: data['svnUrl'],
                        stars: data['noOfStars'],
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
