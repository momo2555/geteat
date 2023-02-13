import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class MealElements extends StatefulWidget {
  const MealElements({
    Key? key,
    required this.elementData,
  }) : super(key: key);
  final Map<String, dynamic> elementData;
  @override
  State<MealElements> createState() => _MealElementsState();
}

class _MealElementsState extends State<MealElements> {
  
  String _title = "";
  String _type = "";
  List<Widget> _elementList = [];
  int _radioValues = 3;
  List<bool> _checkValues =  [];
  List<int> _multiValues = [];
  String _textValue = "";

  Widget _multiElement(value, id) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleText(
            text: value,
            color: 2,
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _radioElement(value, id) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleText(
            text: value,
            color: 2,
          ),
          StatefulBuilder(builder: (context, setState) {
            return Radio<int>(
            value: id,
            groupValue: _radioValues,
            onChanged: (int? val){
              setState(() {
                _radioValues = val!;
              });
              this.setState(() {
                _radioValues = val!;
                },
              );
            },
          );
          },)
          
            
              
           ],
          )
    );
  }

  Widget _checkElement(value, id) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimpleText(
            text: value,
            color: 2,
          ),
          StatefulBuilder(builder: (context, setState) {
            return Checkbox(
            value: _checkValues[id],
            onChanged: (val) {
              setState(() {
                _checkValues[id] = val!;
                print(_checkValues[id]);
                print(val);
              });
              
            },
          );
          },)
          
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
  void initState() {
    // TODO: implement initState
    
      if (widget.elementData.containsKey("type")) {
        _type = widget.elementData["type"];
      }
      if (widget.elementData.containsKey("title")) {
        _title = widget.elementData["title"];
        _elementList.add(_titleElement(_title));
      }
      if (widget.elementData.containsKey("elements")) {
        int index = 0;
        for (Map<String, dynamic> el in widget.elementData["elements"]) {
          if (_type == "checklist") {
            _checkValues.add(false);
            int id = _checkValues.length - 1;
            _elementList.add(_checkElement(el["value"], id));
          } else if (_type == "radiolist") {
           // _radioValues = 0;
            _elementList.add(_radioElement(el["value"], index));
          } else if (_type == "multilist") {
            _multiValues.add(0);
            int id = _multiValues.length - 1;
            _elementList.add(_multiElement(el["value"], id));
          }
          index++;
        }
      }
    setState(() {
      _elementList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
        padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
        child: Column(children:_elementList),
      ),
    );
  }
}
