import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
class SignupPasswordPage extends StatefulWidget {
  const SignupPasswordPage ({Key? key}) : super(key: key);

  @override
  State<SignupPasswordPage> createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage
> {
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
            text: "Nouveau mot de passe",
            size: 18,
            thick: 9,
          ),
          SizedBox(
              height: 25,
            ),
          SimpleInput(
            placeholder: "Mot de passe",
            type: "password",
          ),
          SizedBox(
              height: 15,
            ),
          SimpleInput(
            placeholder: "MOt de passe",
            type: "password",
          ),
           
          SizedBox(
              height: 30,
            ),
          ActionButton(
            text: "Valider",
            filled: true,
            action: () {
             
            }
          ),
          ],
        ),
      ),
    );
  }
}