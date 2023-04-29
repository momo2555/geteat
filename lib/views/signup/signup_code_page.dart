import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/profil_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/load_model.dart';
import 'package:geteat/models/user_model.dart';
import 'package:geteat/models/user_profile_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupCodePage extends StatefulWidget {
  const SignupCodePage({Key? key, this.user}) : super(key: key);
  final UserProfileModel? user;

  @override
  State<SignupCodePage> createState() => _SignupCodePageState();
}

class _SignupCodePageState extends State<SignupCodePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserConnection _userConnection = UserConnection();
  ProfileController _profileController = ProfileController();

  final GlobalKey<FormState> _signupCodeKey = GlobalKey<FormState>();
  String _smsCode = "";
  String _checkId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userConnection = UserConnection();
    _userConnection.pocessPhone(widget.user?.phone ?? '', (user) {
      _checkId = user.checkId;
    }, (Credential, user) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        leadingWidth: 100,
      ),
      body: Form(
        key: _signupCodeKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 29,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 60,
                        child: Image.asset('assets/images/smartphone.png')),
                    SizedBox(
                      height: 20,
                    ),
                    SimpleText(
                      text: "Code de confirmation",
                      size: 24,
                      thick: 6,
                    ),
                    SimpleText(
                      text:
                          "Un code vous est envoyé par sms afin de vérifier de votre numéro de téléphone",
                      size: 13,
                      thick: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                enableActiveFill: true,
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  _smsCode = val;
                },
                pinTheme: PinTheme(
                  borderRadius: BorderRadius.circular(6),
                  borderWidth: 0.5,
                  fieldHeight: 57,
                  fieldWidth: 53,
                  activeColor: Theme.of(context).primaryColor,
                  errorBorderColor: Theme.of(context).backgroundColor,
                  activeFillColor: Theme.of(context).backgroundColor,
                  selectedColor: Theme.of(context).primaryColor,
                  selectedFillColor: Theme.of(context).backgroundColor,
                  disabledColor: Theme.of(context).backgroundColor,
                  inactiveColor: Theme.of(context).backgroundColor,
                  inactiveFillColor: Theme.of(context).primaryColorDark,
                  shape: PinCodeFieldShape.box,
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 57),
                child: Column(
                  children: [
                    ActionButton(
                      text: "Renvoyer le code",
                      expanded: true,
                      clear: true,
                      filled: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ActionButton(
                      text: "Valider",
                      filled: true,
                      expanded: true,
                      action: () async {
                        final form = _signupCodeKey.currentState!;
                        if (!form.validate()) {
                          /*_autoValidateModeIndex.value =
                            AutovalidateMode.always.index;*/ // Start validating on every change.
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Veuillez corriger vos erreurs')));
                        } else {
                          form.save();

                          // Update the UI - wait for the user to enter the SMS code

                          // Create a PhoneAuthCredential with the code
                          try {
                            //UserCredential credentialUser = await auth.signInWithCredential(credential);

                            //GoogleAuthCredential googleCredential;

                            print('Connection ok');
                            Navigator.pushNamed(
                              context,
                              '/load_page',
                              arguments: LoadModel(
                                callback: (_) async {
                                  try {
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: _checkId,
                                            smsCode: _smsCode);

                                    // Sign the user in (or link) with the credential
                                    UserProfileModel userProfile =
                                        widget.user ??
                                            UserProfileModel('', '', '', '');
                                    UserModel userTemp =
                                        await _userConnection.createAccount(
                                            widget.user!.email,
                                            widget.user!.password,
                                            credential);
                                    userProfile.uid = userTemp.uid;
                                    await _profileController
                                        .createProfileByProfileModel(
                                            userProfile);
                                  } catch (e) {}
                                },
                                afterCallback: (_) {
                                  Navigator.pop(context, (route) => true);
                                  Navigator.pushNamed(context, '/client_home');
                                  Navigator.pushNamed(
                                      context, '/signup_confirm');
                                },
                                message: "Compte en cours de creéation",
                                minimumTime: 1,
                              ),
                            );
                          } on Exception catch (e) {
                           Fluttertoast.showToast(msg: 
                                    "Une erreur s'est produite lors de la création de votre compte");
                          }
                          //credentialUser.user.li
                        }
                      },
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
}
