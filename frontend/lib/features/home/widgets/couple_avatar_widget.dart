import 'package:flutter/material.dart';

class CoupleAvatarWidget extends StatelessWidget {
  const CoupleAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // 배경 이미지의 비율에 맞춤
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 배경 이미지
            Positioned.fill(
              child: Image.asset(
                'assets/images/wedding_bg1.png',
                fit: BoxFit.cover,
              ),
            ),
            // 캐릭터들을 가로로 배치하는 Row
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 여자 캐릭터 (왼쪽)
                  Image.asset(
                    'assets/images/woman_avatar1.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 1),
                  // 남자 캐릭터 (오른쪽)
                  Image.asset(
                    'assets/images/man_avatar1.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
