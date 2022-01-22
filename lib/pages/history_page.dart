import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Түүх'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.pink[500]),
                    padding: const EdgeInsets.all(25),
                    child: Icon(Icons.find_in_page,
                        color: Colors.white, size: Get.size.width * 0.2),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 200,
                    child: const Text(
                      'Илрүүлэлтийн түүх байхгүй байна',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
