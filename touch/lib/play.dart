import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  final int _levelPassedFromHome;
  // main.dartからもらった値

  const Play(this._levelPassedFromHome, {Key? key}) : super(key: key);
  // この関数を他のファイルのNavigator.push()のMaterialPageRouteの戻り値として使ったら値をもらうことができる

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  String _levelInEnglish = "";
  // Easy・Normal・Hard・Hellのいずれかが入る
  String _yourStatus = "";
  // _scoreに対する評価

  bool _isFirst = true;
  // 最初回であるか否かを判定
  bool _isPlaying = false;
  // ゲーム中であるか否かを判定
  bool _touchIsPossible = false;
  // タッチができる状態か否かを判定
  bool _isCountdownStart = false;
  // カウントダウン中であるか否かを判定
  bool _isDialogOpen = false;
  // Dialogが開いている状態か否かを判定

  int _whichButton = -1;
  // 16個のボタンの中でどのボタンを白くするかのための変数
  int _score = 0;
  // 結果を記録するための変数
  final int _maxScore = 999;
  // 最高点
  int _count = 3;
  // カウントダウンに用いる変数（３、２、１のような）

  late int _durationForMS;
  //　選択した難易度のタッチ可能な時間と次のボタンが表示されるまでの時間を入れるための変数（単位：ミリ秒）
  late Timer _timer;
  // Timer クラスを使うための準備

  @override
  Widget build(BuildContext context) {
    _checkLevel(widget._levelPassedFromHome);
    // 選択された難易度に対して設定を行う

    return WillPopScope(
      onWillPop: () async {
        return false;
        // 「Swipeして戻る」機能を無効にする
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.indigoAccent,
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Text(
                    _levelInEnglish,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _push(1),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 1) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(2),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 2) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(3),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 3) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(4),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 4) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _push(5),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 5) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(6),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 6) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(7),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 7) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(8),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 8) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _push(9),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 9) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(10),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 10) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(11),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 11) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(12),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 12) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _push(13),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 13) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(14),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 14) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(15),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 15) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _push(16),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 70),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (_whichButton == 16) {
                            return Colors.white;
                          } else {
                            return Colors.black12;
                          }
                        }),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: null,
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Text(
                    _isFirst
                    // 最初回->① / 最初回X->②
                        ? "READY"
                        // ①　READYを表示
                        : _isCountdownStart
                        // ②　カウントダウン中->③ / カウントダウンX->④
                            ? _count.toString()
                            // ③　_countを表示（３、２、１）
                            : _isPlaying
                            // ④　ゲーム中->⑤ / ゲーム中X->⑥
                                ? _score == 0
                                // ⑤　結果が0->⑦ / 結果が0ではない->⑧
                                    ? "START"
                                    // ⑦　カウントダウンが終わり、ゲームが始まったことを知らせる
                                    : "Score : ${_score.toString()}"
                                    // ⑧　ゲーム中であり、現在の結果を知らせる
                                : "FINISH",
                                // ⑥　ゲームが終わったことを知らせる
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _startGame,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.cyan,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(130, 50),
                          ),
                        ),
                        child: const Text(
                          "START",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.cyan,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(130, 50),
                          ),
                        ),
                        child: const Text(
                          "HOME",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  visible: !_isPlaying,
                  // ゲーム中にはSTARTやBACKボタンが見えないようにして、操作を防ぐ
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkLevel(int level) {
    // 難易度に対して設定を行う
    if (level == 1) {
      _levelInEnglish = "Easy";
      _durationForMS = 1000;
    } else if (level == 2) {
      _levelInEnglish = "Normal";
      _durationForMS = 750;
    } else if (level == 3) {
      _levelInEnglish = "Hard";
      _durationForMS = 500;
    } else if (level == 4) {
      _levelInEnglish = "Hell";
      _durationForMS = 250;
    }
  }

  void _timerStart() {
    _timer = Timer(Duration(milliseconds: _durationForMS), _finishGame);
    // Timerを起動し、設定した時間がすぎたらゲームを終了させる
  }

  void _timerCancel() {
    _timer.cancel();
    // Timerをキャンセルさせる
  }

  void _pickButton() {
    _whichButton = Random().nextInt(16) + 1;
    // 白くするボタンをランダムに選択する
  }

  void _startGame() {
    // ゲームを始める
    setState(() {
      if (_isFirst) _isFirst = false;
      // 最初回であれば、これ以上は最初回ではないことを知らせる
      if (!_isPlaying) {
        // ゲームが始まっていなければ（ゲームを始めようとする）
        _score = 0;
        // 結果(_score)の初期化
        _isPlaying = true;
        // ゲーム中であることを知らせる（ゲームを始める）
        _isCountdownStart = true;
        // カウントダウンが始まったことを知らせる
        Timer tmp = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _count--;
            // 1秒間隔で_countから１を引く（３→２→１　＝　カウントダウン）
            // 非同期（※）
          });
        });
        Future.delayed(const Duration(seconds: 3), () {
          // 3秒の後に下記のことを実行する
          // 非同期(※)
          setState(() {
            tmp.cancel();
            // 上記のtmp　Timerをキャンセルさせる（キャンセルしないと無限に_count--をするため）
            _isCountdownStart = false;
            // カウントダウンが終わったことを知らせる
            _beforePush();
            // 「白いボタンを押す」以前の処理を行う
          });
        });
      }
    });
  }

  void _beforePush() {
    // 「白いボタンを押す」以前の処理
    setState(() {
      _timerStart();
      // 選択された難易度によって事前に設定された時間を制限時間とするTimerを起動させる
      _pickButton();
      // 白いボタンの選択
      _touchIsPossible = true;
      // タッチできるようにする
      // 白いボタンの選択の前にタッチすることでゲームが終わってしまうことを防止
    });
  }

  void _push(int num) {
    // 「白いボタンを押す」の処理
    setState(() {
      if (_touchIsPossible) {
        // タッチできる状態であれば
        if (_whichButton != num) {
          // 「白いボタン」と押したボタンが異なる場合
          _finishGame();
          // ゲームを終了させる
        } else {
          // 「白いボタン」と押したボタンが一致する場合
          _afterPush();
          // 「白いボタンを押す」以後の処理を行う
          if (_score < _maxScore) {
            // 結果が最大値未満であれば
            // ゲームを続く
            Future.delayed(Duration(milliseconds: _durationForMS), () {
              // 選択された難易度によって事前に設定された時間だけ待機
              setState(() {
                _beforePush();
                // 「白いボタンを押す」以前の処理
              });
            });
          } else {
            // 結果が最大値以上であれば
            _finishGame();
            // ゲームを終了させる
          }
        }
      }
    });
  }

  void _afterPush() {
    // 「白いボタンを押す」以後の処理
    setState(() {
      _timerCancel();
      // Timerをキャンセルさせる
      _touchIsPossible = false;
      // タッチできない状態にする
      _score++;
      // 結果(_score)に１を足す
      _whichButton = -1;
      // 白いボタンを初期化
    });
  }

  void _checkYourStatus() {
    // _yourStatusに結果に対する評価を入れる
    if (_score >= _maxScore) {
      // _maxScore以上になれば
      _yourStatus = "ここまでできるとは?!";
    } else {
      // _maxScore未満であれば
      if (0 <= _score && _score < 100) {
        if (0 <= _score && _score < 10) {
          _yourStatus = "これはひどい";
        } else {
          _yourStatus = "がんばりましょう";
        }
      } else {
        if (100 <= _score && _score < 500) {
          _yourStatus = "いいね~";
        } else if (500 <= _score && _score < _maxScore) {
          _yourStatus = "すごい!！";
        }
      }
    }
  }

  void _finishGame() {
    // ゲームを終了させる
    setState(() {
      _touchIsPossible = false;
      // タッチできない状態にする
      _checkYourStatus();
      // 結果に対する評価を行う
      _whichButton = -1;
      // 白いボタンを初期化
      _isPlaying = false;
      // ゲームが終わったことを知らせる
      _count = 3;
      // カウントダウンの初期化
      if (!_isDialogOpen) {
        // Dialogが開いていなければ
        _showDialog();
        // Dialogを表示させる
      }
    });
  }

  void _showDialog() {
    _isDialogOpen = true;
    // Dialogが表示されていることを知らせる
    showDialog(
      context: context,
      barrierDismissible: false,
      // OKボタンでしか戻ることができない
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          title: const Center(
            child: Text(
              "Your Score",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                _score.toString(),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _yourStatus,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  _isDialogOpen = false;
                  // Dialogが開いていない状態にする
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
