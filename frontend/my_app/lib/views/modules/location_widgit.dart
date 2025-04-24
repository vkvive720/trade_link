import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Spacing around the location row
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.red),
          const SizedBox(width: 4),
          const Text(
            'Noida',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
        ],
      ),
    );
  }
}
