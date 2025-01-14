import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShrimmer {
  loadingShimmer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(10, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: Container(
              width: double.infinity,
              height: size.height * 0.1,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
          );
        })),
      ),
    );
  }

  walletShimmer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              height: size.height * 0.03,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.08),
            Container(
              width: double.infinity,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              width: double.infinity,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  kycShimmer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Container(
              width: double.infinity,
              height: size.height * 0.03,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              width: double.infinity,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              width: double.infinity,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
