import 'package:flutter/material.dart';
import 'package:sm/module/base_eg/inherited_widget_eg.dart';

class BaseListPage extends StatefulWidget {
  const BaseListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BaseListPageState();
  }
}

class _BaseListPageState extends State<BaseListPage> {
  List data = [
    _Item(name: "InheritedWidget", routeWidget: const EgInheritedWidgetPage())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Base"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              if (data[index].routeWidget != null) {
                Navigator.of(ctx).push(MaterialPageRoute(builder: (bCtx) {
                  return data[index].routeWidget;
                }));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: Text(
                "${data[index].name}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}

class _Item {
  final String name;
  final Widget? routeWidget;

  _Item({required this.name, this.routeWidget});
}
