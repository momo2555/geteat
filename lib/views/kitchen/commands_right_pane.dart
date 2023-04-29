import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class CommandsRightPane extends StatefulWidget {
  const CommandsRightPane({Key? key}) : super(key: key);

  @override
  State<CommandsRightPane> createState() => _CommandsRightPaneState();
}

class _CommandsRightPaneState extends State<CommandsRightPane> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 2,
        foregroundColor: Theme.of(context).backgroundColor,
        title: SimpleText(
          text: "Livraisons",
          color: 2,
          thick: 6,
          size: 16,
        ),
        centerTitle: true,
        
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(),
    );
    
  }
}