import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/views/kitchen/commands_left_pane.dart';
import 'package:geteat/views/kitchen/commands_right_pane.dart';

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
    return TwoPane(
      
      paneProportion: 0.6,
      startPane: CommandLeftPane(),
      endPane: CommandsRightPane(),
    );
  }
}
