import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';

class SignupConfirmPage extends StatefulWidget {
  const SignupConfirmPage({Key? key}) : super(key: key);

  @override
  State<SignupConfirmPage> createState() => _SignupConfirmPageState();
}

class _SignupConfirmPageState extends State<SignupConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(

          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset('assets/logos/geteat_logo.png'),
            SizedBox(
              height: 100,
            ),
            SimpleText(
              text: "Now, you get it!",
              size: 16,
              thick: 3,
              color: 1,
              ),
            SizedBox(
                height: 25,
              ),
            SimpleText(
              text: "VOTRE COMPTE A BIEN ETE CREE",
              size: 25,
              thick: 9,
              color: 0,
              ),
            SizedBox(
                height: 25,
              ),
            
            SizedBox(
                height: 15,
              ),
            ActionButton(
              text: "Valider",
              filled: true,
              action: () {
                Navigator.pushNamed(context, '/client_home');
              }
            ),
          ],
        ),
      ),
    );
  }
}