import 'package:flutter/material.dart';
import 'package:mobile_app_dev/movies/data/datasource/MoviesDatasource.dart';

class AbsListPageWidget<T> extends StatefulWidget {
  final String title;
  final Future<List<T>> Function() getList;
  final Widget Function(BuildContext ctx, T item) itemBuilder;

  AbsListPageWidget({
    Key? key,
    required this.title,
    required this.itemBuilder,
    required this.getList,
  }) : super(key: key);

  @override
  State<AbsListPageWidget<T>> createState() => _AbsListPageWidgetState<T>();
}

class _AbsListPageWidgetState<T> extends State<AbsListPageWidget<T>> {
  Future<List<T>>? futureItems;

  void _loadData() {
    setState(() {
      futureItems = widget.getList();
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
      body: FutureBuilder(
        future: futureItems,
        builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
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
                List<T> items = snapshot.data ?? [];
                return ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.itemBuilder(context, items[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16);
                  },
                );
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
