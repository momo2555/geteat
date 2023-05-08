import 'package:geteat/models/command_model.dart';

class CommandUtils  {
  static String commandNumber(CommandModel command) {
    if(command.commandNumber < 99999) {
      return "#${(command.commandNumber/100000).toStringAsFixed(5).split(".")[1]}";
    }else {
      return "#${command.commandNumber}";
    }
    
  }
}