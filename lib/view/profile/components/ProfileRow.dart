import 'package:flutter/material.dart';

class Profilerow extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String text;
  final VoidCallback onPressed;
  final bool divider;

  Profilerow(
      {super.key,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.text,
      required this.onPressed,
      required this.divider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  leadingIcon,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: onPressed,
              ),
              Text(
                text,
                style:
                    Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  trailingIcon,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
        divider
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
