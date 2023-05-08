import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geteat/components/restaurant_thumbnail.dart';
import 'package:geteat/controllers/cache_storage_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/models/user_model.dart';

class MealController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  CacheStorageController _cloudDownloader = CacheStorageController();
  //FirebaseStorage fireStorage = FirebaseStorage.instance;

  /*Future<UserProfileModel> get getUserProfile async {

    UserModel user = await userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference 
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.getUid);
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
    DocumentReference ref = _fireStore.collection('meals').doc();
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
        _fireStore.collection('meals').doc(mealId);
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
    meal.mealCoverImageName = doc.get('mealCoverImageName');
    meal.mealStruct = doc.get('mealStruct');
    meal.mealId = doc.id;
    meal.mealPrice = doc.get('mealPrice');
    meal.mealRestaurantId = doc.get('mealRestaurantId');
    

    return meal;
  }

  Future<MealModel> getImage(MealModel meal) async {
    
       
      //download images
      //get temp
      String? mealImageStorageName = meal.mealImageName;
      String? mealCoverImageStorageName = meal.mealCoverImageName;
      
      
      
      File fileImg = await _cloudDownloader.downloadFromCloud('meals/', (mealImageStorageName as String), LocalSaveMode.userDocuments);
      File fileCoverImg = await _cloudDownloader.downloadFromCloud('meals/', (mealCoverImageStorageName as String), LocalSaveMode.userDocuments);
      
      meal.mealImage = fileImg;
      meal.mealCoverImage = fileCoverImg;
    
      
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
    return _fireStore.collection('meals').limit(20).snapshots().map((event) => event.docs.map((e) =>  docToMealModel(e)).toList() );
    
  }*/
  Stream<List<MealModel>> getMealsOfRestaurant(RestaurantModel restaurant) async* {
    yield* _fireStore.collection("meals").where("mealRestaurantId", isEqualTo: restaurant.restaurantId).snapshots(includeMetadataChanges: true).map((event) => event.docs.map((e) => docToMealModel(e)).toList());
  }
  void updateMealImageNames(MealModel meal) {
    
    if(meal.mealImage!=null) {
      var ext = p.extension((meal.mealImage as File).path);
      meal.mealImageName = "${meal.mealId}$ext";
    }
    if(meal.mealCoverImage!=null) {
      var ext = p.extension((meal.mealCoverImage as File).path);
      meal.mealCoverImageName = "${meal.mealId}_cover$ext";
    }
  }
  Future<void> editMeal(MealModel meal) async {
    //upload image
    updateMealImageNames(meal);
    await _cloudDownloader.uploadImage(meal.mealImage, "meals/${meal.mealImageName}");
    await _cloudDownloader.uploadImage(meal.mealCoverImage, "meals/${meal.mealCoverImageName}");
    //Save data
     _fireStore.collection("meals").doc(meal.mealId).set(meal.toObject());

  }
  Future<void> createMeal(MealModel meal) async {
    var ref = _fireStore.collection("meals").doc();
    meal.mealId = ref.id;
    editMeal(meal);

  }


  static DecorationImage? decorationImage(MealModel meal) {
    if (meal.mealImage != null) {
      return DecorationImage(
        image: FileImage(meal.mealImage),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }
   static DecorationImage? decorationCoverImage(MealModel meal) {
    if (meal.mealCoverImage != null) {
      return DecorationImage(
        image: FileImage(meal.mealCoverImage),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }
}