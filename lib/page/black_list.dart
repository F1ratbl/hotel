import 'package:flutter/material.dart';
import 'package:hotel/page/black_list_view.dart';
import 'package:hotel/service/black_list_service.dart';

class DarkList extends StatefulWidget {
  final fetchAndStatePage;
  const DarkList({super.key, required this.fetchAndStatePage});

  @override
  State<DarkList> createState() => _DarkListState();
}

class _DarkListState extends State<DarkList> {
  final _adController = TextEditingController();
  final _soyadController = TextEditingController();
  final _sucController = TextEditingController();

  BlacklistService _blackListService = BlacklistService();

  Future<void> addToBlacklist() async {
    Map<String, dynamic> personData = {
      'ad': _adController.text,
      'soyad': _soyadController.text,
      'suç': _sucController.text,
    };

    try {
      await _blackListService.addToBlacklist(personData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('kişi başarıyla eklendi')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kara Liste'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _darkField(_adController, 'Personel Adı', 1),
          SizedBox(height: 20),
          _darkField(_soyadController, 'Personel Soyadı', 1),
          SizedBox(height: 20),
          _darkField(_sucController, 'Kara Listeye Alınma Sebebi', 5),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _darkListButton('Kaydet'),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _darkListButton('Listeyi Görüntüle'),
          ),
        ],
      ),
    );
  }

  GestureDetector _darkListButton(String text) {
    return GestureDetector(
      onTap: () {
        if (text == 'Kaydet') {
          addToBlacklist();
        } else if (text == 'Listeyi Görüntüle') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BlackListView()),
          );
        }
        widget.fetchAndStatePage();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        color: Colors.red,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        )),
      ),
    );
  }

  TextFormField _darkField(dynamic controller, String hintText, int lines) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20, color: Colors.white)),
      maxLines: lines,
    );
  }
}
