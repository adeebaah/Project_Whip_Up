import 'package:flutter/material.dart';
import 'package:whip_up/components/text_field_container.dart';
import 'package:whip_up/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key, required this.hintText,  this.icon= Icons.person, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText:hintText,
            border: InputBorder.none,
            ),
      ),
    );
  }
}



