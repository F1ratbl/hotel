import 'package:cloud_firestore/cloud_firestore.dart';

class BlacklistService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // GET
  Future<List<Map<String, dynamic>>> getBlacklist() async {
    try {
      QuerySnapshot snapshot = await _db.collection('blackList').get();
      List<Map<String, dynamic>> blacklist = snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      }).toList();
      return blacklist;
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }

  // POST
  Future<void> addToBlacklist(Map<String, dynamic> personData) async {
    try {
      await _db.collection('blackList').add(personData);
    } catch (e) {
      print('Hata: $e');
    }
  }

  // PUT
  Future<void> updateBlacklist(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection('blackList').doc(docId).update(updatedData);
      print('Belge başarıyla güncellendi.');
    } catch (e) {
      print('Hata: $e');
    }
  }

  // DELETE
  Future<void> deleteFromBlacklist(String docId) async {
    try {
      await _db.collection('blackList').doc(docId).delete();
    } catch (e) {
      print('Hata: $e');
    }
  }
}
