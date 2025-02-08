import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // GET
  Future<List<Map<String, dynamic>>> getRooms() async {
    try {
      QuerySnapshot snapshot = await _db.collection('contacts').get();
      List<Map<String, dynamic>> rooms = snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      }).toList();
      return rooms;
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }

  // POST
  Future<void> addRoom(Map<String, dynamic> roomData) async {
    try {
      await _db.collection('contacts').add(roomData);
    } catch (e) {
      print('Hata: $e');
    }
  }

// PUT
Future<void> updateRoom(int roomNum, Map<String, dynamic> updatedData) async {
  try {
    QuerySnapshot querySnapshot = await _db
        .collection('contacts')
        .where('room_number', isEqualTo: roomNum)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update(updatedData);
    } else {
      print('Hata: Belge bulunamadı.');
    }
  } catch (e) {
    print('Hata: $e');
  }
  
}
// DELETE
Future<void> deleteRoomByNumber(int roomNumber) async {
  try {
    var querySnapshot = await _db.collection('contacts')
        .where('room_number', isEqualTo: roomNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        await _db.collection('contacts').doc(doc.id).delete();
      }
    } else {
      print('Oda bulunamadı');
    }
  } catch (e) {
    print('Hata: $e');
  }
}

}
