import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simpleDropDown.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/mesl_subelement_model.dart';
import 'package:geteat/utils/meal_utils.dart';

class EditMealElement extends StatefulWidget {
  const EditMealElement({
    super.key,
    required this.element,
    required this.onChanged,
    required this.index,
  });
  final MealSubelementModel element;
  final Function(MealSubelementModel subel, int index) onChanged;
  final int index;

  @override
  State<EditMealElement> createState() => _EditMealElementState();
}

class _EditMealElementState extends State<EditMealElement> {
  MealSubelementModel _subel = MealSubelementModel("", 0);

  MealSubelementModel getData() {
    return _subel;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subel = widget.element;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5, right: 5),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                await _editSubElement();
                
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColorDark,
            ),
            Expanded(
              child: SimpleText(
                text: "${_subel.value}",
                color: 2,
                center: false,
              ),
            ),
            SimpleText(
              text: "${_subel.price.toStringAsFixed(2)}€",
              color: 2,
              center: false,
            ),
            IconButton(
              onPressed: () async {
                //await _editGroup(context);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }

  _editSubElement() async {
    MealSubelementModel? subel = await MealUtils.editSubElemen(context, _subel);
    if (subel != null) {
      widget.onChanged(subel, widget.index);
      setState(() {
        _subel = subel;

      });
    }
    
  }
}
