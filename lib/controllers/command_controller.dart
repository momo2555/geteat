import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    await updateTotalPrice();
  }

  Future<CommandModel> getCommandById(String id) async {
    final doc = await _fireStore.collection("commands").doc(id).get();
    return docToCommand(doc, false);
  }

  Future updateTotalPrice()  async {
    var cartRef = (await getCart()).reference;
    var subCommandsRef = cartRef.collection("subCommands");
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

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getCart() async {
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

  Future<CommandModel> docToCommand(DocumentSnapshot<Map<String, dynamic>> doc, bool withMealPictures) async {
    CommandModel command = CommandModel();
    command.commandId = doc.id;
    print(doc.data());
    command.commandDate = doc.get("commandDate");
    command.commandNumber = doc.get("commandNumber");
    command.commandPosition = doc.get("commandPosition");
    command.commandStatus = doc.get("commandStatus");
    command.commandTotalPrice = doc.get("commandTotalPrice");
    command.commandUserId = doc.get("commandUserId");
    try {
      command.commandPositionComment = doc.get("commandPositionComment");
    }catch(e) {
      doc.reference.update({"commandPositionComment" : ""});
      //command.commandPositionComment = doc.get("commandPositionComment");
    }
    
    //subCommands
    var docRef = doc.reference;
    var subCommandsRef = docRef.collection("subCommands");
    
    //update total price
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in (await subCommandsRef.get()).docs) {
      command.addSubCommand(docToSubCommand(doc));
      command.getLastAddedSubCommand().subCommandMeal = await _mealController.getMealUpdate(command.getLastAddedSubCommand().subCommandMeal, withMealPictures);
    }
    return command;
  }


  SubCommandModel docToSubCommand(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    var subCommandModel = SubCommandModel();
    subCommandModel.subCommandId = doc.id;
    subCommandModel.subCommandLength = doc.get("subCommandLength");
    //subCommandModel.subCommandOptions = doc.get("subCommandOptions");
    subCommandModel.subCommandTotalPrice = doc.get("subCommandTotalPrice");
    subCommandModel.subCommandMeal.mealId = doc.get("subCommandMealRef");
  
    return subCommandModel;
  }

  Future<List<SubCommandModel>> getSubCommands() async {
    List<SubCommandModel> subCommands = [];
    var cartRef = (await getCart()).reference;
    for (var doc in (await cartRef.collection("subCommands").get()).docs) {
      subCommands.add(docToSubCommand(doc));
    }
    return subCommands;
  }

  Stream<List<SubCommandModel>> getSubCommandsAsStream() async* {
    try {
      var cartRef = (await getCart()).reference;
      yield* cartRef.collection("subCommands").snapshots(includeMetadataChanges: true).map((event) => 
        event.docs.map((doc) => docToSubCommand(doc)).toList()
      );
    } catch(e) {
      Fluttertoast.showToast(msg: "Une erreur est survenue");
    }
    
  }

  Stream<List<CommandModel>> getAllUserCommands() async* {
    UserModel user = await _userConnection.UserConnected;
    var query =  _fireStore.collection("commands")
      .where("commandUserId", isEqualTo: user.uid)
      .orderBy("commandDate", descending: true);
    Stream<QuerySnapshot<Map<String, dynamic>>> result = query.snapshots(includeMetadataChanges: true);
    await for (final r in result) {
      List<CommandModel> commands = [];
      if (!r.metadata.isFromCache) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in r.docs){
          if(doc.get("commandStatus")!="temp") {
            commands.add(await docToCommand(doc, false));
          }
        }
        yield commands;
      }
    }
  }

  Stream<String> getCommandStatus (CommandModel command) async* {
    var query =  _fireStore.collection("commands")
      .doc(command.commandId);
    Stream<DocumentSnapshot<Map<String, dynamic>>> result = query.snapshots(includeMetadataChanges: true);
    await for (final r in result) {
      yield r.get("commandStatus") as String;
    }
  }

  Stream<num> getCartTotalPrice() async* {
    await updateTotalPrice();
    Stream<DocumentSnapshot<Map<String, dynamic>>> result = (await getCart()).reference.snapshots(includeMetadataChanges: true);
    await for (final r in result) {
      yield r.get("commandTotalPrice") as num;
    } 
  }

  Future<CommandModel> getCartAsCommandModel (bool withMealPictures) async {
    CommandModel cartCommand = CommandModel();
    QueryDocumentSnapshot<Map<String, dynamic>> cart = (await getCart());
    cartCommand = await docToCommand(cart, withMealPictures);

    return cartCommand;
  }

  Future<CommandModel> confirmCart() async {
    var cart = await getCart();
    var cartRef = cart.reference;
    cartRef.update({"commandStatus" : "wip"});
    cartRef.update({"commandDate": Timestamp.now()});
    var currentPos = Globals.userPosition.value;
    cartRef.update({"commandPosition" : GeoPoint(currentPos[0] as double, currentPos[1] as double)});
    cartRef.update({"commandPositionComment" :Globals.userPositonComment});
    //get command number
    int commandNum = (await _fireStore.collection("geteat").doc("config").get()).get("commandNumber");
    commandNum++;
    _fireStore.collection("geteat").doc("config").update({"commandNumber" : commandNum});
    cartRef.update({"commandNumber" : commandNum});
    return getCommandById(cartRef.id);
  }

  Future deleteCartSubCommand(SubCommandModel subCommand)async  {
    var cartRef = (await getCart()).reference;
    cartRef.collection("subCommands").doc(subCommand.subCommandId).delete();
    await updateTotalPrice();
  }
  
}