import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/utils/global_utils.dart';

class SignupConfirmPage extends StatefulWidget {
  const SignupConfirmPage({Key? key}) : super(key: key);

  @override
  State<SignupConfirmPage> createState() => _SignupConfirmPageState();
}

class _SignupConfirmPageState extends State<SignupConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(

          children: [
            SizedBox(
              height: 180,
            ),
            Image.asset('assets/images/confirm_picrure.png'),
            
            SizedBox(
                height: 25,
              ),
            SimpleText(
              text: Lang.l("Votre compte a bien été créé"),
              size: 20,
              thick: 6,
              color: 0,
              ),
               SimpleText(
              text: Lang.l("Vous avez ouvert votre compte avec succès !"),
              size: 14,
              thick: 3,
              color: 3,
              ),
            SizedBox(
                height: 70
                ,
              ),
            
           
            ActionButton(
              text: Lang.l("Valider"),
              filled: true,
              expanded: true,
              action: () {
               Globals.goBack(context);
              }
            ),
            SizedBox(
                height: 100
                ,
              ),
            SimpleText(text: "www.get-eat.app", color: 1,)
          ],
        ),
      ),
    );
  }
}