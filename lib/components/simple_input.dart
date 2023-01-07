import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleInput extends StatefulWidget {
  const SimpleInput(
      {Key? key,
      this.placeholder,
      this.type,
      this.icon,
      this.textInputAction,
      this.focusNode,
      this.nextNode,
      this.previousNode,
      this.onChange,
      this.validator,
      this.value = "",
      this.minLines,
      this.maxLines,
      this.controller})
      : super(key: key);
  final String? placeholder;
  final String? type;
  final Icon? icon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final Function(dynamic value)? validator;
  final Function(String value)? onChange;
  final String value;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  @override
  State<SimpleInput> createState() => _SimpleInputState();
}

class _SimpleInputState extends State<SimpleInput> {
  String value = '';
  bool _obscureText = true;
  get getValue {
    return value;
  }

  InputDecoration _inputdecoration() {
    return InputDecoration(
      prefixIcon: widget.icon,
      hintText: widget.placeholder ?? '',
      prefixText: widget.type == "phone" ? "+33" : "",
      prefixStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
            width: 1.0,
            style: BorderStyle.solid),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
            width: 1,
            style: BorderStyle.solid),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
            style: BorderStyle.solid),
      ),
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      contentPadding: const EdgeInsets.all(17),
      suffixIcon: widget.type == 'password'
          ? InkWell(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: _obscureText
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.visibility_off_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
            )
          : null,
      focusColor: Theme.of(context).primaryColorLight,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  //TODO implement password type
  Widget _simpleInput() {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _inputdecoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
    );
  }

  Widget _phoneInput() {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _inputdecoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        //_phoneNumberFormatter, TODO : Add phone number formater
      ],
    );
  }

  Widget _multilineInput() {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _inputdecoration(),
      maxLines: widget.maxLines ?? 5,
      minLines: widget.minLines ?? 3,
      keyboardType: TextInputType.multiline,
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      //initialValue: widget.value,
    );
  }

  Widget _numericInput() {
    return TextFormField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _inputdecoration(),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _inputdecoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      obscureText: _obscureText,
      initialValue: widget.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'multiline') {
      return _multilineInput();
    } else if (widget.type == 'numeric') {
      return _numericInput();
    } else if (widget.type == "password") {
      return _passwordInput();
    } else if (widget.type == 'phone') {
      return _phoneInput();
    } else {
      return _simpleInput();
    }
  }
}
