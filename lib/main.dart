import 'package:flutter/material.dart';

import 'home/explore_list.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Explore Flutter'),
      ),
      body: const ExploreList(),
    ),
  ));
}
