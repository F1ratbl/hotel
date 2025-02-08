import 'package:flutter/material.dart';
import 'package:hotel/page/add_room.dart';
import 'package:hotel/page/black_list.dart';
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

  void fetchAndStatePage() async {
    await fetchRooms();
    setState(() {});
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          fetchRooms();
          setState(() {});
        },
        child: Column(
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: _button(context, phoneWidth  ,'+ Yeni Oda Ekle', Color(0xffC71585), () => AddRoom(fetchAndStatePage: fetchAndStatePage,)),
                ),
                Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _button(context, phoneWidth,'Kara Liste',Color(0xff2B2929), () => DarkList(fetchAndStatePage: fetchAndStatePage)),
            ),
              ],
            ),
            
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _tabBarBuilder(phoneWidth, 'all'),
                  _tabBarBuilder(phoneWidth, 'Temiz'),
                  _tabBarBuilder(phoneWidth, 'Kirli'),
                  _tabBarBuilder(phoneWidth, 'Arızalı'),
                  _tabBarBuilder(phoneWidth, 'Dolu'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _button(BuildContext context,double phoneWidth, String tittle , Color color, Widget Function() page) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page()),
                  );
                },
                child: Container(
                  height: 50,
                  width: phoneWidth / 2,
                  color: color,
                  child: Center(
                    child: Text(
                      tittle,
                      style: _sectionTextStyle(),
                    ),
                  ),
                ),
              );
  }

  Widget _tabBarBuilder(double phoneWidth, String status) {
    List<dynamic> filteredList;
    if (status == 'all') {
      filteredList = dataList;
    } else if (status == 'Arızalı') {
      filteredList = dataList.where((room) => room['has_Issue'] == true).toList();
    } else {
      filteredList = dataList.where((room) => room['room_status'] == status).toList();
    }

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
          earTruncheonStatus: filteredList[index]['ear_truncheon_status'],
          laundryBagStatus : filteredList[index]['laundry_bag_status'],
          shampooStatus : filteredList[index]['shampoo_status'],
          showerGelStatus : filteredList[index]['shower_gel_status'],
          soapStatus : filteredList[index]['soap_status'],
          fullStatus : filteredList[index]['full_status'],
          fetchAndStatePage : fetchAndStatePage,
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
  final bool earTruncheonStatus;
  final bool laundryBagStatus;
  final bool shampooStatus;
  final bool showerGelStatus;
  final bool soapStatus;
  final bool fullStatus;
  final Function fetchAndStatePage;

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
    required this.earTruncheonStatus,
    required this.laundryBagStatus,
    required this.shampooStatus,
    required this.showerGelStatus,
    required this.soapStatus,
    required this.fullStatus,
    required this.fetchAndStatePage,
  });

  @override
  Widget build(BuildContext context) {
    Color roomColor;
    if (roomStatus == 'Arızalı') {
      roomColor = const Color(0xffC21807);
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
              fetchAndStatePage: fetchAndStatePage,
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
              earTruncheonStatus : earTruncheonStatus,
              laundryBagStatus : laundryBagStatus,
              shampooStatus : shampooStatus,
              showerGelStatus : showerGelStatus,
              soapStatus : soapStatus,
              fullStatus: fullStatus,
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

            if (hasIssue == true) ...[
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
