# Otel Yönetim Sistemi 🏨

Bu proje, otel işletmeleri için oda durumlarını, temizlik süreçlerini ve personel kayıtlarını dijital ortamda takip etmeyi sağlayan kapsamlı bir mobil yönetim uygulamasıdır. **Flutter** ile geliştirilmiş olup, dinamik veri yönetimi için **Firebase** altyapısını kullanır.

## ✨ Özellikler

* **Oda Durum Takibi:** Odaların anlık olarak "Temiz", "Kirli", "Arızalı" veya "Dolu" olma durumlarını renk kodlarıyla görüntüleme.
* **Detaylı Oda Yönetimi:**
    * Yeni oda ekleme ve mevcut odaları silme.
    * Oda içindeki envanter takibi (Kahve, Çay, Havlu, Şampuan vb. eklendi bilgisi).
    * Arıza bildirimleri ve arıza notu ekleme özelliği.
* **Kara Liste (Blacklist) Modülü:** Belirli sebeplerle (gasp, terör bağlantısı vb.) kaydedilen personel veya kişilerin takibini yapma.
* **Filtreleme:** Odaları durumlarına göre kategorize ederek hızlı erişim sağlama.

## 🚀 Kullanılan Teknolojiler

* **Framework:** [Flutter](https://flutter.dev)
* **Backend/Database:** [Firebase](https://firebase.google.com) (Firestore & Auth)
* **Dil:** Dart

## 📁 Proje Yapısı

Uygulama mimarisi `lib` klasörü altında şu şekilde organize edilmiştir:

* `page/`: Uygulamanın tüm arayüz ekranları.
* `service/`: Firebase veri akışını ve iş mantığını yöneten servis dosyaları.
* `main.dart`: Uygulamanın başlangıç noktası.
* `firebase_options.dart`: Firebase yapılandırma ayarları.

## 🌐 Canlı Demo (Web)

Uygulamanın web sürümüne aşağıdaki bağlantıdan ulaşabilirsiniz:
https://mg-hill-hotel-c10d4.web.app/
