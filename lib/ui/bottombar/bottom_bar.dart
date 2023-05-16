import 'package:flutter/material.dart';

class BottomNavigationBarList extends StatefulWidget {
  const BottomNavigationBarList({super.key});

  @override
  State<StatefulWidget> createState() => BottomNavigationBarState();
}

class BottomNavigationBarState extends State<BottomNavigationBarList> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBarList'),
        backgroundColor: const Color(0XFF051e3e),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: BottomBarTypes.values.length,
        itemBuilder: (c, index) {
          return bottomBarItem(index);
        },
      ),
    );
  }

  Widget bottomBarItem(int index) {
    var type = BottomBarTypes.values[index];
    var itemsList = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_filled),
        label: "Home",
        backgroundColor: Color(0XFF451e3e),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.movie_creation_outlined),
        activeIcon: Icon(Icons.movie_creation_rounded),
        label: "Movies",
        backgroundColor: Color(0XFF451e3e),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.tv_sharp),
        activeIcon: Icon(Icons.tv_rounded),
        label: "Tv",
        backgroundColor: Color(0XFF451e3e),
      ),
    ];
    switch (type) {
      case BottomBarTypes.BASIC:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('BottomNavigationBar'),
            ),
            BottomNavigationBar(
              items: itemsList,
              currentIndex: selectedIndex,
              backgroundColor: const Color(0XFF251e3e),
              unselectedItemColor: Colors.white38,
              selectedItemColor: Colors.white,
              onTap: onItemTapped,
            )
          ],
        );
      case BottomBarTypes.SHIFTING:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('BottomNavigationBar Shifting Type'),
            ),
            BottomNavigationBar(
              items: itemsList,
              currentIndex: selectedIndex,
              unselectedItemColor: Colors.white38,
              selectedItemColor: Colors.white,
              onTap: onItemTapped,
              type: BottomNavigationBarType.shifting,
            )
          ],
        );
      case BottomBarTypes.SEMI_ROUNDED:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('BottomNavigationBar with Top Rounded Corner'),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                items: itemsList,
                currentIndex: selectedIndex,
                backgroundColor: const Color(0XFF651e3e),
                unselectedItemColor: Colors.white38,
                selectedItemColor: Colors.white,
                onTap: onItemTapped,
              ),
            )
          ],
        );
      case BottomBarTypes.ROUNDED:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('BottomNavigationBar with Rounded Corner'),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: BottomNavigationBar(
                items: itemsList,
                currentIndex: selectedIndex,
                backgroundColor: const Color(0XFF851e3e),
                unselectedItemColor: Colors.white38,
                selectedItemColor: Colors.white,
                onTap: onItemTapped,
              ),
            )
          ],
        );
      case BottomBarTypes.CUSTOM:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Custom BottomNavigationBar made with Widgets'),
            ),
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Container(
                  color: const Color(0XFFf6cd61),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: itemsList.length <= 2
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        for (final item in itemsList)
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              end: itemsList.indexOf(item) == selectedIndex
                                  ? 1
                                  : 0,
                            ),
                            curve: Curves.easeInToLinear,
                            duration: const Duration(milliseconds: 500),
                            builder: (_, value, ___) {
                              return customBottomNavigationBarItem(
                                  itemsList, item, value);
                            },
                          )
                      ],
                    ),
                  )),
            )
          ],
        );
    }
  }

  Widget customBottomNavigationBarItem(List<BottomNavigationBarItem> itemsList,
      BottomNavigationBarItem item, double value) {
    return InkWell(
      onTap: () => onItemTapped(itemsList.indexOf(item)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
          child: Container(
              width: 55,
              height: 55,
              decoration: itemsList.indexOf(item) == selectedIndex
                  ? const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFe0f2f1))
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(children: [
                  IconTheme(
                    data: IconThemeData(
                      color: Color.lerp(Colors.black26, Colors.black, value),
                      size: 24,
                    ),
                    child: itemsList.indexOf(item) == selectedIndex
                        ? item.activeIcon
                        : item.icon,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        item.label!,
                        style: TextStyle(
                            color:
                                Color.lerp(Colors.black26, Colors.black, value),
                            fontWeight: FontWeight.lerp(
                                FontWeight.normal, FontWeight.bold, value),
                            fontSize: itemsList.indexOf(item) == selectedIndex
                                ? 12
                                : 12),
                      )),
                ]),
              ))),
    );
  }
}

enum BottomBarTypes { BASIC, SHIFTING, SEMI_ROUNDED, ROUNDED, CUSTOM }
