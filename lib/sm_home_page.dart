import 'package:flutter/material.dart';
import 'package:sm/module/base_eg/base_list.dart';

class SmHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SmHomePageState();
  }
}

class _SmHomePageState extends State<SmHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Wrap(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (bContext) {
                    return const BaseListPage();
                  }));
                },
                child: const Text(
                  "Base",
                  style: TextStyle(fontSize: 26),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
