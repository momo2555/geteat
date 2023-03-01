import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class MealElements extends StatefulWidget {
  const MealElements({
    Key? key,
    required this.elementData,
    required this.onChange,
  }) : super(key: key);
  final Map<String, dynamic> elementData;
  final Function(List<dynamic>, num) onChange;
  @override
  State<MealElements> createState() => _MealElementsState();
}

class _MealElementsState extends State<MealElements> {
  int _reload = 0;
  String _title = "";
  String _type = "";
  List<Widget> _elementList = [];
  late int _radioValues = 3;
  List<bool> _checkValues = [];
  late List<int> _multiValues = [];
  List<num> _prices = [];
  String _textValue = "";
  List<dynamic> _options = [];
  num _totalPrice = 0.0;
  
  void computeTotalPriceCheck() {
    _totalPrice = 0.0;
    int i = 0;
    for(num price in _prices) {
      if (_checkValues[i]) {
        _totalPrice+=price;
      }
    }
  }
  void computeTotalPriceMulti() {
    _totalPrice = 0.0;
    int i = 0;
    for(num price in _prices) {
      
        _totalPrice+=price*_multiValues[i];
      
    }
  }
  Widget _multiElement(value, id, price) {
    String strPrice = "";
    if (price>0) strPrice = "(${price.toStringAsFixed(2)}€)";



    List<Widget> rightEl = [];
    if (_multiValues[id]>0) rightEl.add(
      IconButton(
            icon: Icon(Icons.do_not_disturb_on),
            onPressed: () {
              setState(() {
                _multiValues[id]=_multiValues[id]-1;
                computeTotalPriceMulti();
                widget.onChange(_options, _totalPrice);
              });
            },
          ),
    );
    rightEl.add(SimpleText(text: _multiValues[id].toString(), color: 1,));
    rightEl.add(IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                _multiValues[id]=_multiValues[id]+1;
                computeTotalPriceMulti();
                widget.onChange(_options, _totalPrice);
              });
            },
          ));
    
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleText(
            text: value + " " + strPrice,
            color: 2,
          ),
          Row(
            children: rightEl,
          )
          
        ],
      ),
    );
  }



  Widget _radioElement(value, id, price) {
    String strPrice = "";
    if (price>0) strPrice = "(${price.toStringAsFixed(2)}€)";
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SimpleText(
          text: value + " " + strPrice,
          color: 2,
        ),
        Radio<int>(
              value: id,
              groupValue: _radioValues,
              onChanged: (int? val) {
                
                setState(
                  () {
                    _radioValues = val!;
                    _totalPrice = _prices[id];
                    widget.onChange(_options, _totalPrice);
                  },
                );
              },
            ),
          
      ],
    ));
  }

  Widget _checkElement(value, id, price) {
    String strPrice = "";
    if (price>0) strPrice = "(${price.toStringAsFixed(2)}€)";

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleText(
            text: value + " " + strPrice,
            color: 2,
          ),
          Checkbox(
            value: _checkValues[id],
            onChanged: (val) {
              setState(() {
                _checkValues[id] = val!;
                computeTotalPriceCheck();
                widget.onChange(_options, _totalPrice);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _titleElement(title) {
    return Row(
      children: [
        SimpleText(
          text: title,
          thick: 9,
          size: 14,
          color: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
          padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
          child: Builder(builder: ((context) {
            _elementList = [];
            if (widget.elementData.containsKey("type")) {
              _type = widget.elementData["type"];
            }
            if (widget.elementData.containsKey("title")) {
              _title = widget.elementData["title"];
              _elementList.add(_titleElement(_title));
            }
            if (widget.elementData.containsKey("elements")) {
              int index = 0;
              _elementList = [];
              _prices = [];

              for (Map<String, dynamic> el in widget.elementData["elements"]) {
                
                if (_type == "checklist") {
                  if(_reload==0)_checkValues.add(false);
                  _prices.add(el["price"]);
                  _elementList.add(_checkElement(el["value"], index, el["price"]));
                  
                } else if (_type == "radiolist") {
                  // _radioValues = 0;
                  _prices.add(el["price"]);
                  _elementList.add(_radioElement(el["value"], index, el["price"]));
                  
                } else if (_type == "multilist") {
                  if(_reload==0)_multiValues.add(0);
                  _prices.add(el["price"]);
                  _elementList.add(_multiElement(el["value"], index, el["price"]));
                  
                }
                index++;
              }
              _reload++;
              return Column(children: _elementList);
            }else {
              return Container();
            }
          }))

          ///,

          ),
    );
  }
}
