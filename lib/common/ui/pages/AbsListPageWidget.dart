import 'package:flutter/material.dart';
import 'package:mobile_app_dev/movies/data/datasource/MoviesDatasource.dart';

import 'AbsPageWidget.dart';

class AbsListPageWidget<I> extends StatelessWidget {
  final String title;
  final Future<List<I>> Function() getList;
  final Widget Function(BuildContext ctx, I item) itemBuilder;

  AbsListPageWidget({
    Key? key,
    required this.title,
    required this.itemBuilder,
    required this.getList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsPageWidget<List<I>>(
      title: title,
      getData: () => getList(),
      dataBuilder: (context, data) {
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return itemBuilder(context, data[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 16);
          },
        );
      },
    );
  }
}



