import 'package:flutter/material.dart';

import '../../theme/colors.dart';


class DropDownMenu<T> extends StatefulWidget {
  const DropDownMenu({
    this.items,
    this.onChange,
    this.onSaved,
    this.onTap,
    this.validator,
    this.hint,
    this.menuMaxHeight,
    this.icon,
    this.focusNode,
    Key? key,
    this.value,
  }) : super(key: key);

  final ValueChanged? onChange;
  final FormFieldSetter? onSaved;
  final FormFieldValidator? validator;
  final VoidCallback? onTap;
  final List<T>? items;
  final String? hint;
  final double? menuMaxHeight;
  final Widget? icon;
  final FocusNode? focusNode;
  final T? value;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState<T> extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      items: widget.items
          ?.map((e) => DropdownMenuItem<T>(
                value: e,
                child: Text(
                     e is String ? e : e.name, style: const TextStyle(fontSize: 14 , color: Colors.white)),
              ))
          .toList(),
      onChanged: widget.onChange,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      validator: widget.validator,
      menuMaxHeight: widget.menuMaxHeight,
      icon: widget.icon ?? const SizedBox.shrink(),
      focusNode: widget.focusNode,
      value: widget.value,
      dropdownColor: primaryColor,
      hint: widget.hint != null
          ? Text(
               widget.hint!,
          style: const TextStyle(fontSize: 14 , color: Colors.grey))
          : null,
      borderRadius: BorderRadius.circular(8),
      style: const TextStyle(fontSize: 14 , color: primaryColor),
      decoration: InputDecoration(
        fillColor: primaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 12),
        prefixIcon: Icon(Icons.keyboard_arrow_down_rounded,
            color: (widget.items?.isEmpty ?? true) ? Colors.white.withOpacity(0.3) : Colors.white),
      ),
    );
  }
}
