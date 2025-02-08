import 'package:flutter/material.dart';
import 'package:hotel/service/service.dart';

class RoomInfo extends StatefulWidget {
  final int roomNumber;
  final fetchAndStatePage;
  final String roomStatus;
  late final String issueNote;
  bool hasIssue;
  bool cleanlinessStatus;
  bool coffeeStatus;
  bool teaStatus;
  bool toiletPaperStatus;
  bool towelStatus;
  bool waterStatus;
  bool earTruncheonStatus;
  bool laundryBagStatus;
  bool shampooStatus;
  bool showerGelStatus;
  bool soapStatus;
  bool fullStatus;

  RoomInfo({
    super.key,
    required this.roomNumber,
    required this.fetchAndStatePage,
    required this.roomStatus,
    required this.issueNote,
    required this.hasIssue,
    required this.cleanlinessStatus,
    required this.coffeeStatus,
    required this.teaStatus,
    required this.toiletPaperStatus,
    required this.towelStatus,
    required this.waterStatus,
    required this.earTruncheonStatus,
    required this.laundryBagStatus,
    required this.shampooStatus,
    required this.showerGelStatus,
    required this.soapStatus,
    required this.fullStatus,
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
    bool sampuanDurum = widget.shampooStatus;
    bool dusJeliDurum = widget.showerGelStatus;
    bool sabunDurum = widget.soapStatus;
    bool camasirPosetiDurum = widget.laundryBagStatus;
    bool kulakCopuDurum = widget.earTruncheonStatus;
    bool doluOda = widget.fullStatus;
    Color statusColor;

    if (widget.roomStatus == 'Arızalı') {
      statusColor = const Color(0xffC21807);
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
        body: SingleChildScrollView(
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

              _buildCheckBox('Oda Dolu', doluOda, (value) {
                setState(() {
                  widget.fullStatus = value ?? false;
                });
              }),
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
                  widget.waterStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Şampuan Eklendi', sampuanDurum, (value) {
                setState(() {
                  widget.shampooStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Duş Jeli Eklendi', dusJeliDurum, (value) {
                setState(() {
                  widget.showerGelStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Kulak Çöpü Eklendi', kulakCopuDurum, (value) {
                setState(() {
                  widget.earTruncheonStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Çamaşır Poşeti Eklendi', camasirPosetiDurum, (value) {
                setState(() {
                  widget.laundryBagStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Sabun Eklendi', sabunDurum, (value) {
                setState(() {
                  widget.soapStatus = value ?? false;
                  ;
                });
              }),
              _buildCheckBox('Arıza Var', arizaDurum, (value) {
                setState(() {
                  widget.hasIssue = value ?? false;
                });
              }),

              if (arizaDurum) _buildIssueNoteField(),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _infoButton(
                    'Güncelle',
                    temizlikDurum,
                    kahveDurum,
                    cayDurum,
                    tuvaletKagidiDurum,
                    havluDurum,
                    suDurum,
                    sampuanDurum,
                    dusJeliDurum,
                    sabunDurum,
                    camasirPosetiDurum,
                    kulakCopuDurum,
                    arizaDurum,
                    doluOda,
                    arizaNotu,
                    odaDurum,
                    statusColor),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _infoButton(
                    'Odayı Sil',
                    temizlikDurum,
                    kahveDurum,
                    cayDurum,
                    tuvaletKagidiDurum,
                    havluDurum,
                    suDurum,
                    sampuanDurum,
                    dusJeliDurum,
                    sabunDurum,
                    camasirPosetiDurum,
                    kulakCopuDurum,
                    arizaDurum,
                    doluOda,
                    arizaNotu,
                    odaDurum,
                    statusColor),
              )
            ],
          ),
        ),
      ),
    );
  }

GestureDetector _infoButton(
  String text,
  bool temizlikDurum,
  bool kahveDurum,
  bool cayDurum,
  bool tuvaletKagidiDurum,
  bool havluDurum,
  bool suDurum,
  bool sampuanDurum,
  bool dusJeliDurum,
  bool sabunDurum,
  bool camasirPosetiDurum,
  bool kulakCopuDurum,
  bool arizaDurum,
  bool doluOda,
  String arizaNotu,
  String odaDurum,
  Color statusColor,
) {
  return GestureDetector(
    onTap: () {
      if (text == 'Güncelle') {
        _updateRoomInfo(
          temizlikDurum,
          kahveDurum,
          cayDurum,
          tuvaletKagidiDurum,
          havluDurum,
          suDurum,
          sampuanDurum,
          dusJeliDurum,
          sabunDurum,
          camasirPosetiDurum,
          kulakCopuDurum,
          arizaDurum,
          doluOda,
          arizaNotu,
          odaDurum,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Başarıyla güncellendi')),
        );
      } else {
        _service.deleteRoomByNumber(widget.roomNumber);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Başarıyla silindi')),
        );
      }

      widget.fetchAndStatePage();
      Navigator.pop(context);
    },
    child: Container(
      height: 50,
      width: double.infinity,
      color: statusColor,
      child: Center(
        child: Text(
          text,
          style: statusStyle(),
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
      onChanged: onChanged,
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
  Future<void> _updateRoomInfo(
      bool temizlikDurum,
      bool kahveDurum,
      bool cayDurum,
      bool tuvaletKagidiDurum,
      bool havluDurum,
      bool suDurum,
      bool sampuanDurum,
      bool dusJeliDurum,
      bool sabunDurum,
      bool camasirPosetiDurum,
      bool kulakCopuDurum,
      bool arizaDurum,
      bool doluOda,
      String arizaNotu,
      String odaDurum) async {
    if (doluOda) {
      odaDurum = 'Dolu';
    }
    else if (!temizlikDurum ||
        !kahveDurum ||
        !cayDurum ||
        !tuvaletKagidiDurum ||
        !havluDurum ||
        !suDurum ||
        !sampuanDurum ||
        !sabunDurum ||
        !camasirPosetiDurum ||
        !dusJeliDurum ||
        !kulakCopuDurum) {
      odaDurum = 'Kirli';
    }
    else {
      odaDurum = 'Temiz';
    }

    Map<String, dynamic> updatedData = {
      'cleanliness_status': temizlikDurum,
      'coffee_status': kahveDurum,
      'tea_status': cayDurum,
      'toilet_paper_status': tuvaletKagidiDurum,
      'towel_status': havluDurum,
      'water_status': suDurum,
      'shampoo_status': sampuanDurum,
      'shower_gel_status': dusJeliDurum,
      'soap_status': sabunDurum,
      'laundry_bag_status': camasirPosetiDurum,
      'ear_truncheon_status': kulakCopuDurum,
      'has_Issue': arizaDurum,
      'issue_note': arizaNotu,
      'room_status': odaDurum,
      'full_status': doluOda,
    };

    String roomNum = '${widget.roomNumber}';
    await _service.updateRoom(int.parse(roomNum), updatedData);
  }

  TextStyle statusStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
  }
}
