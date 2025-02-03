import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // GET: Tüm odaların listesini çekme
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

  // POST: Yeni oda ekleme
  Future<void> addRoom(Map<String, dynamic> roomData) async {
    try {
      await _db.collection('contacts').add(roomData);
    } catch (e) {
      print('Hata: $e');
    }
  }

// PUT: Oda güncelleme (belirli bir dokümanı güncelleme)
Future<void> updateRoom(int roomNum, Map<String, dynamic> updatedData) async {
  try {
    // Oda numarasına göre belgeyi arayın
    QuerySnapshot querySnapshot = await _db
        .collection('contacts')
        .where('room_number', isEqualTo: roomNum)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Belgeyi güncelleyin
      await querySnapshot.docs.first.reference.update(updatedData);
      print('Belge başarıyla güncellendi.');
    } else {
      print('Hata: Belge bulunamadı.');
    }
  } catch (e) {
    print('Hata: $e');
  }
}

  // DELETE: Oda silme
  Future<void> deleteRoom(String docId) async {
    try {
      await _db.collection('contacts').doc(docId).delete();
    } catch (e) {
      print('Hata: $e');
    }
  }
}
