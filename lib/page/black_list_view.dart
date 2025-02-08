import 'package:flutter/material.dart';
import 'package:hotel/service/black_list_service.dart';

class BlackListView extends StatefulWidget {
  const BlackListView({super.key});

  @override
  State<BlackListView> createState() => _BlackListViewState();
}

class _BlackListViewState extends State<BlackListView> {
  List<dynamic> blackList = [];
  bool loading = true;
  final BlacklistService _blacklistService = BlacklistService();

  @override
  void initState() {
    super.initState();
    fetchBlackList();
  }

  Future<void> fetchBlackList() async {
    try {
      final data = await _blacklistService.getBlacklist();
      setState(() {
        blackList = data;
        loading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kara Liste'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : blackList.isEmpty
              ? const Center(child: Text('Kara liste boş.'))
              : ListView.builder(
                  itemCount: blackList.length,
                  itemBuilder: (context, index) {
                    final item = blackList[index];
                    return _blackListItem(item);
                  },
                ),
    );
  }

  Widget _blackListItem(dynamic item) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personel Adı Soyadı',
                        style: _textstyle(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(item['ad'] ?? 'Ad yok'),
                          SizedBox(width: 10),
                          Text(item['soyad'] ?? 'Soyad yok'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Kara Listeye Alınma Sebebi ',
                style: _textstyle(),
              ),
              const SizedBox(height: 8),
              Text(item['suç'] ?? 'Suç bilgisi yok'),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
      ],
    );
  }

  TextStyle _textstyle() {
    return TextStyle(fontSize: 20, color: Colors.white);
  }
}
