import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geteat/components/restaurant_thumbnail.dart';
import 'package:geteat/controllers/cache_storage_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/models/user_model.dart';

class RestaurantController {
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
  void addRestaurant(RestaurantModel newRestaurant) async {
    UserModel user = await userConnection.UserConnected;
    //newPost.setPostUserId = user.getUid;
    //create a new document for the new post (auto generated uid)
    DocumentReference ref = fireStore.collection('restaurants').doc();
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
    ref.set(newRestaurant.toObject());
  }



  Future<RestaurantModel> getRestaurantById(String uid) async {
    RestaurantModel restaurant = RestaurantModel();
    DocumentReference restaurantRef =
        fireStore.collection('restaurants').doc(uid);
    //get user data
    DocumentSnapshot restaurantSnapshot = (await restaurantRef.get());
    restaurant = docToRestaurantModel(restaurantSnapshot);
    
    
    return restaurant;

  }

  RestaurantModel docToRestaurantModel(DocumentSnapshot doc) {
    RestaurantModel restaurant = RestaurantModel();
    restaurant.restaurantName = doc.get('restaurantName');
    //post.setPostCurrentUserLike = postSnapshot.get('postCurrentUserLike');
    restaurant.restaurantDescription = doc.get('restaurantDescription');
    restaurant.restaurantId = doc.id;
    restaurant.restaurantHours = doc.get('restaurantHours');
    getImage(restaurant).then((value) => restaurant = value);
    
    return restaurant;
  }

  Future<RestaurantModel> getImage(RestaurantModel restaurant) async {
    try {
       List<File> imageFiles = [];
    //download images
    //get temp folder
    String? imagesStorageName = restaurant.restaurantImageName;
    
    
    CacheStorageController cloudDownloader = CacheStorageController();
    File fileImg = await cloudDownloader.downloadFromCloud('restaurants/', (imagesStorageName as String), LocalSaveMode.userDocuments);
    imageFiles.add(fileImg);
    restaurant.restaurantImage = imageFiles;
    
      
    return restaurant;
    } catch (e) {
      return restaurant;
    }
   
  }

  /*Stream<List<Future<RestaurantModel>>> converDocs(QueryDocumentSnapshot<Map<String, dynamic>> snapshots) async* {
    List<RestaurantModel> posts = [];
    
  }*/  // on part sur une autre stratégie
  Stream<List<RestaurantModel>> getAllRestaurants()  {
    return fireStore.collection('restaurants').limit(20).snapshots().map((event) => event.docs.map((e) =>  docToRestaurantModel(e)).toList() );
    
  }
}