import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/profil_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/user_model.dart';
import 'package:geteat/models/user_profile_model.dart';

class SignupCodePage extends StatefulWidget {
  const SignupCodePage({Key? key, this.user}) : super(key: key);
  final UserProfileModel? user;
  
  @override
  State<SignupCodePage> createState() => _SignupCodePageState();
}

class _SignupCodePageState extends State<SignupCodePage> {


  FirebaseAuth auth = FirebaseAuth.instance;
  UserConnection? _userConnection;
  ProfileController _profileController = ProfileController();
  
  final GlobalKey<FormState> _signupCodeKey = GlobalKey<FormState>();
  String _smsCode = "";
  String _checkId = "";




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   _userConnection = UserConnection();
   _userConnection?.pocessPhone(widget.user?.phone??'', (user) {
    _checkId = user.checkId;
   }, (Credential, user) {

   });
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
              text: "Code de confirmation",
              size: 18,
              thick: 9,
            ),
            SizedBox(
                height: 25,
              ),
            SimpleInput(
              placeholder: "Code",
              type: "numeric",
              onChange: (val){
                _smsCode = val;
              },
            ),
             ActionButton(
              text: "Renvoyer le code",
              filled: false,
              hasBorder: false,
            ),
            SizedBox(
                height: 15,
              ),
            ActionButton(
              text: "Valider",
              filled: true,
              action: ()async {
                final form = _signupCodeKey.currentState!;
                if (!form.validate()) {
                  /*_autoValidateModeIndex.value =
                      AutovalidateMode.always.index;*/ // Start validating on every change.
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez corriger vos erreurs')));
                } else {
                  form.save();
                  
                  // Update the UI - wait for the user to enter the SMS code
                  

                  // Create a PhoneAuthCredential with the code
                  try {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _checkId, smsCode: _smsCode);
                    
                    // Sign the user in (or link) with the credential
                    UserProfileModel userProfile = widget.user ?? UserProfileModel('', '', '', '');
                    UserModel userTemp = await _userConnection!.createAccount(widget.user!.email, widget.user!.password, credential);
                    userProfile.uid = userTemp.uid;
                    await _profileController.createProfileByProfieModel(userProfile);
                    //UserCredential credentialUser = await auth.signInWithCredential(credential);
                    
                    //GoogleAuthCredential googleCredential;
                    
                    print('Connection ok');
                    Navigator.pushNamed(context, '/signup_confirm');
                  } on Exception catch (e) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Une erreur s'est produite lors de la création de votre compte")));

                  }
                  //credentialUser.user.li
                }
              },
              
            ),
            ],
          ),
        ),
      ),
    );
  }
}
