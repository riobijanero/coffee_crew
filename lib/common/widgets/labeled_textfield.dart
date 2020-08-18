import 'package:flutter/material.dart';
import 'package:coffee_crew/common/constants/constants.dart';

class LabeledTextfield extends StatelessWidget {
  const LabeledTextfield(
      {Key key,
      @required this.validator,
      @required this.onChanged,
      this.labeltext,
      this.hintText,
      this.icon,
      this.texteditController,
      this.obscureText = false,
      this.trailingIcon,
      this.fillColor})
      : super(key: key);

  final String Function(String) validator;
  final void Function(String value) onChanged;
  final String labeltext;
  final String hintText;
  final Icon icon;
  final IconButton trailingIcon;
  final TextEditingController texteditController;
  final bool obscureText;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labeltext,
          style: textFormFieldLabelStyle,
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: obscureText,
          controller: texteditController,
          cursorColor: textFormFieldFontStyle.color,
          style: textFormFieldFontStyle,
          decoration: textInputDecoration.copyWith(
            hintText: hintText,
            prefixIcon: icon,
            suffixIcon: (trailingIcon != null) ? trailingIcon : null,
            fillColor: fillColor != null ? fillColor : null,
          ),
          validator: (value) => validator(value),
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
