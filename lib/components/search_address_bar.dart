import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/views/pages/location_tool.dart';

class SearchAddressBar extends StatefulWidget {
  const SearchAddressBar({
    Key? key,
    required this.static,
    this.onChanged,
  }) : super(key: key);
  final bool static;
  final Function(List<dynamic>?)? onChanged;
  @override
  State<SearchAddressBar> createState() => _SearchAddressBarState();
}

class _SearchAddressBarState extends State<SearchAddressBar> {
  LocationTools _locationTools = LocationTools();
  List<dynamic>? _predictions = [];
  InputDecoration _decoration() {
    return InputDecoration(
     
      hintText: "Rechercher une adresse",

      floatingLabelStyle: TextStyle(
        color: Theme.of(context).primaryColorLight,
      ),

      prefixStyle: TextStyle(
          color: Theme.of(context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 0,
      )),
      border: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 0,
      )),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.red,
        width: 0,
      )),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 0,
      )),
      //fillColor: Theme.of(context).backgroundColor,
      //filled: true,
      contentPadding: const EdgeInsets.all(10),
      focusColor: Theme.of(context).primaryColorLight,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  Widget _searchDynamic() {
    return TextFormField(
      //textAlign: TextAlign.center,
      autofocus: true,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _decoration(),
      onChanged: (val) async {

        _predictions = await _locationTools.getPredictions(val);
        if(widget.onChanged != null){
          widget.onChanged!(_predictions);
        }
         
      },
      
      onSaved: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.static) {
          Navigator.pushNamed(context, "/search_address_result");
        }
      },
      child: Container(
        width: double.infinity,
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: widget.static
                ? Border.all(color: Colors.grey, width: 2)
                : Border.all(color: Theme.of(context).primaryColor, width: 1)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
              child: Hero(
                tag: "search_bar_icon",
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColorLight,
                  size: 30,
                ),
              ),
            ),
            widget.static
                ? const SimpleText(
                    text: "Rechercher une adresse",
                    color: 3,
                  )
                : Expanded(
                    child: _searchDynamic(),
                  ),
          ],
        ),
      ),
    );
  }
}
