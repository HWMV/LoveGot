import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/anniversary_widget.dart';
import '../widgets/pet_widget.dart';
import '../widgets/affection_level_widget.dart';
import '../widgets/countdown_widget.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../widgets/request_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data (would be fetched from backend in a real app)
  final DateTime anniversaryDate = DateTime(2024, 1, 1);
  final String myNickname = "나";
  final String partnerNickname = "그대";
  final int affectionLevel = 76;
  final DateTime nextSpecialDay = DateTime(2024, 7, 20);
  final String specialDayName = "100일";
  int _selectedIndex = 0;

  Future<void> _showRequestDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const RequestDialog(),
    );

    if (result != null) {
      // TODO: Handle the selected request
      print('Original: ${result['original']}');
      print('Improved: ${result['improved']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysSinceAnniversary =
        DateTime.now().difference(anniversaryDate).inDays;
    final daysUntilSpecialDay =
        nextSpecialDay.difference(DateTime.now()).inDays;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HomeAppBar(
              onMessageTap: _showRequestDialog,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      AnniversaryWidget(
                        days: daysSinceAnniversary,
                        myNickname: myNickname,
                        partnerNickname: partnerNickname,
                      ),
                      const SizedBox(height: 20),
                      const PetWidget(),
                      const SizedBox(height: 20),
                      AffectionLevelWidget(
                        affectionLevel: affectionLevel,
                      ),
                      const SizedBox(height: 20),
                      CountdownWidget(
                        daysRemaining: daysUntilSpecialDay,
                        specialDayName: specialDayName,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _showRequestDialog,
                    child: const Text('요청'),
                  ),
                ],
              ),
            ),
            BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                // TODO: Implement navigation
              },
            ),
          ],
        ),
      ),
    );
  }
}
