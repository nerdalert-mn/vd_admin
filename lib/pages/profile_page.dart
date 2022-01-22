import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.person,
                              size: Get.size.width * 0.2, color: Colors.pink),
                          Text(
                            'Д.Болдбаатар',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text('Утас'),
                      subtitle: Text('89983847'),
                    ),
                    ListTile(
                      title: Text('email'),
                      subtitle: Text('boldoo33@gmail.com'),
                    ),
                    ListTile(
                        title: Container(
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Нууц үг солих')),
                    )),
                    ListTile(
                        title: Container(
                      child: TextButton(onPressed: () {}, child: Text('Гарах')),
                    )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
