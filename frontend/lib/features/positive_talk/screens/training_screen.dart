import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  final String situation;

  const TrainingScreen({
    Key? key,
    required this.situation,
  }) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Selected Situation: ${widget.situation}',
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Pretendard',
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
