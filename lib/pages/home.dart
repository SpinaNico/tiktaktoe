import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:tiktaktoe/logic/logic.dart';
import 'package:tiktaktoe/pages/widgets/grid.dart';
import 'package:tiktaktoe/pages/widgets/tiktak_widget.dart';

class ConcreteCommand implements TitTakToeCommand {
  final _grid = TikTakToe()
    ..fromMap({
      "grid": [
        [Nil, Nil, Nil],
        [Nil, Nil, Nil],
        [Nil, Nil, Nil],
      ]
    });
  final _state = BehaviorSubject<Map>();
  Stream<Map> get stream => this._state.stream;

  int turnOf = 1;

  Future<void> insert(int x, int y) async {
    this._grid.grid[x][y] = this.turnOf;
    if (turnOf == 1) {
      turnOf = 0;
    } else {
      turnOf = 1;
    }
    this._state.add(this._grid.toMap());
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final command = ConcreteCommand();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TikTakHandlerWidget(
            handler:
                TikTakToeHandler(this.command.stream, command: this.command),
            child: GridTikTakToe(),
          ),
        ],
      ),
    );
  }
}
