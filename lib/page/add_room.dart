import 'package:flutter/material.dart';
import 'package:hotel/service/service.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _roomNumberController = TextEditingController();
  final _issueNoteController = TextEditingController();

  String? _roomStatus;
  bool? _cleanlinessStatus;
  bool? _coffeeStatus;
  bool? _teaStatus;
  bool? _toiletPaperStatus;
  bool? _towelStatus;
  bool? _waterStatus;
  bool? _hasIssue;

  final RoomService _roomService = RoomService();

  // Oda durumu için kontrol fonksiyonu
  void _determineRoomStatus() {
    setState(() {
      if (_hasIssue == true) {
        _roomStatus = 'Arızalı';
      } else if (_cleanlinessStatus == false ||
          _coffeeStatus == false ||
          _teaStatus == false ||
          _toiletPaperStatus == false ||
          _towelStatus == false ||
          _waterStatus == false) {
        _roomStatus = 'Kirli';
      } else {
        _roomStatus = 'Temiz';
      }
    });
  }

  Future<void> addRoom() async {
    Map<String, dynamic> roomData = {
      'room_number': int.parse(_roomNumberController.text),
      'room_status': _roomStatus,
      'cleanliness_status': _cleanlinessStatus,
      'coffee_status': _coffeeStatus,
      'tea_status': _teaStatus,
      'toilet_paper_status': _toiletPaperStatus,
      'towel_status': _towelStatus,
      'water_status': _waterStatus,
      'has_issue': _hasIssue,
      'issue_note': _hasIssue == true ? _issueNoteController.text : '',
    };

    try {
      await _roomService.addRoom(roomData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Oda başarıyla eklendi')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  Widget buildDropdown<T>({
    required T? value,
    required String labelText,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged(newValue);
        _determineRoomStatus();  // Her seçimden sonra oda durumunu kontrol et
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yeni Oda Ekle'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Oda Numarası
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: _roomNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Oda Numarası',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              // Temizlik Durumu
              buildDropdown<bool>(
                value: _cleanlinessStatus,
                labelText: 'Temizlik Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _cleanlinessStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Kahve Durumu
              buildDropdown<bool>(
                value: _coffeeStatus,
                labelText: 'Kahve Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _coffeeStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Çay Durumu
              buildDropdown<bool>(
                value: _teaStatus,
                labelText: 'Çay Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _teaStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Tuvalet Kağıdı Durumu
              buildDropdown<bool>(
                value: _toiletPaperStatus,
                labelText: 'Tuvalet Kağıdı Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _toiletPaperStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Havlu Durumu
              buildDropdown<bool>(
                value: _towelStatus,
                labelText: 'Havlu Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _towelStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Su Durumu
              buildDropdown<bool>(
                value: _waterStatus,
                labelText: 'Su Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _waterStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Arıza Var mı?
              buildDropdown<bool>(
                value: _hasIssue,
                labelText: 'Sorun Var mı?',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _hasIssue = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Arıza Notu (only shown if issue exists)
              if (_hasIssue == true)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: _issueNoteController,
                    decoration: const InputDecoration(
                      labelText: 'Oda Notu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              // Oda Durumu
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Oda Durumu: ${_roomStatus ?? 'Belirlenmedi'}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Oda Ekle Button
              GestureDetector(
                onTap: addRoom,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: const Color(0xffC71585),
                  child: const Center(
                    child: Text(
                      'Oda Ekle',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
