import 'package:flutter/material.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.center,
            height: double.maxFinite,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
            child: Text(
              "Photos",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(child: Text("Select Photo"))
        ],
      ),
    );
  }
}