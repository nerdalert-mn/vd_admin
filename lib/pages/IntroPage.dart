import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vd_admin/pages/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 49, 190, 175)),
                  padding: const EdgeInsets.all(25),
                  child: Icon(Icons.done,
                      color: Colors.white, size: Get.size.width * 0.2),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text('Realtime Surveillance',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => LoginPage());
                },
                child: Text('Үргэлжлүүлэх'),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
