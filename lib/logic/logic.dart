import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jsonable/jsonable.dart';
import 'package:rxdart/subjects.dart';
import 'package:tiktaktoe/logic/errors.dart';

const X = 0;
const O = 1;
const Nil = -1;

class SingleTikTakToe {
  final int x;
  final int y;
  final int state;
  final TitTakToeCommand command;
  SingleTikTakToe(this.x, this.y, this.command, {this.state: Nil}) {
    if (this.x > 2) {
      throw ErrorCoordinate("x", this.x);
    }
    if (this.y > 2) {
      throw ErrorCoordinate("y", this.y);
    }
  }

  Future<void> insert() async {
    if (this.state == -1) {
      await this.command.insert(this.x, this.y);
    }
  }
}

// rapresents a game
class TikTakToe with Jsonable {
  JList<List<int>> grid;

  TikTakToe() {
    this.grid = jList("grid");
  }

  int find(int x, int y) {
    return this.grid[x][y];
  }
}

/*
 * 
 *  grid: [
 *    [-1,-1,-1],
 *    [-1,-1,-1],
 *    [-1,-1,-1]   
 * ]
 * List<List<int>>
 */

abstract class TitTakToeCommand {
  Future<void> insert(
    int x,
    int y,
  );
}

class TikTakToeHandler {
  StreamSubscription<Map> _subscription;

  final _stream = BehaviorSubject<List<List<SingleTikTakToe>>>();

  Stream<List<List<SingleTikTakToe>>> get stream => this._stream.stream;
  TikTakToe last;
  final TitTakToeCommand command;

  TikTakToeHandler(Stream<Map> stream, {@required this.command}) {
    this._stream.add(this._game(TikTakToe()
      ..fromMap({
        "grid": [
          [Nil, Nil, Nil],
          [Nil, Nil, Nil],
          [Nil, Nil, Nil],
        ]
      })));

    this._subscription = stream.listen((e) {
      this._stream.sink.add(this._game(TikTakToe()..fromMap(e)));
    });
  }

  //Parsing event from TikTakTo to game System.
  List<List<SingleTikTakToe>> _game(TikTakToe event) {
    last = event;
    List<List<SingleTikTakToe>> result = [];
    int indexRow = 0;
    int indexColumn = 0;

    for (var row in event.grid) {
      var l = <SingleTikTakToe>[];
      for (var point in row) {
        l.add(
            SingleTikTakToe(indexRow, indexColumn, this.command, state: point));
        indexColumn++;
      }
      result.add(l);
      indexColumn = 0;
      indexRow++;
    }
    return result;
  }

  dispose() {
    this._subscription.cancel();
  }
}
