import 'package:flutter/material.dart';
import 'package:hotel/service/service.dart';

class AddRoom extends StatefulWidget {
  final fetchAndStatePage;
  const AddRoom({super.key, required this.fetchAndStatePage});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _roomNumberController = TextEditingController();
  final _issueNoteController = TextEditingController();
  String _roomStatus = 'Kirli';
  bool _cleanlinessStatus = false;
  bool _coffeeStatus = false;
  bool _teaStatus = false;
  bool _toiletPaperStatus = false;
  bool _towelStatus = false;
  bool _waterStatus = false;
  bool _hasIssue = false;
  bool _shampooStatus = false;
  bool _showerGelStatus = false;
  bool _laundryBagStatus = false;
  bool _earTruncheonStatus = false;
  bool _soapStatus = false;
  bool _fullStatus = false;

  final RoomService _roomService = RoomService();

  void _determineRoomStatus() {
    setState(() {
      if (_hasIssue == true) {
        _roomStatus = 'Arızalı';
      } else if (_cleanlinessStatus == false ||
          _coffeeStatus == false ||
          _teaStatus == false ||
          _toiletPaperStatus == false ||
          _towelStatus == false ||
          _waterStatus == false ||
          _shampooStatus == false ||
          _showerGelStatus == false ||
          _laundryBagStatus == false ||
          _earTruncheonStatus == false ||
          _soapStatus == false) {
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
      'shampoo_status': _shampooStatus,
      'shower_gel_status': _showerGelStatus,
      'laundry_bag_status': _laundryBagStatus,
      'ear_truncheon_status': _earTruncheonStatus,
      'soap_status': _soapStatus,
      'has_Issue': _hasIssue,
      'issue_note': _hasIssue == true ? _issueNoteController.text : '',
      'full_status': _fullStatus,
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
    required T value,
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
        onChanged(newValue ?? false as T);
        _determineRoomStatus();
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

              buildDropdown<bool>(
                value: _cleanlinessStatus,
                labelText: 'Temizlik Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _cleanlinessStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _coffeeStatus,
                labelText: 'Kahve Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _coffeeStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _teaStatus,
                labelText: 'Çay Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _teaStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _toiletPaperStatus,
                labelText: 'Tuvalet Kağıdı Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _toiletPaperStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _towelStatus,
                labelText: 'Havlu Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _towelStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _waterStatus,
                labelText: 'Su Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _waterStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _shampooStatus,
                labelText: 'Şampuan Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _shampooStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _showerGelStatus,
                labelText: 'Duş Jeli Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _showerGelStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _laundryBagStatus,
                labelText: 'Çamaşır Torbası Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _laundryBagStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _earTruncheonStatus,
                labelText: 'Kulak Pamuğu Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _earTruncheonStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _soapStatus,
                labelText: 'Sabun Durumu',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _soapStatus = newValue ?? false;
                  });
                },
              ),

              const SizedBox(height: 16.0),
              buildDropdown<bool>(
                value: _fullStatus,
                labelText: 'Oda Dolu mu?',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _fullStatus = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              buildDropdown<bool>(
                value: _hasIssue,
                labelText: 'Sorun Var mı?',
                items: [true, false],
                onChanged: (newValue) {
                  setState(() {
                    _hasIssue = newValue ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              if (_hasIssue == true)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: _issueNoteController,
                    decoration: const InputDecoration(
                      labelText: 'Arıza Notu',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ),

              ElevatedButton(
                onPressed: () {
                  addRoom();
                  widget.fetchAndStatePage();
                },
                child: const Text('Oda Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
