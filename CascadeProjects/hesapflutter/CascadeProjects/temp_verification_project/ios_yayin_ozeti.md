# iOS Yayınlama Süreci - Durum Özeti (30 Nisan 2026)

Bu dosya, sohbetin kesilmesi durumunda kalınan yeri hatırlatmak için oluşturulmuştur.

## Yapılan İşlemler
1.  **Firebase:** iOS uygulaması eklendi, `GoogleService-Info.plist` dosyası `ios/Runner` altına yerleştirildi. `firebase_options.dart` dosyası iOS destekleyecek şekilde güncellendi.
2.  **RevenueCat:** App Store API anahtarı (`appl_CtVJryAlpS8XjmaIYxujKgqQLESK`) koda işlendi.
3.  **AdMob:** iOS App ID (`ca-app-pub-9358975861980527~3254291864`) ve reklam birimi kimlikleri (Interstitial ve Rewarded) koda eklendi.
4.  **Xcode Yapılandırması:** Paket adı (`com.botlab.calculator`) ve gerekli izinler (Kamera, Fotoğraf, Takip vb.) `Info.plist` ve `project.pbxproj` dosyalarına işlendi.

## Kalınan Yer
- Tüm teknik kodlama ve konfigürasyon tamamlandı.
- Sırada: Kodun GitHub'a yüklenmesi ve Codemagic bağlantısının yapılması var.

## Notlar
- Firebase Proje ID: `revenuecat-anahtar`
- Bundle ID: `com.botlab.calculator`
