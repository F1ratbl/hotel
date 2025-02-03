import 'package:flutter/material.dart';
import 'package:hotel/page/add_room.dart';
import 'package:hotel/page/room_info.dart';
import 'package:hotel/service/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> dataList = [];
  bool isLoading = true;
  RoomService _roomService = RoomService();

  Future<void> fetchRooms() async {
    try {
      final data = await _roomService.getRooms();
      print("Gelen veri: $data");

      // Veriyi room_number'a göre sıralama işlemi
      data.sort((a, b) => a['room_number'].compareTo(b['room_number']));

      setState(() {
        dataList = data;
        isLoading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRooms();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width - 48;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: const Color(0xff4B0150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    _tabButton(context, 'Odalar'),
                    _tabButton(context, 'Temiz'),
                    _tabButton(context, 'Kirli'),
                    _tabButton(context, 'Arızalı'),
                    _tabButton(context, 'Dolu'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRoom()),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Color(0xffC71585),
                child: Center(
                  child: Text(
                    '+ Yeni Oda Ekle',
                    style: _sectionTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _tabBarBuilder(phoneWidth, 'all'), // Tüm odalar
                _tabBarBuilder(phoneWidth, 'Temiz'), // Temiz odalar
                _tabBarBuilder(phoneWidth, 'Kirli'), // Kirli odalar
                _tabBarBuilder(phoneWidth, 'Arızalı'), // Arızalı odalar
                _tabBarBuilder(phoneWidth, 'Dolu'), // Dolu odalar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarBuilder(double phoneWidth, String status) {
    // Tüm odalar gösterildiğinde filtreleme yapma
    List<dynamic> filteredList =
        (status == 'all') ? dataList : dataList.where((room) => room['room_status'] == status).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return _Card(
          width: phoneWidth / 2,
          roomNumber: filteredList[index]['room_number'],
          roomStatus: filteredList[index]['room_status'],
          issueNote: filteredList[index]['issue_note'],
          hasIssue: filteredList[index]['has_Issue'],
          cleanlinessStatus: filteredList[index]['cleanliness_status'],
          coffeeStatus: filteredList[index]['coffee_status'],
          teaStatus: filteredList[index]['tea_status'],
          toiletPaperStatus: filteredList[index]['toilet_paper_status'],
          towelStatus: filteredList[index]['towel_status'],
          waterStatus: filteredList[index]['water_status'],
        );
      },
    );
  }

  Tab _tabButton(BuildContext context, String buttonText) {
    return Tab(
      child: Container(
        height: MediaQuery.of(context).size.width / 3,
        alignment: Alignment.center,
        child: Text(buttonText, style: _sectionTextStyle()),
      ),
    );
  }

  TextStyle _sectionTextStyle() {
    return const TextStyle(
      color: Colors.white,
      fontFamily: 'IBMPlexSansCondensed',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 17.22 / 14,
      decoration: TextDecoration.none,
    );
  }
}

class _Card extends StatelessWidget {
  final double width;
  final dynamic roomNumber;
  final dynamic roomStatus;
  final String issueNote;
  final bool hasIssue;
  final bool cleanlinessStatus;
  final bool coffeeStatus;
  final bool teaStatus;
  final bool toiletPaperStatus;
  final bool towelStatus;
  final bool waterStatus;

  const _Card({
    super.key,
    required this.width,
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
  Widget build(BuildContext context) {
    // Renk belirleme işlemini burada yapıyoruz
    Color roomColor;
    if (roomStatus == 'Arızalı') {
      roomColor = const Color(0xff63C5DA);
    } else if (roomStatus == 'Kirli') {
      roomColor = const Color(0xffC21807);
    } else if (roomStatus == 'Temiz') {
      roomColor = const Color(0xff03C04A);
    } else {
      roomColor = const Color(0xffFFA600);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomInfo(
              roomNumber: roomNumber,
              roomStatus: roomStatus,
              issueNote: issueNote,
              hasIssue: hasIssue,
              cleanlinessStatus: cleanlinessStatus,
              coffeeStatus: coffeeStatus,
              teaStatus: teaStatus,
              toiletPaperStatus: toiletPaperStatus,
              towelStatus: towelStatus,
              waterStatus: waterStatus,
            ),
          ),
        );
      },
      child: Container(
        width: width,
        color: roomColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oda No: $roomNumber',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Text(
              roomStatus.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            if (roomStatus == 'Arızalı') ...[
              const SizedBox(height: 8.0),
              Icon(
                Icons.notifications_active,
                color: Colors.yellow,
                size: 30,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
