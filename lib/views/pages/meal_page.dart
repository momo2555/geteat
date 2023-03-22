import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/meal_elements.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/themes/main_theme.dart';
import 'package:geteat/utils/global_utils.dart';

class MealPage extends StatefulWidget {

  const MealPage({
    Key? key,
    required this.meal,
  }) : super(key: key);
  final MealModel meal;
  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  bool _init = false;
  List<Widget> _elements = [];
  List<num> _elementPrices = [];
  List<String> _elementErrors = [];
  List<Map<String, dynamic>> _elementOptions = [];
  SubCommandModel _command = SubCommandModel();
  ///num _totalPrice = 0;
  DecorationImage? _decorationImage() {
    if(widget.meal.mealImage != null) {
      print(widget.meal.mealImage);
      return DecorationImage(
        image: FileImage(widget.meal.mealImage) ,
        fit: BoxFit.cover                       ,
        alignment: Alignment.center             ,
      );
    } else {
      return null;
    }
  }
  void _computePrice() {
    //_totalPrice = widget.meal.mealPrice;
    _command.subCommandTotalPrice = widget.meal.mealPrice;
    for(num p in _elementPrices) {
      _command.subCommandTotalPrice+=p;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    if(!_init){
      _command.subCommandTotalPrice = widget.meal.mealPrice;
      int elIndex = 0;
      for(Map<String, dynamic> element in widget.meal.mealStruct){
        _elementPrices.add(0);
        _elementErrors.add("");
        _elementOptions.add({});
        int id = _elements.length;
        _elements.add(MealElements(elementData: element, onChange: (options, price) {
          //print("total=${price}");
          _elementPrices[id] = price; 
          setState(() {
            _computePrice();
          });
        }),);
        elIndex++;
      }
      _init=true;
    }
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            if(_command.subCommandLength>1)_command.subCommandLength--;
                          });
                          
                        }),
                        icon: Icon(Icons.do_not_disturb_on_outlined)),
                    SimpleText(
                      text: '${_command.subCommandLength}',
                      color: 2,
                      thick: 7,
                      size: 15,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _command.subCommandLength++;
                          });
                        }, icon: Icon(Icons.add_circle_outline))
                  ],
                ),
                ActionButton(
                  
                  text: 'Ajouter ${_command.subCommandLength} au panier - ${(_command.subCommandTotalPrice * _command.subCommandLength).toStringAsFixed(2)}€',
                  backColor: Theme.of(context).backgroundColor,
                  filled: true,
                  expanded: true,
                  color: Theme.of(context).primaryColorLight,
                  action: () {
                     Globals.goBack(context);
                     Globals.goToKart.value = true;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.meal.mealId,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        image: _decorationImage(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorLight),
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: widget.meal.mealName.toUpperCase(),
                        size: 20,
                        color: 2,
                        thick: 6,
                      ),
                      SimpleText(
                        text: widget.meal.mealPrice.toString() + "€",
                        size: 16,
                        color: 2,
                        thick: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SimpleText(
                          text:
                              widget.meal.mealDescription,
                          color: 2,
                          center: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
             Column(
              children: _elements,
             )
              
            ],
          ),
        ),
      ),
    );
  }
}
