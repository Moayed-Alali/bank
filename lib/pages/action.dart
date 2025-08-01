import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final IconData icon;
  final String label; // Add label text
  final VoidCallback? onTap; // add onTap parameter (optional)

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap, // allow null so you can keep using it without onTap if you want
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00D4FF),
                    Color.fromARGB(255, 18, 128, 255)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ), // Bright blue for buttons
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(widget.icon, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 6), // Space between icon and text
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(221, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
