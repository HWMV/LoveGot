import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_card.dart';

class PetWidget extends StatelessWidget {
  const PetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/pet.png',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.pets,
                    size: 80,
                    color: Colors.amber,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
