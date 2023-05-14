
import 'package:flutter/material.dart';

class TextList extends StatefulWidget {
  const TextList({super.key});

  @override
  State<StatefulWidget> createState() => TextListState();
}

enum TextTypes {
  BASIC_TEXT,
  RICH_TEXT,
}

class TextListState extends State<TextList> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: TextTypes.values.length,
        itemBuilder: (c, index) {
          return textItem(index);
        },
      ),
    );
  }

  Widget textItem(int index) {
    var type = TextTypes.values[index];
    switch(type) {
      case TextTypes.BASIC_TEXT:
        return const Text('This is a basic text with all flutter default configuration');
      case TextTypes.RICH_TEXT:
       return const Text('Modified Text',

         style: TextStyle(fontWeight: FontWeight.bold,
             fontSize: 20,
             color: Colors.deepOrangeAccent,
             backgroundColor: Colors.greenAccent,
             letterSpacing: 10,

         ),
       );
    }
  }
}
