import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/focuse_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/utils/global_utils.dart';

/*import 'package:legend_app/models/userModel.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/vues/Client.dart';*/

class MainSignPage extends StatefulWidget {
  const MainSignPage({Key? key}) : super(key: key);

  @override
  _MainSignPageState createState() => _MainSignPageState();
}

class _MainSignPageState extends State<MainSignPage> {
  UserConnection _userConnection = UserConnection();

  String _password = '';
  String _phoneSignin = '';

  int _signinTentatives = 0;

  //keys

  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();

  Widget? _actualSign;
  String? _validatePhoneNumber(String? value) {
    final phoneExp = RegExp(r'^\(0\)\d \d\d \d\d\ \d\d \d\d$');
    if (!phoneExp.hasMatch(value!)) {
      return "Le numéro de téléphone n'est pas valide";
    }
    return null;
  }

  Widget _signin() {
    return Form(
      key: _signinKey,
      autovalidateMode:
          _signinTentatives > 0 ? AutovalidateMode.onUserInteraction : null,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 470),
          key: ValueKey(1),
          child: Column(
            children: [
              SimpleInput(
                placeholder: "Numéro de téléphone",
                type: "phone",
                style: "filled",
                validator: (val) {
                  return _validatePhoneNumber(val);
                },
                onChange: (val) {
                  _phoneSignin = val;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleInput(
                placeholder: "Mot de passe",
                type: "password",
                style: "filled",
                onChange: (val) {
                  _password = val;
                },
              ),
              SizedBox(
                height: 0,
              ),
              ActionButton(
                text: "Mot de passe oublié ?",
                color: Theme.of(context).primaryColor,
                filled: false,
                hasBorder: false,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ActionButton(
                      text: "Connexion",
                      rounded: true,
                      filled: true,
                      backColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColorLight,
                      action: () {
                        final form = _signinKey.currentState!;
                        setState(() {
                          _signinTentatives++;
                        });

                        if (!form.validate()) {
                          /*_autoValidateModeIndex.value =
                              AutovalidateMode.always.index;*/ // Start validating on every change.
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Veuillez corriger vos erreurs')));
                        } else {
                          form.save();
                          //_emailPassWordvalidator();
                          //connect the user
                          Globals.connexionWait.value = true;
                          String phone = "+33" +
                              _phoneSignin
                                  .replaceAll("(0)", "")
                                  .replaceAll(" ", "");
                          print(phone);
                          _userConnection
                              .authentification(phone, _password)
                              .then((value) {
                            Globals.connexionWait.value = false;
                            if (value.uid == "" && value.email == "") {
                              Fluttertoast.showToast(
                                  msg:
                                      "Les identifiants que vous avez renseigné sont incorrectes");
                            }
                          });
                        }
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: Globals.connexionWait,
                        builder: (context, bool value, widget) {
                          if (value) {
                            return SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ));
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Divider(
                              color: Theme.of(context).primaryColorLight),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SimpleText(
                            text: "OU",
                            color: 1,
                            size: 12,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Divider(
                              color: Theme.of(context).primaryColorLight),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ActionButton(
                        text: "Inscription",
                        //clear: true,
                        rounded: true,
                        backColor: Theme.of(context).primaryColorDark,
                        color: Theme.of(context).primaryColor,
                        filled: true,
                        action: () {
                          Navigator.pushNamed(context, '/signup_name');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(children: [
                    SizedBox(
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Image.asset('assets/logos/geteat_logo.png'),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    _signin(),
                    SizedBox(
                      height: 40,
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
