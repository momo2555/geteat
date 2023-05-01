import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geteat/components/restaurant_thumbnail.dart';
import 'package:geteat/controllers/cache_storage_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/models/user_model.dart';

class MealController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  //FirebaseStorage fireStorage = FirebaseStorage.instance;

  /*Future<UserProfileModel> get getUserProfile async {

    UserModel user = await userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference 
    DocumentReference profileDataRef =
        fireStore.collection('users').doc(userProfile.getUid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.setUserName = profileData.get('userName');
    userProfile.setUserDescription = profileData.get('userDescription');
    userProfile.setUserRate = profileData.get('userRate');
    userProfile.setUserProfileImage = profileData.get('userProfileImage');
    //get the link of the profile image
    
    Reference imgRef = fireStorage.ref('userImages/'+userProfile.getUserProfileImage);
    userProfile.setUserProfileImageURL = await imgRef.getDownloadURL();
    
    return userProfile;
  }*/
  void addMeal(MealModel newMeal) async {
    UserModel user = await userConnection.UserConnected;
    //newPost.setPostUserId = user.getUid;
    //create a new document for the new post (auto generated uid)
    DocumentReference ref = fireStore.collection('meals').doc();
    //uid of the post
    String uid = ref.id;
    //upload photos in the firestorage

    //TODO : upload the image
    /*int i = 0;
    List<String?> storageImageNames = [];
    for (String img in newRestaurant.getPostTempImagePaths) {
      File imgFile = File(img);
      String newPath = uid + '_'+i.toString();
      storageImageNames.add(newPath);
      Reference uploadRef = fireStorage.ref('postImages/' + uid + '/' + newPath); //in a unique folder
      uploadRef.putFile(imgFile);
      i++;
    }
    //add images storages names
    newPost.setPostStorageImageNames = storageImageNames;*/
    
    //add the new post in the doc
    ref.set(newMeal.toObject());
  }



  Future<MealModel> getMealById(String mealId, bool withPicture) async {
    MealModel meal = MealModel();
    DocumentReference mealRef =
        fireStore.collection('meals').doc(mealId);
    //get user data
    DocumentSnapshot mealSnapshot = (await mealRef.get());
    meal = docToMealModel(mealSnapshot);
    if(withPicture) {
      meal = await getImage(meal);
    }
      
    return meal;

  }
   Future<MealModel> getMeal(DocumentReference mealRef) async {
    MealModel meal = MealModel();
    //get user data
    DocumentSnapshot mealSnapshot = (await mealRef.get());
    meal = docToMealModel(mealSnapshot);
    
    
    return meal;

  }

  MealModel docToMealModel(DocumentSnapshot doc) {
    MealModel meal = MealModel();
    meal.mealName = doc.get('mealName');
    //post.setPostCurrentUserLike = postSnapshot.get('postCurrentUserLike');
    meal.mealDescription = doc.get('mealDescription');
    meal.mealImageName = doc.get('mealImageName');
    meal.mealStruct = doc.get('mealStruct');
    meal.mealId = doc.id;
    meal.mealPrice = doc.get('mealPrice');
    meal.mealRestaurantId = doc.get('mealRestaurantId');
    

    return meal;
  }

  Future<MealModel> getImage(MealModel meal) async {
    
       
      //download images
      //get temp
      String? imagesStorageName = meal.mealImageName;
      
      
      CacheStorageController cloudDownloader = CacheStorageController();
      File fileImg = await cloudDownloader.downloadFromCloud('meals/', (imagesStorageName as String), LocalSaveMode.userDocuments);
      
      meal.mealImage = fileImg;
    
      
    return meal;
    
   
  }
  Future<MealModel> getMealUpdate(MealModel meal, bool withPicture) async {
    meal = await getMealById(meal.mealId, withPicture);
    return meal;
  }
  /*Stream<List<Future<MeaelModel>>> converDocs(QueryDocumentSnapshot<Map<String, dynamic>> snapshots) async* {
    List<MealModel> posts = [];
    
  }*/  // on part sur une autre stratégie
  /*Stream<List<RestaurantModel>> getAllmeals()  {
    return fireStore.collection('meals').limit(20).snapshots().map((event) => event.docs.map((e) =>  docToMealModel(e)).toList() );
    
  }*/
}