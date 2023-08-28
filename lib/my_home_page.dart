import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Biến lưu trữ giá trị của văn bản hiển thị
  var text = 'default';

  // Hàm trả về một Future<String> sau một khoảng thời gian (2 giây)
  Future<String> textFunc() {
    return Future.delayed(const Duration(seconds: 2), (() => 'hello'));
  }

  // Hàm trả về một Future<String> sau một khoảng thời gian (2 giây) và ném ra một Exception
  // Không được sử dụng trong đoạn mã này (đã bị bỏ comment)
  // Future<String> exceptionFunc() {
  //   return Future.delayed(const Duration(seconds: 2), throw Exception('Error'));
  // }

  // Hàm trả về một Future<String> sau một khoảng thời gian (2 giây) sử dụng Completer để hoàn thành Future
  Future<String> textFunc2() {
    var value = Completer<String>();
    Future.delayed(
        const Duration(seconds: 2), (() => value.complete('Hello World')));
    return value.future;
  }

  // Xử lý khi nút được nhấn, gọi hàm textFunc và sau đó cập nhật giá trị văn bản hiển thị
  // onPressed() async {
  //   textFunc().then((value) {
  //     setState(() {
  //       text = value;
  //     });
  //   });
  // }

  // Xử lý khi nút được nhấn (cách 2), sử dụng await để chờ kết quả từ textFunc2 và sau đó cập nhật giá trị văn bản hiển thị
  // (Đoạn này đã bị bỏ comment)
  // onPressed() async {
  //   text = await textFunc2();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Widget hiển thị giá trị văn bản
          Center(
            child: FutureBuilder(
              future: textFunc2(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Nếu Future đang chờ, hiển thị một biểu tượng tiến trình
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  // Nếu có dữ liệu từ Future, hiển thị giá trị đó
                  var value = snapshot.data.toString();
                  return Text(value);
                }
                if (snapshot.hasError) {
                  // Nếu có lỗi từ Future, in lỗi ra màn hình
                  print(snapshot.error);
                }
                return const Text('');
              }),
            ),
          )
        ],
      ),
    );
  }
}

//làm việc với Future để xử lý công việc bất đồng bộ và sử dụng FutureBuilder để xây dựng giao diện dựa trên trạng thái của Future.
//Future<String> textFunc2() trả về một Future chứa một chuỗi sau khi một khoảng thời gian đã trôi qua. Điều này dẫn đến việc cập nhật giao diện người dùng dựa trên kết quả của Future này.
