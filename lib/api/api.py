import os
from google.cloud import firestore

# Ortam değişkenini ayarla (Firebase'den indirdiğiniz JSON dosyasının tam yolu)
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/Users/firat/MG HİLL OTEL/hotel/mg-hill-hotel-c10d4-firebase-adminsdk-fbsvc-cbec4be35e.json"

# Dosyanın mevcut olup olmadığını kontrol et
if not os.path.exists(os.environ["GOOGLE_APPLICATION_CREDENTIALS"]):
    print(f"Dosya bulunamadı: {os.environ['GOOGLE_APPLICATION_CREDENTIALS']}")
else:
    print("Dosya bulundu.")

# Firestore istemcisini başlat
try:
    db = firestore.Client()
    print("Firestore bağlantısı başarılı.")
except Exception as e:
    print(f"Firestore bağlantı hatası: {e}")

# Firestore'dan veri çekme örneği (örnek: 'contacts' koleksiyonundan veri çekmek)
def get_contacts():
    try:
        contacts_ref = db.collection('contacts').stream()
        for contact in contacts_ref:
            print(f'{contact.id} => {contact.to_dict()}')
    except Exception as e:
        print(f"Veri çekme hatası: {e}")

# Veri ekleme örneği (örnek: 'rooms' koleksiyonuna veri eklemek)
def add_room_data(cleanliness_status, coffee_status, room_number, room_status, tea_status, toilet_paper_status, towel_status, water_status):
    try:
        # Firestore koleksiyonuna veri ekleme
        room_ref = db.collection('contacts').add({
            'cleanliness_status': cleanliness_status,
            'coffee_status': coffee_status,
            'room_number': room_number,
            'room_status': room_status,
            'tea_status': tea_status,
            'toilet_paper_status': toilet_paper_status,
            'towel_status': towel_status,
            'water_status': water_status
        })
        print(f'Yeni oda verisi eklendi: Oda Numarası: {room_number}, Durum: {room_status}')
    except Exception as e:
        print(f"Veri ekleme hatası: {e}")

# Veri güncelleme örneği (örnek: 'contacts' koleksiyonunda güncelleme yapmak)
def update_contact(roomId, new_data):
    try:
        db.collection('contacts').document(roomId).update(new_data)
        print(f'{roomId} güncellendi.')
    except Exception as e:
        print(f"Veri güncelleme hatası: {e}")

# Veri silme örneği (örnek: 'contacts' koleksiyonundan veri silmek)
def delete_contact(roomId):
    try:
        db.collection('contacts').document(roomId).delete()
        print(f'{roomId} silindi.')
    except Exception as e:
        print(f"Veri silme hatası: {e}")

if __name__ == "__main__":
    get_contacts()
