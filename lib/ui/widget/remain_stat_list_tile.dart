import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';


class RemainStatListTile extends StatelessWidget {
  final Store store;
  const RemainStatListTile(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(store.addr ?? ''),
          Text('${store.km}km'),
        ],
      ),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchURL(store.lat ?? 0, store.lng ?? 0);
      },
    );
  }

  void _launchURL(double lat, double lng) async {
    final _url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';

    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개 이상';
        color = Colors.yellow;
        break;
      case '':
        remainStat = '부족';
        description = '2 ~ 30개 이상';
        color = Colors.red;
        break;
      case 'plenty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
        break;
    }

    if (store.remainStat == 'plenty') {
    } else if (store.remainStat == 'some') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    } else if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    } else if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    } else if (store.remainStat == 'plenty') {
    } else if (store.remainStat == 'plenty') {
    } else if (store.remainStat == 'plenty') {}

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
