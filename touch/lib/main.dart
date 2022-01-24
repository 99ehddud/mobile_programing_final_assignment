import 'package:flutter/material.dart';
import 'package:touch/play.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _information = "白いボタンを押すだけ！";
  // 画面の中央に書かれる説明
  int _currentLevel = 0;
  // 選択された難易度
  bool _visibility = false;
  // READYボタンのShow/Hideのために用いる

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigoAccent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 130,
                    child: const Text(
                      "touch",
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 100,
                    child: Text(
                      _information,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _onClick(1),
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 1) return Colors.indigoAccent;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 1) {
                              return Colors.white;
                            } else {
                              return Colors.black12;
                            }
                          }),
                          fixedSize: MaterialStateProperty.all(
                            const Size(130.0, 100.0),
                          ),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text("Easy"),
                      ),
                      const SizedBox(width: 22),
                      ElevatedButton(
                        onPressed: () => _onClick(2),
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 2) return Colors.indigoAccent;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 2) {
                              return Colors.white;
                            } else {
                              return Colors.black12;
                            }
                          }),
                          fixedSize: MaterialStateProperty.all(
                            const Size(130.0, 100.0),
                          ),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text("Normal"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _onClick(3),
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 3) return Colors.indigoAccent;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 3) {
                              return Colors.white;
                            } else {
                              return Colors.black12;
                            }
                          }),
                          fixedSize:
                              MaterialStateProperty.all(const Size(130.0, 100.0)),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text("Hard"),
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: () => _onClick(4),
                        style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 4) return Colors.indigoAccent;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (_currentLevel == 4) {
                              return Colors.white;
                            } else {
                              return Colors.black12;
                            }
                          }),
                          fixedSize:
                              MaterialStateProperty.all(const Size(130.0, 100.0)),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text("Hell"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Visibility(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return Play(_currentLevel);
                              // play.dartに移動し、_currentLevelの値を渡す
                        }));
                      },
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.cyan,
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all(
                          const Size(285, 60),
                        ),
                      ),
                      child: const Text("READY"),
                    ),
                    visible: _visibility,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onClick(int selectedLevel) {
    // Easy(1)・Normal(2)・Hard(3)・Hell(4)のいずれかを押すと難易度の選択ができる
    setState(() {
      if (selectedLevel == _currentLevel) {
        // 押した難易度と現在選択されている難易度が同じであれば
        if (_visibility) _visibility = false;
        // READYボタンが見えているのであれば見えないようにする
        _currentLevel = 0;
        // 選択された難易度を初期化する
        _information = "白いボタンを押すだけ！";
        // 説明を初期化する
      } else {
        if (!_visibility) _visibility = true;
        // READYボタンが見えないのであれば見えるようにする
        if (selectedLevel == 1) {
          // Easyモード
          _currentLevel = 1;
          _information = "緩やかなスピード";
        } else if (selectedLevel == 2) {
          // Normalモード
          _currentLevel = 2;
          _information = "まだ普通のスピード";
        } else if (selectedLevel == 3) {
          // Hardモード
          _currentLevel = 3;
          _information = "ちょっと速いかも";
        } else if (selectedLevel == 4) {
          // Hellモード
          _currentLevel = 4;
          _information = "あっという間に終わった...";
        }
      }
    });
  }
}
