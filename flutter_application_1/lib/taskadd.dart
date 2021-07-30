// @dart=2.9
import 'package:flutter/material.dart';

// class TaskAdd extends StatelessWidget {
//   String res_;

//   TaskAdd({Key key, @required this.res_}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("user: user1"),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.white,
//         alignment: Alignment.center,
//         child: Text(
//           "{Here is TaskAdd Window!}",
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//       ),
//     );
//   }
// }

// リスト追加画面用Widget
class TaskAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *** 追加する部分 ***
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      // *** 追加する部分 ***
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // テキスト入力
            TextField(),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
