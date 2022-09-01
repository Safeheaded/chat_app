import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.isAuthor,
      required this.username,
      required this.userImage})
      : super(key: key);

  final String message;
  final bool isAuthor;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
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
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                  crossAxisAlignment: isAuthor
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAuthor ? 'Me' : username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isAuthor
                              ? Colors.black
                              : Theme.of(context).textTheme.headline1?.color),
                    ),
                    Text(
                      message,
                      textAlign: isAuthor ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                          color: isAuthor
                              ? Colors.black
                              : Theme.of(context).textTheme.headline1?.color),
                    ),
                  ]),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isAuthor ? null : 120,
          right: isAuthor ? 120: null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
      ],
    );
  }
}
