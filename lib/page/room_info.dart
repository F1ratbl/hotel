import 'package:flutter/material.dart';
import 'package:hotel/service/service.dart';

class RoomInfo extends StatefulWidget {
  final int roomNumber;
  final String roomStatus;
  late final String issueNote;
  bool hasIssue;
  bool cleanlinessStatus;
  bool coffeeStatus;
  bool teaStatus;
  bool toiletPaperStatus;
  bool towelStatus;
  bool waterStatus;

  RoomInfo({
    super.key,
    required this.roomNumber,
    required this.roomStatus,
    required this.issueNote,
    required this.hasIssue,
    required this.cleanlinessStatus,
    required this.coffeeStatus,
    required this.teaStatus,
    required this.toiletPaperStatus,
    required this.towelStatus,
    required this.waterStatus,
  });

  @override
  State<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  final RoomService _service = RoomService();

  @override
  Widget build(BuildContext context) {
    String odaDurum = widget.roomStatus;
    String arizaNotu = widget.issueNote;
    bool arizaDurum = widget.hasIssue;
    bool temizlikDurum = widget.cleanlinessStatus;
    bool kahveDurum = widget.coffeeStatus;
    bool cayDurum = widget.teaStatus;
    bool tuvaletKagidiDurum = widget.toiletPaperStatus;
    bool havluDurum = widget.towelStatus;
    bool suDurum = widget.waterStatus;
    Color statusColor;

    if (widget.roomStatus == 'Arızalı') {
      statusColor = const Color(0xff63C5DA);
    } else if (widget.roomStatus == 'Kirli') {
      statusColor = const Color(0xffC21807);
    } else if (widget.roomStatus == 'Temiz') {
      statusColor = const Color(0xff03C04A);
    } else {
      statusColor = const Color(0xffFFA600);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff4B0150),
          title: Text('Oda No: ${widget.roomNumber}', style: statusStyle()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: statusColor,
                width: double.infinity,
                height: 100,
                child: Center(
                  child: Text(
                    widget.roomStatus.isNotEmpty ? widget.roomStatus : 'Durum Bilinmiyor',
                    style: statusStyle(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Checkbox'lar
              _buildCheckBox('Oda Temizlendi', temizlikDurum, (value) {
                setState(() {
                  widget.cleanlinessStatus = value ?? false;
                });
              }),
              _buildCheckBox('Kahve Eklendi', kahveDurum, (value) {
                setState(() {
                  widget.coffeeStatus = value ?? false;
                });
              }),
              _buildCheckBox('Çay Eklendi', cayDurum, (value) {
                setState(() {
                  widget.teaStatus = value ?? false;
                });
              }),
              _buildCheckBox('Tuvalet Kağıdı Eklendi', tuvaletKagidiDurum, (value) {
                setState(() {
                  widget.toiletPaperStatus = value ?? false;
                });
              }),
              _buildCheckBox('Havlular Değiştirildi', havluDurum, (value) {
                setState(() {
                  widget.towelStatus = value ?? false;
                });
              }),
              _buildCheckBox('Su Eklendi', suDurum, (value) {
                setState(() {
                  widget.waterStatus = !widget.waterStatus;
                });
              }),
              _buildCheckBox('Arıza Var', arizaDurum, (value) {
                setState(() {
                  widget.hasIssue = value ?? false;
                });
              }),

              if (arizaDurum) _buildIssueNoteField(),

              const SizedBox(height: 20),

              // Güncelleme Butonu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    // Veritabanı güncelleme işlemi
                    _updateRoomInfo(temizlikDurum, kahveDurum, cayDurum, tuvaletKagidiDurum, havluDurum, suDurum,
                        arizaDurum, arizaNotu, odaDurum);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: statusColor,
                    child: Center(
                      child: Text(
                        'Güncelle',
                        style: statusStyle(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Checkbox bileşeni
  Widget _buildCheckBox(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged, // value'ya göre aktif/pasif olacak ve güncellenecek
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  // Arıza notu girme alanı
  Widget _buildIssueNoteField() {
    return TextField(
      controller: TextEditingController(text: widget.issueNote),
      decoration: const InputDecoration(
        labelText: 'Arıza Notu',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          widget.issueNote = value;
          widget.hasIssue = value.isNotEmpty;
        });
      },
    );
  }

// Veritabanı güncelleme işlemi
  Future<void> _updateRoomInfo(bool temizlikDurum, bool kahveDurum, bool cayDurum, bool tuvaletKagidiDurum,
      bool havluDurum, bool suDurum, bool arizaDurum, String arizaNotu, String odaDurum) async {
    if (arizaDurum == true) {
      odaDurum = 'Arızalı';
    } else if (temizlikDurum == true ||
        kahveDurum == true ||
        cayDurum == true ||
        tuvaletKagidiDurum == true ||
        havluDurum == true ||
        suDurum == true) {
      odaDurum = 'Temiz';
    } else {
      odaDurum = 'Kirli';
    }

    Map<String, dynamic> updatedData = {
      'cleanliness_status': temizlikDurum,
      'coffee_status': kahveDurum,
      'tea_status': cayDurum,
      'toilet_paper_status': tuvaletKagidiDurum,
      'towel_status': havluDurum,
      'water_status': suDurum,
      'has_issue': arizaDurum,
      'issue_note': arizaNotu,
      'room_status': odaDurum,
    };

    // room_number alanına göre güncelleme yapın
    String roomNum = '${widget.roomNumber}';

    // Servisi kullanarak güncelleme yapın
    await _service.updateRoom(int.parse(roomNum), updatedData);
  }

  // Yazı stili
  TextStyle statusStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
  }
}
