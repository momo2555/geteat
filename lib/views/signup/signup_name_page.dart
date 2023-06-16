import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/user_profile_model.dart';
import 'package:geteat/utils/phone_utils.dart';

class SignupNamePage extends StatefulWidget {
  const SignupNamePage({Key? key}) : super(key: key);

  @override
  State<SignupNamePage> createState() => _SignupNamePageState();
}

class _SignupNamePageState extends State<SignupNamePage> {
  UserConnection _userConnection = UserConnection();
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  int _signupTentatives = 1;
  bool _emailExists = false;
  bool _emailFirstverification = false;
  bool _phoneExists = false;
  bool _phoneFirstVerification = false;
  //focus
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();

  //validators
  
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return Lang.l("Vous devez absolument entrer un nom");
    }
    final nameExp = RegExp(r"^[A-Za-z ']+$");
    if (!nameExp.hasMatch(value)) {
      return Lang.l("Votre nom doit se composer que de lettres");
    }
    return null;
  }
  String? _lastEmailValue = "";
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      _lastEmailValue = value;
      return Lang.l("Veuillez saisir une adresse E-mail");
    }
    final nameExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!nameExp.hasMatch(value)) {
      _lastEmailValue = value;
      return Lang.l( "Adresse E-mail incorrecte");
    }
    if(_lastEmailValue!=value){
      _userConnection.isEmailExists(value).then((val){
        _emailFirstverification = true;
        
          setState(() {
            _emailExists=val;
            print("send request mail");
          });
         
      });
    }  
    if (_emailExists){
      _lastEmailValue = value;
      return Lang.l("Cette addresse e-mail existe déjà.");
    }
    _lastEmailValue = value;
    return null;
  }
  String? _lastPhoneValue = "";
  String? _validatePhoneNumber(String? value) {
    final phoneExp = RegExp(r'^\(0\)\d \d\d \d\d\ \d\d \d\d$');
    if (!phoneExp.hasMatch(value!)) {
      _lastPhoneValue = value;
      return Lang.l("Le numéro de téléphone n'est pas valide");
    }
    if(_lastPhoneValue!=value){
      print(PhoneUtils.trimePhone(value));
      _userConnection.isPhoneExists(PhoneUtils.trimePhone(value)).then((val){
        _phoneFirstVerification = true;
          
          setState(() {
            _phoneExists = val;
            print("send request phone");
          });
        
      });
    }  
    if(_phoneExists) {
      _lastPhoneValue = value;
      return Lang.l("ce numéro de téléphone existe déjà");
    }
    _lastPhoneValue = value;
    return null;
  }
  String? _validatePassword1(String? value) {
    
    if (value == null || value.isEmpty) {
      return Lang.l("Le mot de passe ne peut pas être vide");
    }else if (value.length < 8) {
      return Lang.l("Le mot de passe doit contenir au moins 8 caractères");
    }
    
    return null;
  }
 String? _validatePassword2(String? value) {
    if (value == null || value.isEmpty) {
      return Lang.l("Veuillez resaisir le mot de passe");
    }
    if (_password1!=value) {
      return Lang.l("Les mots de passe sont différents");
    }
    
    return null;
  }
 
   //values
  String _email = '';
  String _name = "";
  String _lastName = "";
  String _phoneSignup = "";
  String _password1 = '';
  String _password2 = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leadingWidth: 80,
      ),
      body: Form(
        key: _signupKey,
        autovalidateMode: _signupTentatives > 0 ? AutovalidateMode.onUserInteraction : null,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
      
            children: [
              
            SizedBox(
              height: 50,
            ),
              
            SimpleInput(
              placeholder: "(0)6 12 34 56 78",
              label: Lang.l("Numéro de téléphone"),
              type: "phone",
              validator: (val) {return _validatePhoneNumber(val);},
              onChange: (val){
                _phoneSignup = val;
              },
            ),
            SizedBox(
                height: 18,
              ),
            SimpleInput(
              placeholder: Lang.l("E-mail"),
              label: Lang.l("Adresse e-mail"),
              type: "text",
              nextNode: _nameFocus,
              focusNode: _emailFocus,
              validator: (val) {return  _validateEmail(val);},
              onChange: (val) {
                _email = val;
              },
            ),
            SizedBox(
                height: 15,
              ),
             
            SimpleInput(
              placeholder: Lang.l("Nom"),
              label: Lang.l("Nom et prénom"),
              type: "text",
              validator: (val)=>_validateName(val),
              focusNode: _nameFocus,
              nextNode: _lastNameFocus,
              onChange: (val){
                _name = val;
              },
            ),
            SizedBox(
                height: 15,
              ),
            SimpleInput(
              placeholder: Lang.l("Mot de passe"),
              label: Lang.l("Mot de passe"),
              type: "password",
              onChange: (val){
                _password2 = val;
              },
              validator: (val) =>_validatePassword2(val),
            ),
            SizedBox(
                height: 15,
              ),
           
            SimpleInput(
              placeholder: Lang.l("Mot de passe"),
              label: Lang.l("Retappez le mot de passe"),
              type: "password",
              onChange: (val){
                _password1 = val;
              },
              validator: (val) =>_validatePassword1(val),
            ),
             
            SizedBox(
                height: 140,
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: ActionButton(
                expanded: true,
                text: Lang.l("Valider"),
                
                filled: true,
                backColor: Theme.of(context).primaryColor,
                rounded: true,
                action: () async {
                  
                  final form = _signupKey.currentState!;
                  setState(() {
                    _signupTentatives++;
                  });
                  
                  if (!form.validate()) {
                    /*_autoValidateModeIndex.value =
                        AutovalidateMode.always.index;*/ // Start validating on every change.
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Lang.l('Veuillez corriger vos erreurs'))));
                  } else {
                    form.save();
                    //adapt phone number
                   _phoneSignup =  PhoneUtils.trimePhone(_phoneSignup);
                    //TODO verification ----------------------
                    UserProfileModel userProfile = UserProfileModel(_email, _phoneSignup, _password1, '');
                    userProfile.userName = _name;
                    Navigator.pushNamed(context, '/signup_code', arguments: userProfile);
                    //_emailPassWordvalidator();
                  }
                     
                }
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}