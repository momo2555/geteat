import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/profile_list_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/profil_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/user_model.dart';
import 'package:geteat/models/user_profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserConnection _userConnection = UserConnection();
  ProfileController _profileController = ProfileController();
  UserProfileModel? _userProfile;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _profileController.getUserProfile.then((UserProfileModel user) {
      setState(() => _userProfile = user);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Icon(Icons.person, size: 100, color: Theme.of(context).primaryColor,),
              SizedBox(height: 5,),
              SimpleText(
                text: _userProfile?.userName ?? '',
                thick: 9,
                size: 24,
              ),
              SimpleText(
                text: _userProfile?.phone ?? '',
                size: 13,
                thick: 9,
                color: 1,
                ),
              SizedBox(height: 48,),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                SimpleText(text: "Informations personnelles", thick: 9,size: 16,),
                SizedBox(height: 8),
                ProfileListElement(action: (){}, title: "Nom et prénom", description: "Geniar Gashi"),
                ProfileListElement(action: (){}, title: "Adresse e-mail", description: "geniar@gmail.com"),
                ProfileListElement(action: (){}, title: "Numéro de téléphone", description: "+33 (0)6 12 34 56 78"),
                ProfileListElement(action: (){}, title: "Mot de passe", description: "*******"),
                SizedBox(height: 40,),
                Center(child: ActionButton(text: "Déconnexion",action: (){_userConnection.logout();},),)
                
              ],
            ),
          ),
        )
      ],
    );
  }
}
