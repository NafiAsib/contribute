import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chingchong'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(color: const Color(0xFF000000)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // const SizedBox(
              //   width: 15,
              // ),
              Column(
                children: [
                  const Text(
                    'PyTorch',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Text(
                    'Maintained by: Facebook',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Text(
                    'Technologies:',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Column(
                        children: const [
                          Text(
                            '101',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Open PRs',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: const [
                          Text(
                            '75',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Issues',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        children: const [
                          Text(
                            '35',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Contributors',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'Beginner',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Intermediate',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Expert',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
