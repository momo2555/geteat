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
  String _password1 = '';
  String _password2 = '';
  String? _validatePassword1(String? value) {
    
    if (value == null || value.isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    }else if (value.length < 8) {
      return "Le mot de passe doit contenir au moins 8 caractères";
    }
    
    return null;
  }
 String? _validatePassword2(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez resaisir le mot de passe";
    }
    if (_password1!=value) {
      return "Les mots de passe sont différents";
    }
    
    return null;
  }
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        leadingWidth: 100,
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
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
              onChange: (val){
                _password1 = val;
              },
              validator: (val) =>_validatePassword1(val),
            ),
            SizedBox(
                height: 15,
              ),
            SimpleInput(
              placeholder: "Mot de passe",
              type: "password",
              onChange: (val){
                _password2 = val;
              },
              validator: (val) =>_validatePassword2(val),
            ),
             
            SizedBox(
                height: 30,
              ),
            ActionButton(
              text: "Valider",
              filled: true,
              action: () {
                Navigator.pushNamed(context, '/signup_confirm');
              }
            ),
            ],
          ),
        ),
      ),
    );
  }
}