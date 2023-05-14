import 'package:flutter/material.dart';

class ButtonList extends StatefulWidget {
  const ButtonList({super.key});

  @override
  State<StatefulWidget> createState() => ButtonListState();
}

enum ButtonTypes { ELEVATE_BUTTON, FILLED_BUTTON, OUTLINED_BUTTON }

class ButtonListState extends State<ButtonList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: ButtonTypes.values.length,
        itemBuilder: (c, index) {
          return buttonItem(index);
        },
      ),
    );
  }

  Widget buttonItem(int index) {
    var type = ButtonTypes.values[index];
    switch (type) {
      case ButtonTypes.ELEVATE_BUTTON:
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
    backgroundColor: Colors.greenAccent,
              textStyle: const TextStyle(fontSize: 20)),
          child: const Text('ElevatedButton'),
        );
      case ButtonTypes.OUTLINED_BUTTON:
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          child: const Text('OutlinedButton'),
        );
      case ButtonTypes.FILLED_BUTTON:
        return FilledButton(
          onPressed: () {},
          style:
              FilledButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  textStyle: const TextStyle(fontSize: 20)),
          child: const Text('FilledButton'),
        );
    }
  }
}
