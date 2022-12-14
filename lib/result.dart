import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_spajam2022/home.dart';
import 'package:flutter_application_spajam2022/take_picture1.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:ui' as ui;

// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'face_detec.dart';
// import 'package:flutter_application_spajam2022/judge.dart';

class Result extends StatefulWidget {
  // const Result({
  //   Key? key

  // })
  final image_win;
  final image_lose;
  Result(this.image_win, this.image_lose);
  // Result({this.image_win, this.image_lose});
  ResultState createState() => ResultState();
}

class ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late Future<void> _initializeControllerFuture;
  late AnimationController _animeController;
  late Animation<double> animation;
  // var image_win;
  // var image_lose;

  void shareImageAndText() async {
    //shareする際のテキスト
    try {
      final ImagePicker _picker = ImagePicker();
      File? _file;
      final XFile? _image =
          await _picker.pickImage(source: ImageSource.gallery);
      _file = File(_image!.path);

      await ShareExtend.share(_file.path, "image");
      // await ShareExtend.share(path, "image");
      // applicationDocumentsFile.delete();
    } catch (error) {
      print(error);
    }
  }

  Future<void> AnimeOn() async {
    // var random = math.Random();
    int _time = 1600; // 5秒間待つ(爆発している時間)
    await Future.delayed(Duration(milliseconds: _time));
    _animeController.forward();
  }

  @override
  void initState() {
    super.initState();
    image_win = widget.image_win;
    image_lose = widget.image_lose;
    // アニメーション
    AnimeOn();
    _animeController = AnimationController(
      vsync: this, // with SingleTickerProviderStateMixin を忘れずに
      duration: Duration(milliseconds: 1), // ここに遷移する時間記入
    );
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    _animeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    savePicture();
    return Scaffold(
      backgroundColor: Color(0xffefedd7),
      // appBar: AppBar(
      //   title: const Text('ホーム画面'),
      // ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('勝者',
                  style: TextStyle(fontSize: 50, fontFamily: 'RocknRollOne')),
            ),
            Stack(
              children: [
                SizedBox(
                    width: 360, child: Image.file(File(widget.image_win.path))),
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                    end: RelativeRect.fromLTRB(1000, 1000, 1000, 1000),
                  ).animate(CurvedAnimation(
                    parent: _animeController,
                    curve: Curves.easeIn,
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Image(
                      image: AssetImage('images/explosion.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text('ホームに戻る', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      shareImageAndText();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text('共有', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Result extends StatefulWidget {
//   // var image;
//   const Result({super.key});
//   // Result({this.image});
//   // judgement() {
//   //   throw UnimplementedError();
//   // }

//   @override
//   State<Result> createState() => _ResultState();
// }

// class _ResultState extends State<Result> {
//   // var image_win = widget.image;
//   var image_win;
//   var image_dis;
//   // void judgement() async {
//   //   // var random = math.Random();
//   //   // double saikoro = random.nextDouble();
//   //   FaceDetector player1 = await FaceDetector(image1.path);
//   //   FaceDetector player2 = await FaceDetector(image2.path);
//   //   await Future.delayed(Duration(seconds: 5));
//   //   double image_emotion1 = player1.sum;
//   //   double image_emotion2 = player2.sum;
//   //   if (image_emotion1 > image_emotion2) {
//   //     image_win = image1;
//   //     image_lose = image2;
//   //   } else {
//   //     image_win = image2;
//   //     image_lose = image1;
//   //   }
//   //   image_dis = image_win;
//   //   print('くそ');
//   //   print(image_emotion1);
//   //   print('はげ');
//   //   print(image_emotion2);
//   //   savePicture();
//   // }

//   void shareImageAndText() async {
//     //shareする際のテキスト
//     try {
//       final ImagePicker _picker = ImagePicker();
//       File? _file;
//       final XFile? _image =
//           await _picker.pickImage(source: ImageSource.gallery);
//       _file = File(_image!.path);

//       await ShareExtend.share(_file.path, "image");
//       // await ShareExtend.share(path, "image");
//       // applicationDocumentsFile.delete();
//     } catch (error) {
//       print(error);
//     }
//   }

//   void initState() {
//     super.initState();

//     judgement();
//   }

//   @override
//   Widget build(BuildContext context) {
//     judgement();

//     return Scaffold(
//       backgroundColor: Color(0xffefedd7),
//       appBar: AppBar(
//         title: const Text('ホーム画面'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text('勝者',
//                   style: TextStyle(fontSize: 50, fontFamily: 'RocknRollOne')),
//             ),
//             image_win == null
//                 ? Center(child: CircularProgressIndicator())
//                 : Stack(
//                     children: [
//                       SizedBox(
//                           width: 360, child: Image.file(File(image_win.path))),
//                       // Image(
//                       //   image: AssetImage('images/explosion.gif'),
//                       //   fit: BoxFit.cover,
//                       //   color: Color.fromRGBO(0, 0, 0, 0.9),
//                       // ),
//                     ],
//                   ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Home(),
//                           fullscreenDialog: true,
//                         ),
//                       );
//                     },
//                     child: const Text('ホームに戻る', style: TextStyle(fontSize: 20)),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       shareImageAndText();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Home(),
//                           fullscreenDialog: true,
//                         ),
//                       );
//                     },
//                     child: const Text('共有', style: TextStyle(fontSize: 20)),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
