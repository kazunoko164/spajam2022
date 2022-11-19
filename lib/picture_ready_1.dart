import 'package:flutter/material.dart';
import 'package:flutter_application_spajam2022/take_picture1.dart';
// import 'package:flutter_application_spajam2022/take_picture2.dart';
// import 'take_picture1.dart';

class PictureReady1 extends StatelessWidget {
  // SecondPage(this.name); // *** コンストラクタ 変数を指定しておくことによって値を受け取ることが出来る．
  // final String name; // 値が入る変数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 上部のタイトルバー
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('プレイヤー1の写真撮る画面だよ'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TakePicture1(),
              // fullscreenDialog: true,
              ),
            );
          },
          child: const Text('写真撮るよー'),
        ),
      ),
    );
  }
}