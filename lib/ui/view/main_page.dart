import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/widget/remain_stat_list_tile.dart';
import '../../viewmodel/store_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel =
        Provider.of<StoreModel>(context); // 여기서 제공한 모델 인스턴스를 사용할 수 있게 됨.
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: [
          IconButton(
            onPressed: () {
              storeModel.fetch();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(storeModel),
    );
  }
}

Widget _buildBody(StoreModel storeModel) {
  if (storeModel.isLoading == true) {
    return loadingWidget();
  }

  if (storeModel.stores.isEmpty) {
    return Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('반경 5km 이내에 재고가 있는 매장이 없습니다.'),
          Text('또는 인터넷이 연결되어 있는지 확인해 주세요.'),
        ],
      ),
    );
  }

  return ListView(
    children: storeModel.stores.map((e) {
      return RemainStatListTile(e);
    }).toList(),
  );
}

Widget loadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('정보를 가져오는 중..'),
        CircularProgressIndicator(),
      ],
    ),
  );
}
