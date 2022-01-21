import 'package:flutter/material.dart';
import 'package:sm/module/bloc/common/bl_route.dart';

//Bloc 演示App
class BlocAppPage extends StatelessWidget {
  const BlocAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bloc",
      theme: ThemeData(primaryColor: Colors.orange),
      // initialRoute: BlRoute.blHome,
      routes: BlRoute.routes,
      home: const BlocHomePage(),
    );
  }
}

class BlocHomePage extends StatefulWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BlocHomePageState();
  }
}

class BlocHomePageState extends State<BlocHomePage> {
  final ButtonStyle _buttonStyle = TextButton.styleFrom(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blCubitPage);
                    },
                    child: const Text("Cubit简介"),
                    style: _buttonStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blCounterCubitPage);
                    },
                    child: const Text("Cubit+BlocProvider+BlocBuilder"),
                    style: _buttonStyle,
                  )
                ],
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blBlocPage);
                    },
                    child: const Text("Bloc简介"),
                    style: _buttonStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blCounterBlocPage);
                    },
                    child: const Text("Bloc+BlocProvider+BlocBuilder"),
                    style: _buttonStyle,
                  )
                ],
              ),
              const Text("Bloc example"),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blFormValidatePage);
                    },
                    child: const Text("Form validate"),
                    style: _buttonStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blBlocWithStreamPage);
                    },
                    child: const Text("bloc with stream"),
                    style: _buttonStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, BlRoute.blComplexListPage);
                    },
                    child: const Text("complex list"),
                    style: _buttonStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
