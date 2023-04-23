import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/load_model.dart';
import 'package:geteat/utils/global_utils.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({
    Key? key,
    required this.load,
  }) : super(key: key);
  final LoadModel load;
  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  bool _disposed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final y = Future.delayed(Duration(seconds: widget.load.minimumTime ?? 0))
        .then((value) async {
      await widget.load.callback(context);
      if (!_disposed) {
        Globals.goBack(context);
        widget.load.afterCallback != null
            ? widget.load.afterCallback!(context)
            : () {};
      }
    });
  }

  @override
  void dispose() {
    _disposed = true;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 10,
                  
                ),
              ),
              SizedBox(height: 20),
              SimpleText(
                text: widget.load.message ?? ".",
                size: 20,
                thick: 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
