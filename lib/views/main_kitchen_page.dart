import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainKitchenPage extends StatefulWidget {
  const MainKitchenPage({Key? key}) : super(key: key);

  @override
  State<MainKitchenPage> createState() => _MainKitchenPageState();
}

class _MainKitchenPageState extends State<MainKitchenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Container(),
    );
  }
}
