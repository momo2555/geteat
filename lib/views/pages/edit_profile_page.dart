import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/lang/lang.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        leadingWidth: 100,
      ),
      body: Form(
        
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SimpleText(text: Lang.l("Numéro de téléphone"), color: 1,),
              SimpleInput(
                placeholder: Lang.l("Numéro de téléphone"),
                type: "phone",
                style: "filled",
                validator: (val) {
                  //return _validatePhoneNumber(val);
                },
                onChange: (val) {
                  //_phoneSignin = val;
                },
              ),
              
              
             
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Theme.of(context).backgroundColor,
          height: (91),
          padding: EdgeInsets.all(16),
          child: ActionButton(
                    text:
                        Lang.l('Enregistrer'),
                    backColor: Theme.of(context).primaryColor,
                    filled: true,
                    expanded: true,
                    color: Theme.of(context).primaryColorLight,
                    action: () {
                      // ------------
                    },
                  ),
        ),
      ),
    );
  }

}