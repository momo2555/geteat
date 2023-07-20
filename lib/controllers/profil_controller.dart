import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/user_model.dart';
import 'package:geteat/models/user_profile_model.dart';


class ProfileController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection _userConnection = UserConnection();
  FirebaseStorage _fireStorage = FirebaseStorage.instance;

  Future<UserProfileModel> get getUserProfile async {

    UserModel user = await _userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference 
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.userName = profileData.get('userName');
    //userProfile.userDescription= profileData.get('userDescription');
    userProfile.userRate = profileData.get('userRate');
    userProfile.phone = profileData.get('userPhone');
    userProfile.userProfileImage = profileData.get('userProfileImage');
    userProfile.userAddress      = profileData.get('userAddress');
    userProfile.userCity         = profileData.get('userCity');
    userProfile.userType         = profileData.get('userType');
    //get the link of the profile image
    /*Reference imgRef = fireStorage.ref('userImages/'+(userProfile.userProfileImage??''));
    userProfile.userProfileImageURL = await imgRef.getDownloadURL();*/
    
    return userProfile;
  }

  Future<UserProfileModel> getUserProfileById(String userId) async {
    //get the user Id
    UserModel user = UserModel('', '', '', userId);
    
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    try {
       DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.userName = profileData.get('userName');
    //userProfile.userDescription = profileData.get('userDescription');
    userProfile.userRate         = profileData.get('userRate');
    userProfile.userProfileImage = profileData.get('userProfileImage');
    userProfile.phone            = profileData.get('userPhone');
    userProfile.email            = profileData.get('userEmail');
    userProfile.userAddress      = profileData.get('userAddress');
    userProfile.userCity         = profileData.get('userCity');
    userProfile.userType         = profileData.get('userType');

    //get the link of the profile image
    
    //Reference imgRef = fireStorage.ref('userImages/'+(userProfile.userProfileImage??''));
    //userProfile.userProfileImageURL = await imgRef.getDownloadURL(); // TODO erreor dowload time exceeded
    
    return userProfile;
    } catch (e) {
      print("unable to find the user");
      return userProfile;

    }
    //get the user reference
  }

  Future<UserProfileModel> createProfileBUserModel(UserModel user) async {
     UserProfileModel userProfile = UserProfileModel.byModel(user);
     //create the new doc
     DocumentReference profileDataRef =
        _fireStore.collection('users').doc(user.uid);
      profileDataRef.set(userProfile.toObject());
      //create reference to the mail address
      DocumentReference mailPhoneRef = _fireStore.collection('phonemail').doc(user.phone);
      Map<String, String> mailData = {"email": user.email};
      mailPhoneRef.set(mailData);
      return userProfile;
  }
  Future<UserProfileModel> createProfileByProfileModel(UserProfileModel userProfile) async {
     
     //create the new doc
      DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid); //must not be null '' (uid)
      profileDataRef.set(userProfile.toObject());
      //create reference to the mail address
      DocumentReference mailPhoneRef = _fireStore.collection('phonemail').doc(userProfile.phone);
      Map<String, String> mailData = {"email": userProfile.email};
      mailPhoneRef.set(mailData);
      return userProfile;
  }

  Future<void> saveUserProfile(UserProfileModel userProfile) async {
    //upload image
    if(userProfile.userProfileImageFile!=null) {
      Reference uploadRef = _fireStorage.ref('userImages/' + userProfile.uid); //in a unique folder
        uploadRef.putFile(userProfile.userProfileImageFile);
      userProfile.userProfileImageURL = userProfile.uid;
    }
    //enregistrement dans la data base
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
      profileDataRef.set(userProfile.toObject());
  }

  Future<void> changePassword(String newPassword) async  {
    User? currentUser = _userConnection.getUser();
    if(currentUser!=null) {
      currentUser.updatePassword(newPassword);
    }
  }

  Future<void> changeEmail() async {

  }
  Future<void> changeName() async {

  }


  
}