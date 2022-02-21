import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vd_admin/pages/history_single_page.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  final Stream<QuerySnapshot> _historyStream = FirebaseFirestore.instance
      .collection('history')
      .orderBy('timestamp', descending: true)
      .limit(200)
      .snapshots();

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
        child: StreamBuilder<QuerySnapshot>(
          stream: _historyStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              );
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  final formattedTimestamp =
                      dateFormat.format(data['timestamp'].toDate().toLocal());
                  final fileName = data['fileName'];
                  final imageUrl =
                      'https://firebasestorage.googleapis.com/v0/b/rtvd-test.appspot.com/o/detection_images%2F$fileName?alt=media';
                  final onTap = () {
                    Get.to(() => HistorySinglePage(
                        id: document.id,
                        description: formattedTimestamp,
                        imageUrl: imageUrl));
                  };
                  return ListTile(
                    onTap: onTap,
                    leading: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(
                      formattedTimestamp,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 25,
                      ),
                      onPressed: onTap,
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
