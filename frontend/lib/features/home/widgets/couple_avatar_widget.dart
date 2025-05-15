import 'package:flutter/material.dart';

class CoupleAvatarWidget extends StatelessWidget {
  const CoupleAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // 아바타 크기 계산 (화면 높이의 40%)
    final avatarHeight = screenHeight * 0.4;

    // 아바타 간격 계산 (화면 너비의 5%)
    final avatarSpacing = screenWidth * 0.05;

    // 아바타 상단 여백 계산 (화면 높이의 15%)
    final topOffset = screenHeight * 0.15;

    return Expanded(
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
          children: [
            // 배경 이미지
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/wedding_bg1.png',
                fit: BoxFit.cover,
              ),
            ),
            // 캐릭터들을 가로로 배치하는 Row
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 여자 캐릭터 (왼쪽)
                    Transform.translate(
                      offset: Offset(avatarSpacing, -topOffset),
                      child: Image.asset(
                        'assets/images/man_avatar1.png',
                        height: avatarHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // 남자 캐릭터 (오른쪽)
                    Transform.translate(
                      offset: Offset(-avatarSpacing, -topOffset),
                      child: Image.asset(
                        'assets/images/woman_avatar1.png',
                        height: avatarHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
