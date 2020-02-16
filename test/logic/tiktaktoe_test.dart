import 'package:flutter_test/flutter_test.dart';
import 'package:tiktaktoe/logic/logic.dart';

void main() {
  group("test grid class", () {
    var tik = TikTakToe();
    tik.fromMap({
      "grid": [
        [Nil, Nil, Nil],
        [Nil, Nil, Nil],
        [Nil, Nil, Nil],
      ]
    });

    test("number of list", () {
      var result = tik.toMap()["grid"];
      expect(result, isInstanceOf<List>());
      expect((result as List).length, 3);
      expect((result as List)[0], isInstanceOf<List>());
      expect(((result as List)[0] as List)[0], Nil);
    });
  });

  group("game test", () {
    var tt = TikTakToe()
      ..fromMap({
        "grid": [
          [Nil, Nil, X],
          [Nil, O, Nil],
          [X, Nil, Nil],
        ]
      });

    var t = TikTakToeHandler(
      Stream.fromIterable([tt.toMap()]),
      command: null,
    );

    test("0-0", () => expect(t.last.find(0, 0), Nil));
    test("1-0", () => expect(t.last.find(1, 0), Nil));
    test("2-0", () => expect(t.last.find(2, 0), X));
    test("0-1", () => expect(t.last.find(0, 1), Nil));
    test("1-1", () => expect(t.last.find(1, 1), O));
    test("1-2", () => expect(t.last.find(1, 2), Nil));
  });
}
