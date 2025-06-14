import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../data/models/ChatMessage.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15 * 0.75,
        vertical: 15 / 2,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(message!.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }
}
