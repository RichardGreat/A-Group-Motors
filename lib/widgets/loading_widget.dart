import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
