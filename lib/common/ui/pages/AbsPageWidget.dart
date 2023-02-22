import 'package:flutter/material.dart';

class AbsPageWidget<T> extends StatefulWidget {

  final String title;
  final Future<T> Function() getData;
  final Widget Function(BuildContext ctx, T data) dataBuilder;

  const AbsPageWidget({Key? key, required this.title, required this.getData, required this.dataBuilder}) : super(key: key);

  @override
  State<AbsPageWidget<T>> createState() => _AbsPageWidgetState();
}

class _AbsPageWidgetState<T> extends State<AbsPageWidget<T>> {
  Future<T>? futureData;

  void _loadData() {
    setState(() {
      futureData = widget.getData();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<T>(
        future: futureData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if(snapshot.hasError) {
                var error = snapshot.error!;
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline),
                      Text("Error"),
                    ],
                  ),
                );
              } else {
                return widget.dataBuilder(context, snapshot.data!);
              }
            default:
              return Center(child: CircularProgressIndicator());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

