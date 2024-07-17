import 'package:flutter/material.dart';

class testing extends StatefulWidget {
  const testing({super.key});

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('flutter architecture'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.zero,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Architecture',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Framework (Dart)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [

                                  Flexible(child: _buildPurpleBox('Material')),
                                  SizedBox(width: 6),
                                  Flexible(child: _buildPurpleBox('Cupertino')),

                                ],
                              ),
                              SizedBox(height: 8),
                              _buildLargePurpleBox('Widgets'),
                              SizedBox(height: 8),
                              _buildLargePurpleBox('Rendering'),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Flexible(child: _buildPurpleBox('Animation')),
                                  SizedBox(width: 6),
                                  Flexible(child: _buildPurpleBox('Painting')),
                                  SizedBox(width: 6),
                                  Flexible(child: _buildPurpleBox('Gestures')),
                                ],
                              ),
                              SizedBox(height: 8),
                              _buildLargePurpleBox('Foundation'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Engine (C++)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(child: _buildRedBox('Skia')),
                                  SizedBox(width: 22),
                                  Flexible(child: _buildRedBox('Dart')),
                                  SizedBox(width: 22),
                                  Flexible(child: _buildRedBox('Text')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurpleBox(String text) {
    return Container(
      width: 100,
      height: 50,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget _buildLargePurpleBox(String text) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget _buildRedBox(String text) {
    return Container(
      width: 100,
      height: 50,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text)),
    );
  }
}