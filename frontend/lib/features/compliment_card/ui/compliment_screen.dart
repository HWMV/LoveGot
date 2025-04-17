import 'package:flutter/material.dart';
import '../widget/compliment_dialog.dart';

class ComplimentScreen extends StatefulWidget {
  const ComplimentScreen({Key? key}) : super(key: key);

  @override
  State<ComplimentScreen> createState() => _ComplimentScreenState();
}

class _ComplimentScreenState extends State<ComplimentScreen> {
  void _showComplimentModal() {
    showDialog(
      context: context,
      builder: (context) => const ComplimentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('칭찬 카드'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showComplimentModal,
          child: const Text('칭찬카드 작성하기'),
        ),
      ),
    );
  }
}
