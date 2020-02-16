import 'package:flutter/material.dart';
import 'package:tiktaktoe/logic/logic.dart';
import 'package:tiktaktoe/pages/widgets/tiktak_widget.dart';

class GridTikTakToe extends StatelessWidget {
  const GridTikTakToe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<List<SingleTikTakToe>>>(
      stream: TikTakHandlerWidget.of(context).handler.stream,
      builder: (context, data) {
        if (data.data == null) return Container();

        return Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.95,
            color: Colors.red,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: data.data.map<Widget>((e) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: e.map((e) => _Single(e)).toList());
                }).toList()));
      },
    );
  }
}

class _Single extends StatelessWidget {
  final SingleTikTakToe ttt;
  _Single(this.ttt, {Key key}) : super(key: key);

  String toText(int value) {
    if (value == 0) {
      return "O";
    }
    if (value == 1) {
      return "X";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.ttt.insert();
      },
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * 0.95 / 3.2,
        height: MediaQuery.of(context).size.width * 0.95 / 3.2,
        child: Center(
          child: Text(
            this.toText(this.ttt.state),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}
