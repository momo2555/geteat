

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/focuse_button.dart';
import 'package:geteat/components/simple_input.dart';

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
  String _email = '';
  Widget _signType() {
    return const FocusButton(
        buttonList: ["Connexion", "Inscription"], byDefault: "Connexion");
  }

  Widget _signin() {
    return Column(
      children: const [
         SimpleInput(
          placeholder: "Numéro de téléphone",
          type: "phone",
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
    );
  }

  Widget _signup() {
    return Container();
  }

  Widget _passwordEntry() {
    return TextFormField(
      obscureText: true,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key, color: Theme.of(context).accentColor),
        hintText: 'Mot de passe',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

  Widget _emailEntry() {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Theme.of(context).accentColor),
          hintText: 'Adresse e-mail',
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none),
          fillColor: Theme.of(context).backgroundColor,
          filled: true,
          contentPadding: EdgeInsets.all(15)),
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  Widget _submitButton() {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
            child: Text('Mot de passe oublier',
                style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300))),
        VerticalDivider(
            color: Theme.of(context).backgroundColor,
            thickness: 2,
            indent: 0,
            endIndent: 5,
            width: 5),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text('Je n\'ai pas de compte',
                style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () async {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
            child: Container(
              height: 60,
              width: 60,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).accentColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(children: [
                    SizedBox(
                      height: 170,
                    ),
                    Image.asset('assets/logos/geteat_logo.png'),
                    SizedBox(
                      height: 100,
                    ),
                    _signType(),
                    SizedBox(
                      height: 40,
                    ),
                    _signin(),
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
