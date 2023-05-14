import 'package:flutter/material.dart';

import '../button/button_list.dart';
import '../text/text_list.dart';

class ExploreList extends StatefulWidget {
  const ExploreList({super.key});

  @override
  State<StatefulWidget> createState() => ExploreListState();
}

class ExploreListState extends State<ExploreList> {
  final List<String> entries = <String>['Text', 'Buttons',];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: entries.length + 1,
      itemBuilder: (c, index) {
        if (index == entries.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'More Views Coming Soon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Image.network('https://media1.giphy.com/media/UAkLHNaScd6Zjlx5eZ/giphy.gif'),
            ]
          );
        }
        return listItem(index);
      },
    );
  }

  Widget listItem(int index) => ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            switch(index) {
              case 0: return const TextList();
              case 1: return const ButtonList();
            }
            return const TextList();
          },
        ),
      );
    },
    title: Center(
      child: Card(
        elevation: 4,
        color: Colors.amber,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(entries[index]),
        ),
      ),
    ),
  );
}
