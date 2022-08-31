import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message, required this.isAuthor})
      : super(key: key);

  final String message;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isAuthor ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isAuthor
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isAuthor
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isAuthor
                      ? const Radius.circular(0)
                      : const Radius.circular(12))),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color: isAuthor
                    ? Colors.black
                    : Theme.of(context).textTheme.headline1?.color),
          ),
        ),
      ],
    );
  }
}
