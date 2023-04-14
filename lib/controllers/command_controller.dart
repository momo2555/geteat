import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/models/user_model.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommandController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection _userConnection = UserConnection();
  MealController _mealController = MealController();

  Future addToUserCart(SubCommandModel subCommand) async {
    //get the user cart in the data base
    var cartRef = (await getCart()).reference;
    var subCommandsRef = cartRef.collection("subCommands");
    subCommandsRef.add(subCommand.toObject());
    //update total price
    num newPrice = 0.0;
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in (await subCommandsRef.get()).docs) {
      newPrice+=doc.get("subCommandTotalPrice");
    }
    cartRef.update({"commandTotalPrice" : newPrice});
   
  }
  Future createNewCart() async {
   UserModel user = await _userConnection.UserConnected;
    //creat new command
    CommandModel cart = CommandModel();
    cart.commandUserId = user.uid;
    cart.commandStatus = "temp";

   var ref =  _fireStore.collection("commands").doc();
   ref.set(cart.toObject());
    
  }
  Future<QueryDocumentSnapshot> getCart() async {
     UserModel user = await _userConnection.UserConnected;
    
    var query =  _fireStore.collection("commands")
      .where("commandUserId", isEqualTo: user.uid)
      .where("commandStatus", isEqualTo: "temp");

    List<dynamic> docs = (await query.limit(5).get()).docs;
    if(docs.length < 1) {
      createNewCart();
    }
    docs = (await query.limit(5).get()).docs;
   
    return docs[0];
   
  }
  SubCommandModel docToSubCommand(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    var subCommandModel = SubCommandModel();
    subCommandModel.subCommandLength = doc.get("subCommandLength");
    //subCommandModel.subCommandOptions = doc.get("subCommandOptions");
    subCommandModel.subCommandTotalPrice = doc.get("subCommandTotalPrice");
    subCommandModel.subCommandMeal.mealId = doc.get("subCommandMealRef");
    return subCommandModel;
  }
  Stream<List<SubCommandModel>> getSubCommands() async* {
    var cartRef = (await getCart()).reference;
    cartRef.collection("subCommands").snapshots().listen((event) {
      print(event.docs.map((e) => e.data()));
    });
    yield* cartRef.collection("subCommands").snapshots().map((event) => 
      event.docs.map((doc) => docToSubCommand(doc)).toList()
    );
    
  }
  Future<num> getCartTotalPrice() async {
    num price = (await getCart()).get("commandTotalPrice");
    return price;
  }
  Future<CommandModel> getCartAsCommandModel (bool withMealPictures) async {
    CommandModel cartCommand = CommandModel();
    var cart = (await getCart());
    cartCommand.commandId = cart.id;
    cartCommand.commandDate = cart.get("commandDate");
    cartCommand.commandNumber = cart.get("commandNumber");
    cartCommand.commandPosition = cart.get("commandPosition");
    cartCommand.commandStatus = cart.get("commandStatus");
    cartCommand.commandTotalPrice = cart.get("commandTotalPrice");
    cartCommand.commandUserId = cart.get("commandUserId");
    //subCommands
    var cartRef = cart.reference;
    var subCommandsRef = cartRef.collection("subCommands");
    
    //update total price
    num newPrice = 0.0;
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in (await subCommandsRef.get()).docs) {
      cartCommand.addSubCommand(docToSubCommand(doc));
      cartCommand.getLastAddedSubCommand().subCommandMeal = await _mealController.getMealUpdate(cartCommand.getLastAddedSubCommand().subCommandMeal, withMealPictures);
    }
    return cartCommand;
    

  }

  Future confirmCart() async {
    var cartRef = (await getCart()).reference;
    cartRef.update({"commandStatus" : "wip"});
    cartRef.update({"commandDate": Timestamp.now()});
    var currentPos = Globals.userPosition.value;
    cartRef.update({"commandPosition" : GeoPoint(currentPos[0] as double, currentPos[1] as double)});
    
  }
}