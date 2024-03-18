import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class PokemonItemSkeleton extends StatelessWidget {
  const PokemonItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SkeletonAnimation(
              shimmerColor: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              shimmerDuration: 1000,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAnimation(
                  shimmerColor: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  shimmerDuration: 1000,
                  child: Container(
                    height: 8,
                    width: constraints.maxWidth * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SkeletonAnimation(
                  shimmerColor: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  shimmerDuration: 1000,
                  child: Container(
                    height: 8,
                    width: constraints.maxWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
