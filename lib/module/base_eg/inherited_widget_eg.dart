import 'dart:math';

import 'package:flutter/material.dart';

///InheritedWidget 使用实例
class EgInheritedWidgetPage extends StatefulWidget {
  const EgInheritedWidgetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EgInheritedWidgetPageState();
  }
}

class _EgInheritedWidgetPageState extends State<EgInheritedWidgetPage> {
  String value = "赵钱孙李周吴郑王冯陈褚卫蒋沈韩杨";
  final List<String> _list = List.empty(growable: true);
  String studentName = "默认值";
  late Random _random;

  @override
  void initState() {
    super.initState();
    _random = Random(value.length);
    for (var element in value.characters) {
      _list.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedWidget"),
      ),
      body: Center(
        child: NameInheritedWidget(
          name: studentName,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const NamedWidget(),
              TextButton(
                onPressed: () {
                  int index = _random.nextInt(_list.length);
                  setState(() {
                    studentName = _list[index];
                  });
                },
                child: const Text("Changed name"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

class NameInheritedWidget extends InheritedWidget {
  final String name;

  const NameInheritedWidget({
    Key? key,
    required this.name,
    required Widget child,
  }) : super(key: key, child: child);

  static NameInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant NameInheritedWidget oldWidget) {
    //该回调决定当name发生变化的时候，是否通知子树依赖name的widget
    return oldWidget.name != name;
  }

}

class NamedWidget extends StatelessWidget {
  const NamedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Text(NameInheritedWidget.of(context)?.name ?? "--"),
    );
  }
}
