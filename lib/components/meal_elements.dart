import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:collection/collection.dart';
import 'package:geteat/lang/lang.dart';

class MealElements extends StatefulWidget {
  const MealElements({
    Key? key,
    required this.elementData,
    required this.onChange,
    this.onError,
  }) : super(key: key);
  final Map<String, dynamic> elementData;
  final Function(Map<String, dynamic>, num) onChange;
  final Function(String)? onError;
  @override
  State<MealElements> createState() => _MealElementsState();
}

class _MealElementsState extends State<MealElements> {
  int _reload = 0;
  String _title = "";
  String _type = "";
  List<Widget> _elementList = [];
  List<String> _elementNames = [];
  late int _radioValues = -1;
  List<bool> _checkValues = [];
  late List<int> _multiValues = [];
  List<num> _prices = [];
  String _textValue = "";
  Map<String, dynamic> _options = {
    "value" : "",
    "contents" : [],
  };
  num _totalPrice = 0.0;
  num _max = 0;
  num _min = 0;
  String _error = "";

  void _computeTotalPriceCheck() {
    _totalPrice = 0.0;
    int i = 0;
    for (num price in _prices) {
      if (_checkValues[i]) {
        _totalPrice += price;
      }
      i++;
    }
  }
  void _updateOptions() {
    _options["value"] = _title;
    _options["contents"] = [];
    if (_type == "multilist") {
       int i = 0;
      for(int val in _multiValues) {
        if (val > 0)  {
          _options["contents"].add("${_elementNames[i]} x$val");
        }
        i++;
      }
    }else if (_type == "checklist") {
      int i = 0;
      for(bool val in _checkValues) {
        if (val)  {
          _options["contents"].add(_elementNames[i]);
        }
        i++;
      }
    }else if (_type == "radiolist") {
      if (_radioValues > -1) {
        _options["contents"].add(_elementNames[_radioValues]);
      }
    }else if (_type == "text") {
      _options["contents"].add(_textValue);
    }
    
  }
  int _totalChecked() {
    int total = 0;
    for (bool checked in _checkValues) {
      if (checked) total++;
    }
    return total;
  }

  void _computeTotalPriceMulti() {
    _totalPrice = 0.0;
    int i = 0;
    for (num price in _prices) {
      _totalPrice += price * _multiValues[i];
      i++;
    }
  }

  Widget _multiElement(value, id, price) {
    String strPrice = "";
    if (price > 0) strPrice = "(${price.toStringAsFixed(2)}€)";

    List<Widget> rightEl = [];
    if (_multiValues[id] > 0){
      rightEl.add(
        IconButton(
          icon: Icon(Icons.do_not_disturb_on),
          onPressed: () {
            
            setState(() {
              _multiValues[id] = _multiValues[id] - 1;
              _computeTotalPriceMulti();
              _updateOptions();
              widget.onChange(_options, _totalPrice);
            });
          },
        ),
      );}
    rightEl.add(SimpleText(
      text: _multiValues[id].toString(),
      color: 1,
    ));
    rightEl.add(IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: () {
        setState(() {
          _multiValues[id] = (_multiValues[id] + 1);
          if (_max > 0 && _multiValues[id] > _max) {
            _multiValues[id] = _max.round();
          }
          _computeTotalPriceMulti();
          _updateOptions();
          widget.onChange(_options, _totalPrice);
        });
      },
    ));

    return Row(
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
      );
  }

  Widget _radioElement(value, id, price) {
    String strPrice = "";
    if (price > 0) strPrice = "(${price.toStringAsFixed(2)}€)";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SimpleText(
          text: value + " " + strPrice,
          color: 2,
        ),
        Radio<int>(
          focusColor: Theme.of(context).backgroundColor,
          fillColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
          value: id,
          groupValue: _radioValues,
          onChanged: (int? val) {
            
            setState(
              () {
                _radioValues = val!;
                _totalPrice = _prices[id];
                _updateOptions();
                widget.onChange(_options, _totalPrice);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _checkElement(value, id, price) {
    String strPrice = "";
    if (price > 0) strPrice = "(${price.toStringAsFixed(2)}€)";

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
            fillColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
            onChanged: (val) {
              
              setState(() {
                if (!(_max > 0 && _totalChecked() >= _max && val!)) {
                  _checkValues[id] = val!;
                }
                _computeTotalPriceCheck();
                _updateOptions();
                widget.onChange(_options, _totalPrice);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _titleElement(title) {
    Widget indication = Container();
    if (_type == "radiolist") {
      indication = SimpleText(
        text: Lang.l("Obligatoire"),
        color: 2,
        size: 12,
      );
    } else if (_type == "checklist") {
      String topText = "";
      if (_min > 0) {
        topText += "min $_min, ";
      }
      if (_max > 0) {
        topText += "max $_max ";
      }
      if (topText != "") {
        indication = SimpleText(
          text: topText,
          color: 2,
          size: 12,
        );
      }
    } else if (_type == "multilist") {
      String topText = "";
      if (_max > 0) {
        topText += "max ${_max}";
      }
      if (topText != "") {
        indication = SimpleText(
          text: topText,
          color: 2,
          size: 12,
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SimpleText(
          text: title,
          thick: 9,
          size: 14,
          color: 2,
        ),
        indication
      ],
    );
  }

  Widget _errorElement() {
    if (_type == "radiolist" && _radioValues == -1) {
      _error = Lang.l("Veuillez sélectionner une option");
    } else if (_type == "checklist") {
      List<int> checked = _checkValues.map((e) {
        return e ? 1 : 0;
      }).toList();
      if (_min > 0 && checked.sum < _min) {
        print(checked.sum);
        _error = Lang.l("Il faut choisir au minimum \$0 option", [_min]);
      } else {
        _error = "";
      }
    } else {
      _error = "";
    }
    if (widget.onError != null) {
      widget.onError!(_error);
    }
    if (_error != "") {
      return SimpleText(
        text: _error,
        color: 4,
        thick: 8,
      );
    } else {
      return Container();
    }
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
            _elementNames = [];
            _prices = [];
            if (widget.elementData.containsKey("min")) {
              _min = widget.elementData["min"];
            }
            if (widget.elementData.containsKey("max")) {
              _max = widget.elementData["max"];
            }
            if (widget.elementData.containsKey("type")) {
              _type = widget.elementData["type"];
            }
            if (widget.elementData.containsKey("title")) {
              _title = widget.elementData["title"];
              _elementList.add(_titleElement(_title));
            }
            if (_type == "text") {
              _elementList.add(Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SimpleInput(
                  style: "light",
                  maxLines: 3,
                  type: "multiline",
                  onChange: (val) {
                    _textValue = val;
                    _updateOptions();
                    widget.onChange(_options, 0);
                  },
                ),
              ));
              return Column(children: _elementList);
            }
            if (widget.elementData.containsKey("elements")) {
              int index = 0;
              for (Map<String, dynamic> el in widget.elementData["elements"]) {
                if (_type == "checklist") {
                  if (_reload == 0) _checkValues.add(false);
                  _prices.add(el["price"]);
                  _elementList
                      .add(_checkElement(el["value"], index, el["price"]));
                  _elementNames.add(el["value"]);
                } else if (_type == "radiolist") {
                  // _radioValues = 0;
                  _prices.add(el["price"]);
                  _elementList
                      .add(_radioElement(el["value"], index, el["price"]));
                  _elementNames.add(el["value"]);
                } else if (_type == "multilist") {
                  if (_reload == 0) _multiValues.add(0);
                  _prices.add(el["price"]);
                  _elementList
                      .add(_multiElement(el["value"], index, el["price"]));
                  _elementNames.add(el["value"]);
                }
                index++;
              }
              _elementList.add(_errorElement());
              _reload++;
              return Column(children: _elementList);
            } else {
              return Container();
            }
          }))

          ///,

          ),
    );
  }
}
