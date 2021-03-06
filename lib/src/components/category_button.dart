import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String label;
  final Function() onPressed;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = borderRadius ?? BorderRadius.circular(10);

    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: _borderRadius,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(.25),
              borderRadius: _borderRadius,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 60,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
