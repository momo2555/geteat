import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/focuse_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';

/*import 'package:legend_app/models/userModel.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/vues/Client.dart';*/

class MainSignPage extends StatefulWidget {
  const MainSignPage({Key? key}) : super(key: key);

  @override
  _MainSignPageState createState() => _MainSignPageState();
}

class _MainSignPageState extends State<MainSignPage> {
  String _password = '';
  String _phoneSignin = '';
  String _phoneSignup = "";

  //keys
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();

  Widget? _actualSign;
  String? _validatePhoneNumber(String? value) {
    final phoneExp = RegExp(r'^\(0\)\d \d\d \d\d\ \d\d \d\d$');
    if (!phoneExp.hasMatch(value!)) {
      return "Le numéro de téléphone n'est pas valide";
    }
    return null;
  }
  Widget _signType() {
    return FocusButton(
        buttonList: const ["Connexion", "Inscription"], byDefault: "Connexion",
        onChange: (button) {
          if(button == "Connexion") {
            setState(() {
              _actualSign = _signin();
            });
          }else {
            setState(() {
              _actualSign = _signup ();
            });
          }
        },
      );
  }

  Widget _signin() {
    return Form(
      key: _signinKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        height: 350,
        key: ValueKey(1),
        child: Column(
          
          children:  [
            SimpleInput(
              placeholder: "Numéro de téléphone",
              type: "phone",
              validator: (val) {return _validatePhoneNumber(val);},
            ),
            SizedBox(
              height: 10,
            ),
            SimpleInput(
              placeholder: "Mot de passe",
              type: "password",
            ),
            SizedBox(
              height: 0,
            ),
            ActionButton(
              text: "Mot de passe oublié ?",
              filled: false,
              hasBorder: false,
            ),
            SizedBox(
              height: 30,
            ),
            ActionButton(
              text: "Connexion",
              filled: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _signup() {
    return Form(
      key: _signupKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        key: ValueKey(2),
        height: 350,
        child: Column(
           
          children:  [
            SizedBox(
              height: 10,
            ),
            SimpleText(
              text: "Numéro de téléphone",
              size: 18,
              thick: 9,
            ),
            SizedBox(
              height: 30,
            ),
            SimpleInput(
              placeholder: "Numéro de téléphone",
              type: "phone",
              validator: (val) {return _validatePhoneNumber(val);},
              onChange: (val){
                _phoneSignup = val;
              },
            ),
            SizedBox(
              height: 30,
            ),
            ActionButton(
              text: "Valider",
              filled: true,
              action: () {
                Navigator.pushNamed(context, '/signup_code');
              }
            ),
            
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(children: [
                    SizedBox(
                      height: 190,
                    ),
                    Image.asset('assets/logos/geteat_logo.png'),
                    SizedBox(
                      height: 100,
                    ),
                    _signType(),
                    SizedBox(
                      height: 40,
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: _actualSign ?? _signin(),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
