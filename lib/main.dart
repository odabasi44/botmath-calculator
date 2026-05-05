import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui';
import 'services/ai_service.dart';
import 'services/ai_history_service.dart';
import 'services/pdf_service.dart';
import 'screens/ai_history_screen.dart';
import 'screens/premium_offer_screen.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/calculator_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'firebase_options.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AppTranslations {
  static const Map<String, Map<String, String>> all = {
    'TR': {
      'title': 'Hesap Makinası',
      'basic_mode': 'Basit Mod',
      'scientific_mode': 'Bilimsel Mod',
      'history': 'Geçmiş',
      'no_internet': 'İnternet bağlantısı bulunamadı',
      'settings': 'Ayarlar',
      'about': 'Hakkında',
      'clear_history': 'Geçmişi Temizle',
      'no_history': 'Geçmiş bulunmamaktadır',
      'close': 'Kapat',
      'language': 'Dil',
      'select_language': 'Dil Seçin',
      'premium_purchase': 'Premium Satın Al',
      'get_premium': 'Premium Al',
      'premium_features': 'Premium Özellikler',
      'premium_desc': 'Premium ile daha fazla özellik kazandır!',
      'ad_free': 'Reklamsız deneyim',
      'custom_themes': 'Özel temalar',
      'advanced_functions': 'Gelişmiş fonksiyonlar',
      'unlimited_history': 'Sınırsız geçmiş',
      'purchase_premium': 'Premium Satın Al',
      'restore_purchase': 'Satın Alma Geri Yükle',
      'cancel': 'İptal',
      'engineering_functions': 'Mühendislik Fonksiyonları',
      'constants': 'Sabitler',
      'power': 'Üs',
      'square_root': 'Karekök',
      'cube_root': 'Küpkök',
      'factorial': 'Faktöriyel',
      'logarithm': 'Logarithma',
      'natural_log': 'Doğal Log',
      'sine': 'Sinüs',
      'cosine': 'Kosinüs',
      'tangent': 'Tanjant',
      'euler': 'Euler Sabiti',
      'pi': 'Pi Sabiti',
      'golden_ratio': 'Altın Oran',
      'share_app': 'Uygulamayı Paylaş',
      'rate_app': 'Uygulamayı Oyla',
      'theme': 'Tema',
      'dark_theme': 'Koyu Tema',
      'vibration': 'Titreşim',
      'sound_effects': 'Ses Efektleri',
      'auto_save_history': 'Geçmişi Otomatik Kaydet',
      'decimal_places': 'Ondalık Basamak Sayısı',
      'about_app': 'Uygulama Hakkında',
      'about_desc': 'BOTLAB Hesap Makinası, modern ve kullanıcı dostu bir hesap makinesi uygulamasıdır. Hem temel hem de bilimsel hesaplamalar için tasarlanmıştır.',
      'ai_solver': 'AI Çözücü (Premium)',
      'ai_desc': 'Matematik probleminin fotoğrafını çekin, yapay zeka çözsün!',
      'take_photo': 'Fotoğraf Çek',
      'pick_gallery': 'Galeriden Seç',
      'solving': 'Çözülüyor...',
      'solution': 'AI Çözümü',
      'premium_required': 'Bu özellik için Premium üyelik gereklidir.',
      'unlock_premium': 'Premium Kilidi Aç',
      'tools': 'Araçlar',
      'unit_converter': 'Birim Çevirici',
      'programmer': 'Yazılımcı Modu',
      'geometry': 'Geometri',
      'finance': 'Finans',
      'length': 'Uzunluk',
      'weight': 'Ağırlık',
      'temperature': 'Sıcaklık',
      'convert': 'Çevir',
      'shape': 'Şekil',
      'radius': 'Yarıçap',
      'width': 'Genişlik',
      'height': 'Yükseklik',
      'base': 'Taban',
      'calculate': 'Hesapla',
      'area': 'Alan',
      'circumference': 'Çevre (Daire)',
      'perimeter': 'Çevre',
      'principal': 'Ana Para',
      'rate': 'Faiz Oranı (%)',
      'duration': 'Süre (Yıl)',
      'loan': 'Kredi',
      'savings': 'Birikim',
      'monthly_payment': 'Aylık Ödeme',
      'total_payment': 'Toplam Ödeme',
      'total_interest': 'Toplam Faiz',
      'total_amount': 'Toplam Tutar',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Ücretsiz AI Hakkı',
      'ai_freemium_desc': 'Premium üye değilsiniz ancak {0} ücretsiz hakkınız kaldı.',
      'ai_no_credits': 'Ücretsiz haklarınız bitti. Devam etmek için Premium alın.',
      'try_free': 'Ücretsiz Dene',
      'version': 'Sürüm',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Yapay zeka ve mobil uygulama geliştirme konusunda uzmanlaşmış teknoloji şirketi.',
      'guide_title': 'Kullanım Kılavuzu',
      'guide_mod_title': 'SHIFT ve ALPHA Modları',
      'guide_mod_desc': 'Tuşların üstünde veya sağında bulunan ikinci/üçüncü işlevleri kullanmak için önce ilgili SHIFT veya ALPHA tuşuna basın. Mod aktif olduğunda sol üst köşede [S] veya [A] ibaresi çıkacaktır.',
      'guide_nav_title': 'Navigasyon Tuşları (Oklar)',
      'guide_nav_desc': 'Hesap makinesinin ortasındaki Yukarı/Aşağı oklarını kullanarak geçmişte yaptığınız (History) son hesaplamalara hızlıca gidebilirsiniz. Sol ok ile son karakteri silebilirsiniz.',
      'guide_integral_title': 'İntegral Hesaplama',
      'guide_integral_desc': '1. Ekrandaki ∫ tuşuna basın.\n2. Ekrana ∫( gelecektir.\n3. Fonksiyonu, alt sınırı ve üst sınırı virgül ( , ) ile ayırarak yazın.\n\nÖrnek: ∫(cos(x),0,1.57)\n\nSonucu almak için eşittir (=) tuşuna basın!',
      'guide_ai_title': 'Yapay Zeka (AI) Çözücü',
      'guide_ai_desc': 'Menüden AI Çözücüye girerek fotoğraftaki karmaşık işlemleri çözdürebilirsiniz. Başlangıç olarak hesabınızda 2 ücretsiz kredi bulunmaktadır. Eğer günde 100 işlem kapasitesine çıkmak isterseniz "Premium Satın Al" butonu üzerinden yükseltme yapabilirsiniz.',
      'share_message': 'Hesap Makinesi: Yapay Zeka ile matematik problemlerinizi anında çözün! İndirin: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Güncelleme Gerekli',
      'update_desc': 'Uygulamanın yeni bir sürümü mevcut. Devam etmek için lütfen güncelleyin.',
      'update_button': 'Şimdi Güncelle',
      'age_calc': 'Yaş Hesaplama',
      'bmi_calc': 'VKI Hesaplama',
      'discount_calc': 'İndirim Hesaplama',
      'tip_calc': 'Bahşiş Hesaplama',
      'calculate_btn': 'Hesapla',
      'app_title': 'BotMath Hesap Makinesi',
      'solve': 'Çöz',
      'ai_history': 'AI Geçmişi',
      'share': 'Paylaş',
      'view_btn': 'Görüntüle',
      'no_ai_history': 'Henüz AI geçmişi yok',
      'free_credits': 'Ücretsiz Hak: {0}',
      'ai_credits_rewarded': 'Tebrikler! +2 AI Kredisi kazandınız.',
      'daily_limit_renews': 'Her gece 00:00\'da 100 hak yenilenir.',
      'premium_history_desc': 'Daha fazla geçmiş görmek için Premium al!',
      'view_premium_packages': 'Premium Paketleri İncele',
      'share_ai_message': 'Bu soru BotMath Hesap Makinası ile çözüldü. Siz de uygulamayı edinmek isterseniz tıklayınız: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Tüm Geçmişi Aç',
      'birth_date': 'Doğum Tarihi',
      'select_birth_date': 'Doğum Tarihi Seçin',
      'height_cm': 'Boy (cm)',
      'weight_kg': 'Kilo (kg)',
      'bmi_label': 'VKI',
      'status_label': 'Durum',
      'price_label': 'Etiket Fiyatı',
      'discount_percent': 'İndirim Oranı (%)',
      'final_price': 'Son Fiyat',
      'savings_label': 'Kazancınız',
      'bill_amount': 'Hesap Tutarı',
      'tip_percent': 'Bahşiş Oranı (%)',
      'people_count': 'Kişi Sayısı',
      'total_tip': 'Toplam Bahşiş',
      'per_person': 'Kişi Başı Toplam',
      'credits_label': 'Kredi',
      'watch_ad_btn': 'Reklam İzle (+2 Kredi)',
      'tool_credits_summary': 'Ücretsiz Araç Kredileriniz: {0} / {1}',
      'premium_offer_title': '3 GÜN ÜCRETSİZ DENE',
      'premium_offer_subtitle': 'Tüm Özelliklerin Kilidini Aç',
      'premium_offer_trial_info': '3 gün ücretsiz, sonra {0}/ay. İstediğin zaman iptal et.',
      'start_free_trial': 'ÜCRETSİZ DENEMEYİ BAŞLAT',
      'premium_offer_features_title': 'Neler Kazanırsınız?',
      'premium_offer_footer': 'Devam ederek Kullanım Koşulları ve Gizlilik Politikası\'nı kabul etmiş olursunuz.',
    },
    'EN': {
      'title': 'Calculator',
      'basic_mode': 'Basic Mode',
      'scientific_mode': 'Scientific Mode',
      'history': 'History',
      'no_internet': 'Internet connection not found',
      'settings': 'Settings',
      'about': 'About',
      'clear_history': 'Clear History',
      'no_history': 'No history available',
      'close': 'Close',
      'language': 'Language',
      'select_language': 'Select Language',
      'premium_purchase': 'Buy Premium',
      'get_premium': 'Get Premium',
      'premium_features': 'Premium Features',
      'premium_desc': 'Get more features with Premium!',
      'ad_free': 'Ad-free experience',
      'custom_themes': 'Custom themes',
      'advanced_functions': 'Advanced functions',
      'unlimited_history': 'Unlimited history',
      'purchase_premium': 'Purchase Premium',
      'restore_purchase': 'Restore Purchase',
      'cancel': 'Cancel',
      'engineering_functions': 'Engineering Functions',
      'constants': 'Constants',
      'power': 'Power',
      'square_root': 'Square Root',
      'cube_root': 'Cube Root',
      'factorial': 'Factorial',
      'logarithm': 'Logarithm',
      'natural_log': 'Natural Log',
      'sine': 'Sine',
      'cosine': 'Cosine',
      'tangent': 'Tangent',
      'euler': 'Euler\'s Constant',
      'pi': 'Pi Constant',
      'golden_ratio': 'Golden Ratio',
      'share_app': 'Share App',
      'rate_app': 'Rate App',
      'theme': 'Theme',
      'dark_theme': 'Dark Theme',
      'vibration': 'Vibration',
      'sound_effects': 'Sound Effects',
      'auto_save_history': 'Auto Save History',
      'decimal_places': 'Decimal Places',
      'about_app': 'About App',
      'about_desc': 'BOTLAB Calculator is a modern and user-friendly calculator application. Designed for both basic and scientific calculations.',
      'ai_solver': 'AI Solver (Premium)',
      'ai_desc': 'Take a photo of a math problem, let AI solve it!',
      'take_photo': 'Take Photo',
      'pick_gallery': 'Pick from Gallery',
      'solving': 'Solving...',
      'solution': 'AI Solution',
      'premium_required': 'Premium subscription required for this feature.',
      'unlock_premium': 'Unlock Premium',
      'tools': 'Tools',
      'unit_converter': 'Unit Converter',
      'programmer': 'Programmer Calculator',
      'geometry': 'Geometry',
      'finance': 'Finance',
      'length': 'Length',
      'weight': 'Weight',
      'temperature': 'Temperature',
      'convert': 'Convert',
      'shape': 'Shape',
      'radius': 'Radius',
      'width': 'Width',
      'height': 'Height',
      'base': 'Base',
      'calculate': 'Calculate',
      'area': 'Area',
      'circumference': 'Circumference',
      'perimeter': 'Perimeter',
      'principal': 'Principal Amount',
      'rate': 'Interest Rate (%)',
      'duration': 'Duration (Years)',
      'loan': 'Loan',
      'savings': 'Savings',
      'monthly_payment': 'Monthly Payment',
      'total_payment': 'Total Payment',
      'total_interest': 'Total Interest',
      'total_amount': 'Total Amount',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Free AI Credits',
      'ai_freemium_desc': 'You are not Premium but you have {0} free credits left.',
      'ai_no_credits': 'No free credits left. Buy Premium to continue.',
      'try_free': 'Try for Free',
      'version': 'Version',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Technology company specialized in artificial intelligence and mobile application development.',
      'guide_title': 'User Guide',
      'guide_mod_title': 'SHIFT and ALPHA Modes',
      'guide_mod_desc': 'Press SHIFT or ALPHA to use secondary/tertiary functions (e.g., π, Rnd). [S] or [A] will appear in the top-left when active.',
      'guide_nav_title': 'Navigation Keys (Arrows)',
      'guide_nav_desc': 'Use Up/Down arrows to navigate through history. Left arrow acts as backspace to delete the last character.',
      'guide_integral_title': 'Integral Calculation',
      'guide_integral_desc': '1. Press ∫ button.\n2. ∫( will appear.\n3. Enter function, lower bound, and upper bound separated by commas.\n\nExample: ∫(cos(x),0,1.57)\n\nPress (=) to see the result!',
      'guide_ai_title': 'AI Solver',
      'guide_ai_desc': 'Use the AI Solver to solve complex math problems via photo. You start with 2 free credits. Upgrade to "Premium" for higher daily capacity.',
      'share_message': 'Calculator App: Solve math problems instantly with AI! Download: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Update Required',
      'update_desc': 'A new version of the app is available. Please update to continue.',
      'update_button': 'Update Now',
      'age_calc': 'Age Calculator',
      'bmi_calc': 'BMI Calculator',
      'discount_calc': 'Discount Calculator',
      'tip_calc': 'Tip Calculator',
      'calculate_btn': 'Calculate',
      'app_title': 'BotMath Calculator',
      'solve': 'Solve',
      'ai_history': 'AI History',
      'share': 'Share',
      'view_btn': 'View',
      'no_ai_history': 'No AI history yet',
      'free_credits': 'Free Credits: {0}',
      'ai_credits_rewarded': 'Congratulations! You earned +2 AI Credits.',
      'daily_limit_renews': 'Resets every night at 00:00. 100 uses/day.',
      'premium_history_desc': 'Get Premium to see more history!',
      'view_premium_packages': 'View Premium Packages',
      'share_ai_message': 'This problem was solved by BotMath Calculator. If you\'d like to get the app, click here: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Unlock Full History',
      'birth_date': 'Birth Date',
      'select_birth_date': 'Select Birth Date',
      'height_cm': 'Height (cm)',
      'weight_kg': 'Weight (kg)',
      'bmi_label': 'BMI',
      'status_label': 'Status',
      'price_label': 'Price',
      'discount_percent': 'Discount (%)',
      'final_price': 'Final Price',
      'savings_label': 'You Save',
      'bill_amount': 'Bill Amount',
      'tip_percent': 'Tip (%)',
      'people_count': 'Number of People',
      'total_tip': 'Total Tip',
      'per_person': 'Total per Person',
      'credits_label': 'Credits',
      'watch_ad_btn': 'Watch Ad (+2 Credits)',
      'tool_credits_summary': 'Free Tool Credits: {0} / {1}',
      'premium_offer_title': 'TRY 3 DAYS FOR FREE',
      'premium_offer_subtitle': 'Unlock All Features',
      'premium_offer_trial_info': '3 days free, then {0}/month. Cancel anytime.',
      'start_free_trial': 'START FREE TRIAL',
      'premium_offer_features_title': 'What you get?',
      'premium_offer_footer': 'By continuing, you agree to our Terms and Privacy Policy.',
    },
    'ES': {
      'title': 'Calculadora',
      'basic_mode': 'Modo Básico',
      'scientific_mode': 'Modo Científico',
      'history': 'Historial',
      'no_internet': 'Conexión a internet no encontrada',
      'settings': 'Ajustes',
      'about': 'Acerca de',
      'clear_history': 'Limpiar Historial',
      'no_history': 'No hay historial disponible',
      'close': 'Cerrar',
      'language': 'Idioma',
      'select_language': 'Seleccionar Idioma',
      'premium_purchase': 'Comprar Premium',
      'get_premium': 'Obtener Premium',
      'premium_features': 'Características Premium',
      'premium_desc': '¡Obtén más funciones con Premium!',
      'ad_free': 'Experiencia sin anuncios',
      'custom_themes': 'Temas personalizados',
      'advanced_functions': 'Funciones avanzadas',
      'unlimited_history': 'Historial ilimitado',
      'purchase_premium': 'Comprar Premium',
      'restore_purchase': 'Restaurar Compra',
      'cancel': 'Cancelar',
      'engineering_functions': 'Funciones de Ingeniería',
      'constants': 'Constantes',
      'power': 'Potencia',
      'square_root': 'Raíz Cuadrada',
      'cube_root': 'Raíz Cúbica',
      'factorial': 'Factorial',
      'logarithm': 'Logaritmo',
      'natural_log': 'Log Natural',
      'sine': 'Seno',
      'cosine': 'Coseno',
      'tangent': 'Tangente',
      'euler': 'Constante de Euler',
      'pi': 'Constante Pi',
      'golden_ratio': 'Proporción Áurea',
      'share_app': 'Compartir Aplicación',
      'rate_app': 'Calificar Aplicación',
      'theme': 'Tema',
      'dark_theme': 'Tema Oscuro',
      'vibration': 'Vibración',
      'sound_effects': 'Efectos de Sonido',
      'auto_save_history': 'Guardar Historial Automáticamente',
      'decimal_places': 'Lugares Decimales',
      'about_app': 'Acerca de la App',
      'about_desc': 'BOTLAB Calculadora es una aplicación de calculadora moderna y fácil de usar. Diseñada tanto para cálculos básicos como científicos.',
      'ai_solver': 'Solucionador AI (Premium)',
      'ai_desc': '¡Toma una foto de bir problema matemático, deja que la AI lo resuelva!',
      'take_photo': 'Tomar Foto',
      'pick_gallery': 'Elegir de la Galería',
      'solving': 'Resolviendo...',
      'solution': 'Solución AI',
      'premium_required': 'Se requiere suscripción Premium para esta función.',
      'unlock_premium': 'Desbloquear Premium',
      'tools': 'Herramientas',
      'unit_converter': 'Convertidor de Unidades',
      'programmer': 'Calculadora de Programador',
      'geometry': 'Geometría',
      'finance': 'Finanzas',
      'length': 'Longitud',
      'weight': 'Peso',
      'temperature': 'Temperatura',
      'convert': 'Convertir',
      'shape': 'Forma',
      'radius': 'Radio',
      'width': 'Ancho',
      'height': 'Altura',
      'base': 'Base',
      'calculate': 'Calcular',
      'area': 'Área',
      'circumference': 'Circunferencia',
      'perimeter': 'Perímetro',
      'principal': 'Monto Principal',
      'rate': 'Tasa de Interés (%)',
      'duration': 'Duración (Años)',
      'loan': 'Préstamo',
      'savings': 'Ahorros',
      'monthly_payment': 'Pago Mensual',
      'total_payment': 'Pago Total',
      'total_interest': 'Interés Total',
      'total_amount': 'Monto Total',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Créditos AI Gratuitos',
      'ai_freemium_desc': 'No eres Premium pero te quedan {0} créditos gratuitos.',
      'ai_no_credits': 'No quedan créditos gratuitos. Compra Premium para continuar.',
      'try_free': 'Probar Gratis',
      'version': 'Versión',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Empresa de tecnología especializada en inteligencia artificial y desarrollo de aplicaciones móviles.',
      'guide_title': 'Guía del Usuario',
      'guide_mod_title': 'Modos SHIFT ve ALPHA',
      'guide_mod_desc': 'Presione SHIFT veya ALPHA para usar funciones secundarias/terciarias (ej. π, Rnd). [S] o [A] aparecerá en la parte superior izquierda cuando esté activo.',
      'guide_nav_title': 'Teclas de Navegación (Flechas)',
      'guide_nav_desc': 'Use las flechas Arriba/Abajo para navegar por el historial. La flecha izquierda actúa como retroceso para borrar el último carácter.',
      'guide_integral_title': 'Cálculo Integral',
      'guide_integral_desc': '1. Presione el botón ∫.\n2. Aparecerá ∫(.\n3. Ingrese la función, el límite inferior y el límite superior separados by comas.\n\nEjemplo: ∫(cos(x),0,1.57)\n\n¡Presione (=) para ver el resultado!',
      'guide_ai_title': 'Solucionador AI',
      'guide_ai_desc': 'Use el Solucionador AI para resolver problemas matemáticos complejos a través de fotos. Comienzas con 2 créditos gratis. Actualiza a "Premium" para una mayor capacidad diaria.',
      'share_message': 'Aplicación de Calculadora: ¡Resuelve problemas matemáticos al instante con AI! Descarga: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Actualización Requerida',
      'update_desc': 'Una nueva versión de la aplicación está disponible. Por favor, actualice para continuar.',
      'update_button': 'Actualizar Ahora',
      'age_calc': 'Calculadora de Edad',
      'bmi_calc': 'Calculadora de IMC',
      'discount_calc': 'Calculadora de Descuento',
      'tip_calc': 'Calculadora de Propinas',
      'calculate_btn': 'Calcular',
      'app_title': 'Calculadora BotMath',
      'solve': 'Resolver',
      'ai_history': 'Historial AI',
      'share': 'Compartir',
      'view_btn': 'Ver',
      'no_ai_history': 'Aún no hay historial AI',
      'free_credits': 'Créditos Gratuitos: {0}',
      'ai_credits_rewarded': '¡Felicidades! Ganaste +2 créditos de IA.',
      'daily_limit_renews': 'Se reinicia cada noche a las 00:00. 100 usos/día.',
      'premium_history_desc': '¡Obtén Premium para ver más historial!',
      'view_premium_packages': 'Ver Paquetes Premium',
      'share_ai_message': 'Este problema fue resuelto por la Calculadora BotMath. Si deseas obtener la aplicación, haz clic aquí: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Desbloquear Historial Completo',
      'birth_date': 'Fecha de Nacimiento',
      'select_birth_date': 'Seleccionar Fecha de Nacimiento',
      'height_cm': 'Altura (cm)',
      'weight_kg': 'Peso (kg)',
      'bmi_label': 'IMC',
      'status_label': 'Estado',
      'price_label': 'Precio',
      'discount_percent': 'Descuento (%)',
      'final_price': 'Precio Final',
      'savings_label': 'Tú Ahorras',
      'bill_amount': 'Monto de la Factura',
      'tip_percent': 'Propina (%)',
      'people_count': 'Número de Personas',
      'total_tip': 'Propina Total',
      'per_person': 'Total por Persona',
      'credits_label': 'Créditos',
      'watch_ad_btn': 'Ver Anuncio (+2 Créditos)',
      'tool_credits_summary': 'Créditos de Herramientas Gratuitos: {0} / {1}',
      'premium_offer_title': 'PRUEBA 3 DÍAS GRATIS',
      'premium_offer_subtitle': 'Desbloquea Todas las Funciones',
      'premium_offer_trial_info': '3 días gratis, luego {0}/mes. Cancela en cualquier momento.',
      'start_free_trial': 'INICIAR PRUEBA GRATUITA',
      'premium_offer_features_title': '¿Qué obtienes?',
      'premium_offer_footer': 'Al continuar, aceptas nuestros Términos y Política de Privacidad.',
    },
    'DE': {
      'title': 'Rechner',
      'basic_mode': 'Basismodus',
      'scientific_mode': 'Wissenschaftlicher Modus',
      'history': 'Verlauf',
      'no_internet': 'Keine Internetverbindung gefunden',
      'settings': 'Einstellungen',
      'about': 'Über',
      'clear_history': 'Verlauf löschen',
      'no_history': 'Kein Verlauf verfügbar',
      'close': 'Schließen',
      'language': 'Sprache',
      'select_language': 'Sprache auswählen',
      'premium_purchase': 'Premium kaufen',
      'get_premium': 'Premium erhalten',
      'premium_features': 'Premium-Funktionen',
      'premium_desc': 'Holen Sie sich mehr Funktionen mit Premium!',
      'ad_free': 'Werbefreies Erlebnis',
      'custom_themes': 'Benutzerdefinierte Themen',
      'advanced_functions': 'Erweiterte Funktionen',
      'unlimited_history': 'Unbegrenzter Verlauf',
      'purchase_premium': 'Premium kaufen',
      'restore_purchase': 'Kauf wiederherstellen',
      'cancel': 'Abbrechen',
      'engineering_functions': 'Engineering-Funktionen',
      'constants': 'Konstanten',
      'power': 'Potenz',
      'square_root': 'Quadratwurzel',
      'cube_root': 'Kubikwurzel',
      'factorial': 'Fakultät',
      'logarithm': 'Logarithmus',
      'natural_log': 'Natürlicher Logarithmus',
      'sine': 'Sinus',
      'cosine': 'Cosinus',
      'tangent': 'Tangens',
      'euler': 'Eulersche Zahl',
      'pi': 'Kreiszahl Pi',
      'golden_ratio': 'Goldener Schnitt',
      'share_app': 'App teilen',
      'rate_app': 'App bewerten',
      'theme': 'Thema',
      'dark_theme': 'Dunkles Thema',
      'vibration': 'Vibration',
      'sound_effects': 'Soundeffekte',
      'auto_save_history': 'Verlauf automatisch speichern',
      'decimal_places': 'Dezimalstellen',
      'about_app': 'Über die App',
      'about_desc': 'BOTLAB Rechner ist eine moderne und benutzerfreundliche Rechneranwendung. Entwickelt für sowohl grundlegende als auch wissenschaftliche Berechnungen.',
      'ai_solver': 'AI-Löser (Premium)',
      'ai_desc': 'Machen Sie ein Foto von einem mathematischen Problem, lassen Sie es von der KI lösen!',
      'take_photo': 'Foto machen',
      'pick_gallery': 'Aus Galerie wählen',
      'solving': 'Lösen...',
      'solution': 'AI-Lösung',
      'premium_required': 'Für diese Funktion ist ein Premium-Abonnement erforderlich.',
      'unlock_premium': 'Premium freischalten',
      'tools': 'Werkzeuge',
      'unit_converter': 'Einheitenumrechner',
      'programmer': 'Programmierer-Rechner',
      'geometry': 'Geometrie',
      'finance': 'Finanzen',
      'length': 'Länge',
      'weight': 'Gewicht',
      'temperature': 'Temperatur',
      'convert': 'Umrechnen',
      'shape': 'Form',
      'radius': 'Radius',
      'width': 'Breite',
      'height': 'Höhe',
      'base': 'Basis',
      'calculate': 'Berechnen',
      'area': 'Fläche',
      'circumference': 'Umfang',
      'perimeter': 'Umfang',
      'principal': 'Kapital',
      'rate': 'Zinssatz (%)',
      'duration': 'Dauer (Jahre)',
      'loan': 'Kredit',
      'savings': 'Ersparnisse',
      'monthly_payment': 'Monatliche Rate',
      'total_payment': 'Gesamtzahlung',
      'total_interest': 'Gesamtzinsen',
      'total_amount': 'Gesamtbetrag',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Kostenlose AI-Credits',
      'ai_freemium_desc': 'Sie sind kein Premium-Nutzer, haben aber noch {0} kostenlose Credits.',
      'ai_no_credits': 'Keine kostenlosen Credits mehr. Kaufen Sie Premium, um fortzufahren.',
      'try_free': 'Kostenlos testen',
      'version': 'Version',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Technologieunternehmen spezialisiert auf künstliche Intelligenz und mobile App-Entwicklung.',
      'guide_title': 'Benutzerhandbuch',
      'guide_mod_title': 'SHIFT- und ALPHA-Modi',
      'guide_mod_desc': 'Drücken Sie SHIFT oder ALPHA, um sekundäre/tertiäre Funktionen zu nutzen (z. B. π, Rnd). [S] oder [A] erscheint oben links, wenn aktiv.',
      'guide_nav_title': 'Navigationstasten (Pfeile)',
      'guide_nav_desc': 'Verwenden Sie die Auf-/Ab-Pfeile, um durch den Verlauf zu navigieren. Der linke Pfeil dient als Rücktaste zum Löschen des letzten Zeichens.',
      'guide_integral_title': 'Integralrechnung',
      'guide_integral_desc': '1. Drücken Sie die ∫-Taste.\n2. ∫( erscheint.\n3. Geben Sie die Funktion, die Untergrenze und die Obergrenze durch Kommas getrennt ein.\n\nBeispiel: ∫(cos(x),0,1.57)\n\nDrücken Sie (=), um das Ergebnis zu sehen!',
      'guide_ai_title': 'AI-Löser',
      'guide_ai_desc': 'Verwenden Sie den AI-Löser, um komplexe mathematische Probleme per Foto zu lösen. Sie erhalten zu Beginn 2 kostenlose Credits. Upgrade auf "Premium" für eine höhere tägliche Kapazität.',
      'share_message': 'Rechner App: Lösen Sie Mathe-Probleme sofort mit KI! Download: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Update erforderlich',
      'update_desc': 'Eine neue version der App ist verfügbar. Bitte aktualisieren Sie, um fortzufahren.',
      'update_button': 'Jetzt aktualisieren',
      'age_calc': 'Altersrechner',
      'bmi_calc': 'BMI-Rechner',
      'discount_calc': 'Rabattrechner',
      'tip_calc': 'Trinkgeldrechner',
      'calculate_btn': 'Berechnen',
      'app_title': 'BotMath-Rechner',
      'solve': 'Lösen',
      'ai_history': 'AI-Verlauf',
      'share': 'Teilen',
      'view_btn': 'Ansehen',
      'no_ai_history': 'Noch kein AI-Verlauf',
      'free_credits': 'Kostenlose Credits: {0}',
      'ai_credits_rewarded': 'Glückwunsch! Sie haben +2 AI-Guthaben gewonnen.',
      'daily_limit_renews': 'Wird jede Nacht um 00:00 Uhr zurückgesetzt. 100/Tag.',
      'premium_history_desc': 'Holen Sie sich Premium, um mehr zu sehen!',
      'view_premium_packages': 'Premium-Pakete anzeigen',
      'share_ai_message': 'Dieses Problem wurde mit dem BotMath-Rechner gelöst. Wenn Sie die App herunterladen möchten, klicken Sie hier: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Vollständigen Verlauf freischalten',
      'birth_date': 'Geburtsdatum',
      'select_birth_date': 'Geburtsdatum auswählen',
      'height_cm': 'Größe (cm)',
      'weight_kg': 'Gewicht (kg)',
      'bmi_label': 'BMI',
      'status_label': 'Status',
      'price_label': 'Preis',
      'discount_percent': 'Rabatt (%)',
      'final_price': 'Endpreis',
      'savings_label': 'Sie sparen',
      'bill_amount': 'Rechnungsbetrag',
      'tip_percent': 'Trinkgeld (%)',
      'people_count': 'Anzahl der Personen',
      'total_tip': 'Gesamtes Trinkgeld',
      'per_person': 'Gesamt pro Person',
      'credits_label': 'Credits',
      'watch_ad_btn': 'Anzeige ansehen (+2 Credits)',
      'tool_credits_summary': 'Kostenlose Werkzeug-Credits: {0} / {1}',
      'premium_offer_title': '3 TAGE KOSTENLOS TESTEN',
      'premium_offer_subtitle': 'Alle Funktionen freischalten',
      'premium_offer_trial_info': '3 Tage kostenlos, dann {0}/Monat. Jederzeit kündbar.',
      'start_free_trial': 'KOSTENLOSE TESTVERSION STARTEN',
      'premium_offer_features_title': 'Was du bekommst?',
      'premium_offer_footer': 'Durch Fortfahren stimmst du unseren Nutzungsbedingungen und Datenschutzbestimmungen zu.',
    },
    'AR': {
      'title': 'آلة حاسبة',
      'basic_mode': 'الوضع الأساسي',
      'scientific_mode': 'الوضع العلمي',
      'history': 'السجل',
      'no_internet': 'لم يتم العثور على اتصال بالإنترنت',
      'settings': 'الإعدادات',
      'about': 'حول',
      'clear_history': 'مسح السجل',
      'no_history': 'لا يوجد سجل متاح',
      'close': 'إغلاق',
      'language': 'اللغة',
      'select_language': 'اختر اللغة',
      'premium_purchase': 'شراء الإصدار المميز',
      'get_premium': 'احصل على الإصدار المميز',
      'premium_features': 'ميزات الإصدار المميز',
      'premium_desc': 'احصل على المزيد من الميزات مع الإصدار المميز!',
      'ad_free': 'تجربة خالية من الإعلانات',
      'custom_themes': 'سمات مخصصة',
      'advanced_functions': 'وظائف متقدمة',
      'unlimited_history': 'سجل غير محدود',
      'purchase_premium': 'شراء الإصدار المميز',
      'restore_purchase': 'استعادة المشتريات',
      'cancel': 'إلغاء',
      'engineering_functions': 'وظائف هندسية',
      'constants': 'الثوابت',
      'power': 'القوة (الأس)',
      'square_root': 'الجذر التربيعي',
      'cube_root': 'الجذر التكعيبي',
      'factorial': 'مضروب',
      'logarithm': 'لوغاريتم',
      'natural_log': 'اللوغاريتم الطبيعي',
      'sine': 'جيب (Sin)',
      'cosine': 'جيب التمام (Cos)',
      'tangent': 'ظل (Tan)',
      'euler': 'ثابت أويلر',
      'pi': 'ثابت باي',
      'golden_ratio': 'النسبة الذهبية',
      'share_app': 'شارك التطبيق',
      'rate_app': 'قيم التطبيق',
      'theme': 'السمة',
      'dark_theme': 'السمة الداكنة',
      'vibration': 'الاهتزاز',
      'sound_effects': 'المؤثرات الصوتية',
      'auto_save_history': 'حفظ السجل تلقائيًا',
      'decimal_places': 'المنازل العشرية',
      'about_app': 'حول التطبيق',
      'about_desc': 'تطبيق BOTLAB Calculator هو آلة حاسبة حديثة وسهلة الاستخدام، مصممة للحسابات الأساسية والعلمية.',
      'ai_solver': 'حلول الذكاء الاصطناعي (مميز)',
      'ai_desc': 'التقط صورة لمسألة رياضية ودع الذكاء الاصطناعي يحلها!',
      'take_photo': 'التقط صورة',
      'pick_gallery': 'اختر من المعرض',
      'solving': 'جارٍ الحل...',
      'solution': 'حل الذكاء الاصطناعي',
      'premium_required': 'يتطلب اشتراك مميز لاستخدام هذه الميزة.',
      'unlock_premium': 'فتح ميزات الإصدار المميز',
      'tools': 'أدوات',
      'unit_converter': 'محول الوحدات',
      'programmer': 'وضع المبرمج',
      'geometry': 'هندسة رياضية',
      'finance': 'المالية',
      'length': 'الطول',
      'weight': 'الوزن',
      'temperature': 'درجة الحرارة',
      'convert': 'تحويل',
      'shape': 'الشكل',
      'radius': 'نصف القطر',
      'width': 'العرض',
      'height': 'الارتفاع',
      'base': 'القاعدة',
      'calculate': 'احسب',
      'area': 'المساحة',
      'circumference': 'المحيط (دائرة)',
      'perimeter': 'المحيط',
      'principal': 'المبلغ الأصلي',
      'rate': 'معدل الفائدة (%)',
      'duration': 'المدة (سنوات)',
      'loan': 'قرض',
      'savings': 'مدخرات',
      'monthly_payment': 'الدفعة الشهرية',
      'total_payment': 'إجمالي الدفع',
      'total_interest': 'إجمالي الفائدة',
      'total_amount': 'المبلغ الإجمالي',
      'hex': 'سداسي عشري (HEX)',
      'dec': 'عشري (DEC)',
      'oct': 'ثماني (OCT)',
      'bin': 'ثنائي (BIN)',
      'ai_freemium_title': 'اعتمادات الذكاء الاصطناعي المجانية',
      'ai_freemium_desc': 'أنت لست عضوًا مميزًا ولكن لديك {0} اعتمادات مجانية متبقية.',
      'ai_no_credits': 'لا توجد اعتمادات مجانية متبقية. اشترِ الإصدار المميز للمتابعة.',
      'try_free': 'جربه مجانًا',
      'version': 'الإصدار',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'شركة تكنولوجيا متخصصة في الذكاء الاصطناعي وتطوير تطبيقات الهاتف المحمول.',
      'guide_title': 'دليل المستخدم',
      'guide_mod_title': 'أوضاع SHIFT و ALPHA',
      'guide_mod_desc': 'اضغط على SHIFT أو ALPHA لاستخدام الوظائف الثانوية/الثلاثية (مثل π، Rnd). سيظهر [S] أو [A] في أعلى اليسار عند التنشيط.',
      'guide_nav_title': 'مفاتيح التنقل (الأسهم)',
      'guide_nav_desc': 'استخدم الأسهم لأعلى/لأسفل للتنقل عبر السجل. يعمل السهم الأيسر كمفتاح مسافة للخلف لحذف الحرف الأخير.',
      'guide_integral_title': 'حساب التكامل',
      'guide_integral_desc': '1. اضغط على زر ∫.\n2. سيظهر ∫(.\n3. أدخل الدالة والحد الأدنى والحد الأعلى مفصولة بفواصل.\n\nمثال: ∫(cos(x),0,1.57)\n\nاضغط (=) لرؤية النتيجة!',
      'guide_ai_title': 'حلول الذكاء الاصطناعي',
      'guide_ai_desc': 'استخدم حلول الذكاء الاصطناعي لحل مسائل الرياضيات المعقدة عبر الصورة. ستحصل على اعتمادين مجانيين في البداية. قم بالترقية إلى "المميز" للحصول على سعة يومية أعلى.',
      'share_message': 'تطبيق الآلة الحاسبة: قم بحل مسائل الرياضيات فورًا باستخدام الذكاء الاصطناعي! للتحميل: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'تحديث مطلوب',
      'update_desc': 'يتوفر إصدار جديد من التطبيق. يرجى التحديث للمتابعة.',
      'update_button': 'التحديث الآن',
      'age_calc': 'حاسبة العمر',
      'bmi_calc': 'حاسبة مؤشر كتلة الجسم',
      'discount_calc': 'حاسبة الخصم',
      'tip_calc': 'حاسبة البقشيش',
      'calculate_btn': 'احسب',
      'app_title': 'حاسبة BotMath',
      'solve': 'حل',
      'ai_history': 'سجل الذكاء الاصطناعي',
      'share': 'مشاركة',
      'view_btn': 'عرض',
      'no_ai_history': 'لا يوجد سجل بعد',
      'free_credits': 'رصيد مجاني: {0}',
      'ai_credits_rewarded': 'تهانيا! حصلت على +2 رصيد ذكاء اصطناعي.',
      'daily_limit_renews': 'يتجدد كل ليلة عند 00:00. 100 استخدام يومياً.',
      'premium_history_desc': 'احصل على النسخة المميزة لمزيد من السجل!',
      'view_premium_packages': 'عرض باقات بريميوم',
      'share_ai_message': 'تم حل هذه المسألة باستخدام حاسبة BotMath. إذا كنت ترغب في الحصول على التطبيق، انقر هنا: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'فتح السجل بالكامل',
      'birth_date': 'تاريخ الميلاد',
      'select_birth_date': 'اختر تاريخ الميلاد',
      'height_cm': 'الطول (سم)',
      'weight_kg': 'الوزن (كجم)',
      'bmi_label': 'مؤشر كتلة الجسم',
      'status_label': 'الحالة',
      'price_label': 'السعر',
      'discount_percent': 'الخصم (%)',
      'final_price': 'السعر النهائي',
      'savings_label': 'أنت توفر',
      'bill_amount': 'مبلغ الفاتورة',
      'tip_percent': 'البقشيش (%)',
      'people_count': 'عدد الأشخاص',
      'total_tip': 'إجمالي البقشيش',
      'per_person': 'الإجمالي للشخص الواحد',
      'credits_label': 'الاعتمادات',
      'watch_ad_btn': 'شاهد إعلان (+2 اعتماد)',
      'tool_credits_summary': 'اعتمادات الأدوات المجانية: {0} / {1}',
      'premium_offer_title': 'جربه مجانًا لمدة 3 أيام',
      'premium_offer_subtitle': 'فتح جميع الميزات',
      'premium_offer_trial_info': '3 أيام مجانًا، ثم {0}/شهر. يمكنك الإلغاء في أي وقت.',
      'start_free_trial': 'ابدأ التجربة المجانية',
      'premium_offer_features_title': 'ماذا ستحصل عليه؟',
      'premium_offer_footer': 'من خلال الاستمرار، فإنك توافق على شروط الاستخدام وسياسة الخصوصية الخاصة بنا.',
    },
    'PT': {
      'title': 'Calculadora',
      'basic_mode': 'Modo Básico',
      'scientific_mode': 'Modo Científico',
      'history': 'Histórico',
      'no_internet': 'Conexão à internet não encontrada',
      'settings': 'Configurações',
      'about': 'Sobre',
      'clear_history': 'Limpar Histórico',
      'no_history': 'Nenhum histórico disponível',
      'close': 'Fechar',
      'language': 'Idioma',
      'select_language': 'Selecionar Idioma',
      'premium_purchase': 'Comprar Premium',
      'get_premium': 'Obter Premium',
      'premium_features': 'Recursos Premium',
      'premium_desc': 'Obtenha mais recursos com o Premium!',
      'ad_free': 'Experiência sem anúncios',
      'custom_themes': 'Temas personalizados',
      'advanced_functions': 'Funções avançadas',
      'unlimited_history': 'Histórico ilimitado',
      'purchase_premium': 'Comprar Premium',
      'restore_purchase': 'Restaurar Compra',
      'cancel': 'Cancelar',
      'engineering_functions': 'Funções de Engenharia',
      'constants': 'Constantes',
      'power': 'Potência',
      'square_root': 'Raiz Quadrada',
      'cube_root': 'Raiz Cúbica',
      'factorial': 'Fatorial',
      'logarithm': 'Logaritmo',
      'natural_log': 'Log Natural',
      'sine': 'Seno',
      'cosine': 'Cosseno',
      'tangent': 'Tangente',
      'euler': 'Constante de Euler',
      'pi': 'Constante Pi',
      'golden_ratio': 'Proporção Áurea',
      'share_app': 'Compartilhar App',
      'rate_app': 'Avaliar App',
      'theme': 'Tema',
      'dark_theme': 'Tema Escuro',
      'vibration': 'Vibração',
      'sound_effects': 'Efeitos Sonoros',
      'auto_save_history': 'Salvar Histórico Automaticamente',
      'decimal_places': 'Casas Decimais',
      'about_app': 'Sobre o App',
      'about_desc': 'BOTLAB Calculadora é um app moderno e intuitivo. Projetado para cálculos básicos e científicos.',
      'ai_solver': 'Solucionador AI (Premium)',
      'ai_desc': 'Tire uma foto de um problema de matemática, deixe a AI resolver!',
      'take_photo': 'Tirar Foto',
      'pick_gallery': 'Escolher da Galeria',
      'solving': 'Resolvendo...',
      'solution': 'Solução AI',
      'premium_required': 'Assinatura Premium necessária para este recurso.',
      'unlock_premium': 'Desbloquear Premium',
      'tools': 'Ferramentas',
      'unit_converter': 'Conversor de Unidades',
      'programmer': 'Calculadora de Programador',
      'geometry': 'Geometria',
      'finance': 'Finanças',
      'length': 'Comprimento',
      'weight': 'Peso',
      'temperature': 'Temperatura',
      'convert': 'Converter',
      'shape': 'Forma',
      'radius': 'Raio',
      'width': 'Largura',
      'height': 'Altura',
      'base': 'Base',
      'calculate': 'Calcular',
      'area': 'Área',
      'circumference': 'Circunferência',
      'perimeter': 'Perímetro',
      'principal': 'Capital',
      'rate': 'Taxa de Juros (%)',
      'duration': 'Duração (Anos)',
      'loan': 'Empréstimo',
      'savings': 'Poupança',
      'monthly_payment': 'Pagamento Mensal',
      'total_payment': 'Pagamento Total',
      'total_interest': 'Juros Totais',
      'total_amount': 'Montante Total',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Créditos AI Gratuitos',
      'ai_freemium_desc': 'Você não é Premium, mas tem {0} créditos grátis restantes.',
      'ai_no_credits': 'Acabaram os créditos grátis. Compre Premium para continuar.',
      'try_free': 'Experimentar Grátis',
      'version': 'Versão',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Empresa de tecnologia especializada em IA e desenvolvimento móvel.',
      'guide_title': 'Guia do Usuário',
      'guide_mod_title': 'Modos SHIFT e ALPHA',
      'guide_mod_desc': 'Pressione SHIFT ou ALPHA para usar funções secundárias/terciárias. [S] ou [A] aparecerá no canto superior esquerdo.',
      'guide_nav_title': 'Teclas de Navegação (Setas)',
      'guide_nav_desc': 'Use as setas para cima/para baixo para navegar no histórico. A seta esquerda funciona como backspace.',
      'guide_integral_title': 'Cálculo Integral',
      'guide_integral_desc': '1. Pressione ∫.\n2. ∫( aparecerá.\n3. Digite a função, limite inferior e superior separados por vírgulas.\n\nExemplo: ∫(cos(x),0,1.57)\n\nPressione (=) para o resultado!',
      'guide_ai_title': 'Solucionador AI',
      'guide_ai_desc': 'Use o Solucionador AI para problemas complexos via foto. Você começa com 2 créditos grátis.',
      'share_message': 'Calculadora: Resolva problemas de matemática instantaneamente com IA! Baixe: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Atualização Necessária',
      'update_desc': 'Uma nova versão do app está disponível. Atualize para continuar.',
      'update_button': 'Atualizar Agora',
      'age_calc': 'Calculadora de Idade',
      'bmi_calc': 'Calculadora de IMC',
      'discount_calc': 'Calculadora de Desconto',
      'tip_calc': 'Calculadora de Gorjetas',
      'calculate_btn': 'Calcular',
      'app_title': 'Calculadora BotMath',
      'solve': 'Resolver',
      'ai_history': 'Histórico AI',
      'share': 'Compartilhar',
      'view_btn': 'Ver',
      'no_ai_history': 'Nenhum histórico AI ainda',
      'free_credits': 'Créditos Grátis: {0}',
      'ai_credits_rewarded': 'Parabéns! Você ganhou +2 créditos de IA.',
      'daily_limit_renews': 'Reinicia todos os dias às 00:00. 100 usos/dia.',
      'premium_history_desc': 'Obtenha Premium para ver mais histórico!',
      'view_premium_packages': 'Ver Pacotes Premium',
      'share_ai_message': 'Este problema foi resolvido pela Calculadora BotMath. Baixe aqui: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Desbloquear Histórico Completo',
      'birth_date': 'Data de Nascimento',
      'select_birth_date': 'Selecionar Data de Nascimento',
      'height_cm': 'Altura (cm)',
      'weight_kg': 'Peso (kg)',
      'bmi_label': 'IMC',
      'status_label': 'Status',
      'price_label': 'Preço',
      'discount_percent': 'Desconto (%)',
      'final_price': 'Preço Final',
      'savings_label': 'Você Economiza',
      'bill_amount': 'Valor da Conta',
      'tip_percent': 'Gorjeta (%)',
      'people_count': 'Número de Pessoas',
      'total_tip': 'Gorjeta Total',
      'per_person': 'Total por Pessoa',
      'credits_label': 'Créditos',
      'watch_ad_btn': 'Assistir Vídeo (+2 Créditos)',
      'tool_credits_summary': 'Créditos de Ferramentas Grátis: {0} / {1}',
      'premium_offer_title': 'EXPERIMENTE 3 DIAS GRÁTIS',
      'premium_offer_subtitle': 'Desbloqueie Todos os Recursos',
      'premium_offer_trial_info': '3 dias grátis, depois {0}/mês. Cancele a qualquer momento.',
      'start_free_trial': 'INICIAR TESTE GRÁTIS',
      'premium_offer_features_title': 'O que você ganha?',
      'premium_offer_footer': 'Ao continuar, você concorda com nossos Termos e Política de Privacidade.',
    },
    'FR': {
      'title': 'Calculatrice',
      'basic_mode': 'Mode Basique',
      'scientific_mode': 'Mode Scientifique',
      'history': 'Historique',
      'no_internet': 'Connexion Internet non trouvée',
      'settings': 'Paramètres',
      'about': 'À propos',
      'clear_history': 'Effacer l\'Historique',
      'no_history': 'Aucun historique disponible',
      'close': 'Fermer',
      'language': 'Langue',
      'select_language': 'Choisir la Langue',
      'premium_purchase': 'Acheter Premium',
      'get_premium': 'Devenir Premium',
      'premium_features': 'Fonctionnalités Premium',
      'premium_desc': 'Obtenez plus de fonctionnalités avec Premium !',
      'ad_free': 'Expérience sans publicité',
      'custom_themes': 'Thèmes personnalisés',
      'advanced_functions': 'Fonctions avancées',
      'unlimited_history': 'Historique illimité',
      'purchase_premium': 'Acheter Premium',
      'restore_purchase': 'Restaurer l\'achat',
      'cancel': 'Annuler',
      'engineering_functions': 'Fonctions d\'Ingénierie',
      'constants': 'Constantes',
      'power': 'Puissance',
      'square_root': 'Racine Carrée',
      'cube_root': 'Racine Cubique',
      'factorial': 'Factorielle',
      'logarithm': 'Logarithme',
      'natural_log': 'Log Naturel',
      'sine': 'Sinus',
      'cosine': 'Cosinus',
      'tangent': 'Tangente',
      'euler': 'Constante d\'Euler',
      'pi': 'Constante Pi',
      'golden_ratio': 'Nombre d\'Or',
      'share_app': 'Partager l\'App',
      'rate_app': 'Noter l\'App',
      'theme': 'Thème',
      'dark_theme': 'Thème Sombre',
      'vibration': 'Vibration',
      'sound_effects': 'Effets Sonores',
      'auto_save_history': 'Sauvegarde Automatique',
      'decimal_places': 'Décimales',
      'about_app': 'À propos de l\'App',
      'about_desc': 'BOTLAB Calculatrice est une application moderne et intuitive. Conçue pour les calculs basiques et scientifiques.',
      'ai_solver': 'Solveur AI (Premium)',
      'ai_desc': 'Prenez une photo d\'un problème de math, l\'IA le résout !',
      'take_photo': 'Prendre une Photo',
      'pick_gallery': 'Choisir dans la Galerie',
      'solving': 'Résolution...',
      'solution': 'Solution IA',
      'premium_required': 'Abonnement Premium requis pour cette fonctionnalité.',
      'unlock_premium': 'Débloquer Premium',
      'tools': 'Outils',
      'unit_converter': 'Convertisseur d\'Unités',
      'programmer': 'Mode Programmeur',
      'geometry': 'Géométrie',
      'finance': 'Finance',
      'length': 'Longueur',
      'weight': 'Poids',
      'temperature': 'Température',
      'convert': 'Convertir',
      'shape': 'Forme',
      'radius': 'Rayon',
      'width': 'Largeur',
      'height': 'Hauteur',
      'base': 'Base',
      'calculate': 'Calculer',
      'area': 'Aire',
      'circumference': 'Circonférence',
      'perimeter': 'Périmètre',
      'principal': 'Capital',
      'rate': 'Taux d\'Intérêt (%)',
      'duration': 'Durée (Années)',
      'loan': 'Prêt',
      'savings': 'Épargne',
      'monthly_payment': 'Mensualité',
      'total_payment': 'Paiement Total',
      'total_interest': 'Intérêt Total',
      'total_amount': 'Montant Total',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Crédits IA Gratuits',
      'ai_freemium_desc': 'Vous n\'êtes pas Premium mais il vous reste {0} crédits gratuits.',
      'ai_no_credits': 'Plus de crédits gratuits. Achetez Premium pour continuer.',
      'try_free': 'Essayer Gratuitement',
      'version': 'Version',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Entreprise technologique spécialisée en IA et développement mobile.',
      'guide_title': 'Guide de l\'Utilisateur',
      'guide_mod_title': 'Modes SHIFT et ALPHA',
      'guide_mod_desc': 'Appuyez sur SHIFT ou ALPHA pour les fonctions secondaires/tertiaires. [S] ou [A] s\'affiche en haut à gauche.',
      'guide_nav_title': 'Touches de Navigation (Flèches)',
      'guide_nav_desc': 'Utilisez les flèches haut/bas pour naviguer dans l\'historique. La flèche gauche sert d\'effacement.',
      'guide_integral_title': 'Calcul d\'Intégrale',
      'guide_integral_desc': '1. Appuyez sur ∫.\n2. ∫( s\'affiche.\n3. Entrez la fonction, les bornes séparées par des virgules.\n\nExemple: ∫(cos(x),0,1.57)\n\nAppuyez sur (=) pour le résultat !',
      'guide_ai_title': 'Solveur IA',
      'guide_ai_desc': 'Utilisez le solveur IA pour les problèmes complexes via photo. Vous commencez avec 2 crédits gratuits.',
      'share_message': 'Calculatrice : Résolvez vos problèmes de math instantanément avec l\'IA ! Téléchargez: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Mise à jour Requise',
      'update_desc': 'Une nouvelle version est disponible. Veuillez mettre à jour pour continuer.',
      'update_button': 'Mettre à jour Maintenant',
      'age_calc': 'Calculateur d\'Âge',
      'bmi_calc': 'Calculateur d\'IMC',
      'discount_calc': 'Calculateur de Remise',
      'tip_calc': 'Calculateur de Pourboire',
      'calculate_btn': 'Calculer',
      'app_title': 'Calculatrice BotMath',
      'solve': 'Résoudre',
      'ai_history': 'Historique IA',
      'share': 'Partager',
      'view_btn': 'Voir',
      'no_ai_history': 'Pas encore d\'historique IA',
      'free_credits': 'Crédits Gratuits : {0}',
      'ai_credits_rewarded': 'Félicitations ! Vous avez gagné +2 crédits IA.',
      'daily_limit_renews': 'Réinitialisation à minuit. 100 utilisations/jour.',
      'premium_history_desc': 'Passez en Premium pour voir plus d\'historique !',
      'view_premium_packages': 'Voir les Forfaits Premium',
      'share_ai_message': 'Ce problème a été résolu par BotMath Calculatrice. Téléchargez ici: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Débloquer l\'Historique Complet',
      'birth_date': 'Date de Naissance',
      'select_birth_date': 'Choisir Date de Naissance',
      'height_cm': 'Taille (cm)',
      'weight_kg': 'Poids (kg)',
      'bmi_label': 'IMC',
      'status_label': 'Statut',
      'price_label': 'Prix initial',
      'discount_percent': 'Remise (%)',
      'final_price': 'Prix Final',
      'savings_label': 'Vous Économisez',
      'bill_amount': 'Montant de l\'Addition',
      'tip_percent': 'Pourboire (%)',
      'people_count': 'Nombre de Personnes',
      'total_tip': 'Pourboire Total',
      'per_person': 'Total par Personne',
      'credits_label': 'Crédits',
      'watch_ad_btn': 'Regarder Vidéo (+2 Crédits)',
      'tool_credits_summary': 'Crédits Outils Gratuits : {0} / {1}',
      'premium_offer_title': 'ESSAYEZ 3 JOURS GRATUITEMENT',
      'premium_offer_subtitle': 'Débloquez toutes les fonctionnalités',
      'premium_offer_trial_info': '3 jours gratuits, puis {0}/mois. Annulez à tout moment.',
      'start_free_trial': 'COMMENCER L\'ESSAI GRATUIT',
      'premium_offer_features_title': 'Ce que vous obtenez ?',
      'premium_offer_footer': 'En continuant, vous acceptez nos conditions d\'utilisation et notre politique de confidentialité.',
    },
    'RU': {
      'title': 'Калькулятор',
      'basic_mode': 'Базовый',
      'scientific_mode': 'Научный',
      'history': 'История',
      'no_internet': 'Подключение к интернету не найдено',
      'settings': 'Настройки',
      'about': 'О приложении',
      'clear_history': 'Очистить историю',
      'no_history': 'История пуста',
      'close': 'Закрыть',
      'language': 'Язык',
      'select_language': 'Выберите язык',
      'premium_purchase': 'Купить Premium',
      'get_premium': 'Получить Premium',
      'premium_features': 'Premium функции',
      'premium_desc': 'Разблокируйте больше функций с Premium!',
      'ad_free': 'Без рекламы',
      'custom_themes': 'Персональные темы',
      'advanced_functions': 'Расширенные функции',
      'unlimited_history': 'Безлимитная история',
      'purchase_premium': 'Купить Premium',
      'restore_purchase': 'Восстановить покупку',
      'cancel': 'Отмена',
      'engineering_functions': 'Инженерные функции',
      'constants': 'Константы',
      'power': 'Степень',
      'square_root': 'Квадратный корень',
      'cube_root': 'Кубический корень',
      'factorial': 'Факториал',
      'logarithm': 'Логарифм',
      'natural_log': 'Нат. логарифм',
      'sine': 'Синус',
      'cosine': 'Косинус',
      'tangent': 'Тангенс',
      'euler': 'Число Эйлера',
      'pi': 'Число Пи',
      'golden_ratio': 'Золотое сечение',
      'share_app': 'Поделиться',
      'rate_app': 'Оценить',
      'theme': 'Тема',
      'dark_theme': 'Темная тема',
      'vibration': 'Вибрация',
      'sound_effects': 'Звуковые эффекты',
      'auto_save_history': 'Автосохранение истории',
      'decimal_places': 'Знаков после запятой',
      'about_app': 'О приложении',
      'about_desc': 'BOTLAB Калькулятор — это современное и удобное приложение для базовых и научных расчетов.',
      'ai_solver': 'AI Решатель (Premium)',
      'ai_desc': 'Сфотографируйте задачу, и ИИ решит ее!',
      'take_photo': 'Сделать фото',
      'pick_gallery': 'Галерея',
      'solving': 'Решение...',
      'solution': 'AI Решение',
      'premium_required': 'Требуется подписка Premium.',
      'unlock_premium': 'Открыть Premium',
      'tools': 'Инструменты',
      'unit_converter': 'Конвертер величин',
      'programmer': 'Программист',
      'geometry': 'Геометрия',
      'finance': 'Финансы',
      'length': 'Длина',
      'weight': 'Вес',
      'temperature': 'Температура',
      'convert': 'Перевести',
      'shape': 'Фигура',
      'radius': 'Радиус',
      'width': 'Ширина',
      'height': 'Высота',
      'base': 'Основание',
      'calculate': 'Рассчитать',
      'area': 'Площадь',
      'circumference': 'Длина окружности',
      'perimeter': 'Периметр',
      'principal': 'Сумма',
      'rate': 'Ставка (%)',
      'duration': 'Срок (лет)',
      'loan': 'Кредит',
      'savings': 'Вклады',
      'monthly_payment': 'Месячный платеж',
      'total_payment': 'Общая выплата',
      'total_interest': 'Всего процентов',
      'total_amount': 'Итоговая сумма',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'Бесплатные AI попытки',
      'ai_freemium_desc': 'У вас осталось {0} бесплатных попыток.',
      'ai_no_credits': 'Попытки закончились. Купите Premium.',
      'try_free': 'Попробовать бесплатно',
      'version': 'Версия',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'Технологическая компания, специализирующаяся на ИИ и мобильной разработке.',
      'guide_title': 'Руководство',
      'guide_mod_title': 'Режимы SHIFT и ALPHA',
      'guide_mod_desc': 'Используйте SHIFT или ALPHA для доп. функций. [S] или [A] появится сверху слева.',
      'guide_nav_title': 'Навигация (стрелки)',
      'guide_nav_desc': 'Стрелки вверх/вниз для истории. Левая стрелка — удаление символа.',
      'guide_integral_title': 'Интегралы',
      'guide_integral_desc': '1. Нажмите ∫.\n2. Введите функцию и пределы через запятую.\n\nНапример: ∫(cos(x),0,1.57)',
      'guide_ai_title': 'AI Решатель',
      'guide_ai_desc': 'Решайте задачи по фото. У вас есть 2 бесплатные попытки.',
      'share_message': 'Калькулятор: Решайте задачи мгновенно с помощью ИИ! Скачать: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'Требуется обновление',
      'update_desc': 'Доступна новая версия. Пожалуйста, обновитесь.',
      'update_button': 'Обновить сейчас',
      'age_calc': 'Возраст',
      'bmi_calc': 'ИМТ',
      'discount_calc': 'Скидки',
      'tip_calc': 'Чаевые',
      'calculate_btn': 'Рассчитать',
      'app_title': 'BotMath Калькулятор',
      'solve': 'Решить',
      'ai_history': 'AI История',
      'share': 'Поделиться',
      'view_btn': 'Смотреть',
      'no_ai_history': 'AI история пуста',
      'free_credits': 'Бесплатно: {0}',
      'ai_credits_rewarded': 'Поздравляем! +2 AI попытки.',
      'daily_limit_renews': 'Обновляется в полночь. 100 в день.',
      'premium_history_desc': 'Купите Premium для всей истории!',
      'view_premium_packages': 'Пакеты Premium',
      'share_ai_message': 'Эта задача решена BotMath Калькулятором. Скачать: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'Открыть всю историю',
      'birth_date': 'Дата рождения',
      'select_birth_date': 'Выберите дату',
      'height_cm': 'Рост (см)',
      'weight_kg': 'Вес (кг)',
      'bmi_label': 'ИМТ',
      'status_label': 'Статус',
      'price_label': 'Цена',
      'discount_percent': 'Скидка (%)',
      'final_price': 'Итоговая цена',
      'savings_label': 'Экономия',
      'bill_amount': 'Сумма счета',
      'tip_percent': 'Чаевые (%)',
      'people_count': 'Кол-во человек',
      'total_tip': 'Всего чаевых',
      'per_person': 'С каждого',
      'credits_label': 'Попытки',
      'watch_ad_btn': 'Смотреть рекламу (+2)',
      'tool_credits_summary': 'Бесплатные попытки: {0} / {1}',
      'premium_offer_title': '3 ДНЯ БЕСПЛАТНО',
      'premium_offer_subtitle': 'Разблокируйте все функции',
      'premium_offer_trial_info': '3 дня бесплатно, затем {0}/мес. Отмена в любое время.',
      'start_free_trial': 'НАЧАТЬ БЕСПЛАТНЫЙ ПЕРИОД',
      'premium_offer_features_title': 'Что вы получите?',
      'premium_offer_footer': 'Продолжая, вы соглашаетесь с Условиями использования и Политикой конфиденциальности.',
    },
    'HI': {
      'title': 'कैलकुलेटर',
      'basic_mode': 'सामान्य मोड',
      'scientific_mode': 'वैज्ञानिक मोड',
      'history': 'इतिहास',
      'no_internet': 'इंटरनेट कनेक्शन नहीं मिला',
      'settings': 'सेटिंग्स',
      'about': 'ऐप के बारे में',
      'clear_history': 'इतिहास साफ़ करें',
      'no_history': 'इतिहास उपलब्ध नहीं है',
      'close': 'बंद करें',
      'language': 'भाषा',
      'select_language': 'भाषा चुनें',
      'premium_purchase': 'प्रीमियम खरीदें',
      'get_premium': 'प्रीमियम प्राप्त करें',
      'premium_features': 'प्रीमियम विशेषताएं',
      'premium_desc': 'प्रीमियम के साथ अधिक सुविधाएँ प्राप्त करें!',
      'ad_free': 'विज्ञापन-मुक्त अनुभव',
      'custom_themes': 'कस्टम थीम',
      'advanced_functions': 'उन्नत कार्य',
      'unlimited_history': 'असीमित इतिहास',
      'purchase_premium': 'प्रीमियम खरीदें',
      'restore_purchase': 'खरीद बहाल करें',
      'cancel': 'रद्द करें',
      'engineering_functions': 'इंजीनियरिंग कार्य',
      'constants': 'स्थिरांक',
      'power': 'घास',
      'square_root': 'वर्गमूल',
      'cube_root': 'घनमूल',
      'factorial': 'फैक्टोरियल',
      'logarithम': 'लॉग',
      'natural_log': 'प्राकृतिक लॉग',
      'sine': 'साइन',
      'cosine': 'कोसाइन',
      'tangent': 'टेंजेंट',
      'euler': 'यूलर स्थिरांक',
      'pi': 'पाई',
      'golden_ratio': 'स्वर्ण अनुपात',
      'share_app': 'ऐप शेयर करें',
      'rate_app': 'रेट करें',
      'theme': 'थीम',
      'dark_theme': 'डार्क थीम',
      'vibration': 'कंपन',
      'sound_effects': 'ध्वनि प्रभाव',
      'auto_save_history': 'ऑटो सेव इतिहास',
      'decimal_places': 'दशमलव स्थान',
      'about_app': 'ऐप के बारे में',
      'about_desc': 'BOTLAB कैलकुलेटर एक आधुनिक और उपयोग में आसान कैलकुलेटर है।',
      'ai_solver': 'AI सॉल्वर (प्रीमियम)',
      'ai_desc': 'गणित की समस्या की फोटो लें, AI उसे हल करेगा!',
      'take_photo': 'फोटो लें',
      'pick_gallery': 'गैलरी से चुनें',
      'solving': 'हल हो रहा है...',
      'solution': 'AI समाधान',
      'premium_required': 'इस सुविधा के लिए प्रीमियम सदस्यता आवश्यक है।',
      'unlock_premium': 'प्रीमियम अनलॉक करें',
      'tools': 'उपकरण',
      'unit_converter': 'इकाई परिवर्तक',
      'programmer': 'प्रोग्रामर कैलकुलेटर',
      'geometry': 'ज्यामिति',
      'finance': 'वित्त',
      'length': 'लंबाई',
      'weight': 'वजन',
      'temperature': 'तापमान',
      'convert': 'बदलें',
      'shape': 'आकार',
      'radius': 'त्रिज्या',
      'width': 'चौड़ाई',
      'height': 'ऊंचाई',
      'base': 'आधार',
      'calculate': 'गणना करें',
      'area': 'क्षेत्रफल',
      'circumference': 'परिधि',
      'perimeter': 'परिमाप',
      'principal': 'मूल राशि',
      'rate': 'ब्याज दर (%)',
      'duration': 'अवधि (वर्ष)',
      'loan': 'ऋण',
      'savings': 'बचत',
      'monthly_payment': 'मासिक भुगतान',
      'total_payment': 'कुल भुगतान',
      'total_interest': 'कुल ब्याज',
      'total_amount': 'कुल राशि',
      'hex': 'HEX',
      'dec': 'DEC',
      'oct': 'OCT',
      'bin': 'BIN',
      'ai_freemium_title': 'मुफ्त AI क्रेडिट',
      'ai_freemium_desc': 'आपके पास {0} मुफ्त क्रेडिट बचे हैं।',
      'ai_no_credits': 'कोई मुफ्त क्रेडिट नहीं बचा।',
      'try_free': 'मुफ्त में आजमाएं',
      'version': 'वर्जन',
      'company': 'BOTLAB AI TECHNOLOGY',
      'company_desc': 'AI और मोबाइल डेवलपमेंट में विशेषज्ञ कंपनी।',
      'guide_title': 'उपयोगकर्ता मार्गदर्शिका',
      'guide_mod_title': 'SHIFT और ALPHA मोड',
      'guide_mod_desc': 'सेकेंडरी कार्यों के लिए SHIFT या ALPHA दबाएं। ऊपर बाईं ओर [S] या [A] दिखाई देगा।',
      'guide_nav_title': 'नेविगेशन कुंजियाँ (तीर)',
      'guide_nav_desc': 'इतिहास देखने के लिए ऊपर/नीचे तीरों का उपयोग करें।',
      'guide_integral_title': 'समाकलन (Integral)',
      'guide_integral_desc': '1. ∫ बटन दबाएं।\n2. फंक्शन और सीमाएं कॉमा से अलग करके लिखें।',
      'guide_ai_title': 'AI सॉल्वर',
      'guide_ai_desc': 'फोटो के जरिए जटिल समस्याओं को हल करें। आपको 2 मुफ्त क्रेडिट मिलते हैं।',
      'share_message': 'कैलकुलेटर ऐप: AI के साथ गणित की समस्याओं को तुरंत हल करें! डाउनलोड करें: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'update_required': 'अपडेट आवश्यक',
      'update_desc': 'ऐप का नया वर्जन उपलब्ध है। कृपया अपडेट करें।',
      'update_button': 'अभी अपडेट करें',
      'age_calc': 'आयु कैलकुलेटर',
      'bmi_calc': 'BMI कैलकुलेटर',
      'discount_calc': 'छूट कैलकुलेटर',
      'tip_calc': 'टिप कैलकुलेटर',
      'calculate_btn': 'गणना करें',
      'app_title': 'BotMath कैलकुलेटर',
      'solve': 'हल करें',
      'ai_history': 'AI इतिहास',
      'share': 'शेयर',
      'view_btn': 'देखें',
      'no_ai_history': 'कोई AI इतिहास नहीं',
      'free_credits': 'मुफ्त क्रेडिट: {0}',
      'ai_credits_rewarded': 'बधाई हो! आपको +2 AI क्रेडिट मिले।',
      'daily_limit_renews': 'हर रात 00:00 बजे रीसेट होता है।',
      'premium_history_desc': 'अधिक इतिहास देखने के लिए प्रीमियम प्राप्त करें!',
      'view_premium_packages': 'प्रीमियम पैकेज देखें',
      'share_ai_message': 'यह समस्या BotMath कैलकुलेटर द्वारा हल की गई। ऐप प्राप्त करें: https://play.google.com/store/apps/details?id=com.botlab.calculator',
      'unlock_full_history': 'पूरा इतिहास अनलॉक करें',
      'birth_date': 'जन्म तिथि',
      'select_birth_date': 'जन्म तिथि चुनें',
      'height_cm': 'ऊंचाई (सेमी)',
      'weight_kg': 'वजन (किग्रा)',
      'bmi_label': 'BMI',
      'status_label': 'स्थिति',
      'price_label': 'कीमत',
      'discount_percent': 'छूट (%)',
      'final_price': 'अंतिम कीमत',
      'savings_label': 'आपकी बचत',
      'bill_amount': 'बिल राशि',
      'tip_percent': 'टिप (%)',
      'people_count': 'लोगों की संख्या',
      'total_tip': 'कुल टिप',
      'per_person': 'प्रति व्यक्ति कुल',
      'credits_label': 'क्रेडिट',
      'watch_ad_btn': 'वीडियो देखें (+2 क्रेडिट)',
      'tool_credits_summary': 'मुफ्त टूल क्रेडिट: {0} / {1}',
      'premium_offer_title': '3 दिनों के लिए मुफ्त में आजमाएं',
      'premium_offer_subtitle': 'सभी सुविधाएं अनलॉक करें',
      'premium_offer_trial_info': '3 दिन मुफ्त, फिर {0}/माह। कभी भी रद्द करें।',
      'start_free_trial': 'मुफ्त ट्रायल शुरू करें',
      'premium_offer_features_title': 'आपको क्या मिलेगा?',
      'premium_offer_footer': 'जारी रखकर, आप हमारी सेवा की शर्तों और गोपनीयता नीति से सहमत होते हैं।',
    },
  };

  static Map<String, String> getTranslations(String lang) {
    final base = all['TR']!;
    final target = all[lang] ?? base;
    return Map<String, String>.from(base)..addAll(target);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await MobileAds.instance.initialize();
    debugPrint("Firebase and Ads initialized successfully.");
  } catch (e) {
    debugPrint("Initialization failure (Firebase/Ads): $e");
    if (kDebugMode) {
      print("CRITICAL: Firebase initialization failed. Check your configuration.");
    }
  }
  
  // RevenueCat Debugging
  await Purchases.setLogLevel(LogLevel.debug);
  
  if (Platform.isAndroid) {
    PurchasesConfiguration configuration = PurchasesConfiguration("goog_pYMPiDyqDdQmvwVWiKWoQLjpPUs");
    await Purchases.configure(configuration);
  } else if (Platform.isIOS) {
    PurchasesConfiguration configuration = PurchasesConfiguration("appl_CJYQyunpGkkjmslYzujKgQQUISK");
    await Purchases.configure(configuration);
  }

  final prefs = await SharedPreferences.getInstance();
  final bool languageSelected = prefs.getBool('languageSelected') ?? false;
  final String currentLanguage = prefs.getString('language') ?? 'TR';

  final analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();

  // Firebase Auth: Anonim Giriş ve RevenueCat Senkronizasyonu
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    final uid = userCredential.user?.uid;
    if (uid != null) {
      debugPrint("Firebase Auth Success: $uid");
      await Purchases.logIn(uid);
      await analytics.setUserId(id: uid);
      
      String? fbAnonId = await FacebookAppEvents().getAnonymousId();
      if (fbAnonId != null) {
        debugPrint("Facebook Anon ID fetched: $fbAnonId");
        await Purchases.setFBAnonymousID(fbAnonId);
      }
    }
  } catch (e) {
    debugPrint("Firebase Auth or RevenueCat login failed: $e");
  }

  // Force Update Kontrolü
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  
  await remoteConfig.setDefaults({
    "force_update_min_version": "1.0.25",
  });

  try {
    await remoteConfig.fetchAndActivate();
  } catch (e) {
    debugPrint("Remote Config fetch failed: $e");
  }

  runApp(CalculatorApp(
    languageSelected: languageSelected, 
    currentLanguage: currentLanguage,
    analytics: analytics,
    remoteConfig: remoteConfig,
  ));
}

class CalculatorApp extends StatelessWidget {
  static final ValueNotifier<String> themeNotifier = ValueNotifier('Classic');
  final bool languageSelected;
  final String currentLanguage;
  final FirebaseAnalytics analytics;
  final FirebaseRemoteConfig remoteConfig;

  const CalculatorApp({
    super.key, 
    required this.languageSelected, 
    required this.currentLanguage,
    required this.analytics,
    required this.remoteConfig,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: themeNotifier,
      builder: (_, themeName, __) {
        final theme = CalculatorThemes.getTheme(themeName);
        return MaterialApp(
          title: AppTranslations.getTranslations(currentLanguage)['title'] ?? 'Hesap Makinası',
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          theme: ThemeData(
            brightness: theme.brightness,
            scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
            primaryColor: theme.operatorBackground,
            canvasColor: theme.scaffoldBackgroundColor,
            cardColor: theme.keypadBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: theme.scaffoldBackgroundColor,
              foregroundColor: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
              elevation: 0,
            ),
          ),
          home: languageSelected ? CalculatorScreen(remoteConfig: remoteConfig) : LanguageSelectionScreen(remoteConfig: remoteConfig),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfig;
  const CalculatorScreen({super.key, required this.remoteConfig});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';
  bool _isScientificMode = true;
  bool _isShiftActive = false;
  bool _isAlphaActive = false;
  int _historyIndex = -1;
  bool _showEngineeringMode = false;
  bool _isPremium = false;
  int _aiCredits = 2;
  int _premiumDailyUses = 0;
  int _adRewardCount = 0;
  Map<String, int> _toolCredits = {
    'age': 2,
    'bmi': 2,
    'discount': 2,
    'tip': 2,
    'unit': 2,
    'finance': 2,
    'geometry': 2,
    'programmer': 2,
  };
  String _lastResetDate = '';
  List<String> _history = [];
  String _currentLanguage = 'TR';
  Map<String, String> translations = {};
  String _currentTheme = 'Classic';
  bool _isVibrationEnabled = true;
  bool _isSoundEnabled = true;
  bool _isAutoSaveHistory = true;
  int _decimalPlaces = 2;
  String _appVersion = '1.0.27';

  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoading = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoading = false;
  String? _pendingRewardType; // 'ai' or tool key
  // Callback to notify AISolverScreen of new credits after rewarded ad
  Function(int)? _pendingAICreditsCallback;
  // Flag: only sync credits to AISolverScreen when waiting for a reward (not after every solve)
  bool _isWaitingForRewardSync = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _loadTranslations();
    _setupPurchasesListener();
    _initApp();
    _syncFirestoreCredits();
  }

  Future<void> _syncFirestoreCredits() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            setState(() {
              _aiCredits = data['aiCredits'] ?? _aiCredits;
              _premiumDailyUses = data['premiumDailyUses'] ?? _premiumDailyUses;
              _adRewardCount = data['adRewardCount'] ?? _adRewardCount;
              _lastResetDate = data['lastResetDate'] ?? _lastResetDate;
              if (data['toolCredits'] != null) {
                _toolCredits = Map<String, int>.from(data['toolCredits']);
              }
            });
            // Notify AISolverScreen of updated credits (ONLY after a rewarded ad, not after every solve)
            if (_isWaitingForRewardSync) {
              _isWaitingForRewardSync = false;
              _pendingAICreditsCallback?.call(_aiCredits);
            }
            _saveSettings();
          }
        }
      });
    }
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint("Error loading version: $e");
    }
  }

  /// Loads settings from SharedPreferences, then immediately refreshes
  /// premium status from RevenueCat. Sequential order is critical:
  /// RevenueCat result must come AFTER SharedPreferences to avoid race condition.
  Future<void> _initApp() async {
    await _loadAppVersion();
    await _loadSettings();
    await _initTracking(); // iOS Tracking Permission
    await _refreshPremiumStatus();
    _checkVersionAndShowDialog();
    _loadRewardedAd();
    _loadInterstitialAd();
  }

  Future<void> _initTracking() async {
    if (!Platform.isIOS) return;
    
    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        // Wait a bit to ensure the app is fully resumed/active
        await Future.delayed(const Duration(milliseconds: 1000));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } catch (e) {
      debugPrint("ATT Error: $e");
    }
  }

  Future<void> _checkVersionAndShowDialog() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;
      final String minRequiredVersion = widget.remoteConfig.getString("force_update_min_version");

      if (_compareVersions(currentVersion, minRequiredVersion) < 0) {
        if (mounted) {
           _showUpdateDialog();
        }
      }
    } catch (e) {
      debugPrint("Version check error: $e");
    }
  }

  int _compareVersions(String v1, String v2) {
    List<int> parts1 = v1.split('.').map(int.parse).toList();
    List<int> parts2 = v2.split('.').map(int.parse).toList();
    for (var i = 0; i < max(parts1.length, parts2.length); i++) {
      int p1 = i < parts1.length ? parts1[i] : 0;
      int p2 = i < parts2.length ? parts2[i] : 0;
      if (p1 > p2) return 1;
      if (p1 < p2) return -1;
    }
    return 0;
  }

  void _showUpdateDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, anim1, anim2) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(translations['update_required'] ?? 'Update Required'),
            content: Text(translations['update_desc'] ?? 'A new version is available.'),
            actions: [
              TextButton(
                onPressed: () {
                  final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.botlab.calculator');
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: Text(translations['update_button'] ?? 'Update Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Fetches the latest CustomerInfo from RevenueCat to ensure premium status
  /// is always up-to-date, even after a fresh install or re-login.
  Future<void> _refreshPremiumStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      _updatePremiumStatus(customerInfo);
    } catch (e) {
      debugPrint('RevenueCat refresh failed: $e');
    }
  }

  void _setupPurchasesListener() {
    // Anlık satın alma takibi
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      _updatePremiumStatus(customerInfo);
    });
  }

  void _updatePremiumStatus(CustomerInfo customerInfo) {
    // Log actual entitlement keys for debugging (visible in logcat)
    final activeKeys = customerInfo.entitlements.active.keys.toList();
    debugPrint('RevenueCat active entitlements: $activeKeys');
    // Use the specific identifier 'premium' found in your dashboard.
    // Also checking 'Premium' just for extra safety.
    final isPremium = customerInfo.entitlements.active.containsKey('premium') || 
                      customerInfo.entitlements.active.containsKey('Premium');
    setState(() {
      _isPremium = isPremium;
    });
    _saveSettings();
    // Remove or show ads immediately based on subscription status
    _initAds();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentTheme = prefs.getString('theme') ?? 'Classic';
      CalculatorApp.themeNotifier.value = _currentTheme;
      _isVibrationEnabled = prefs.getBool('isVibrationEnabled') ?? true;
      _isSoundEnabled = prefs.getBool('isSoundEnabled') ?? true;
      _isAutoSaveHistory = prefs.getBool('isAutoSaveHistory') ?? true;
      _decimalPlaces = prefs.getInt('decimalPlaces') ?? 2;
      _currentLanguage = prefs.getString('language') ?? 'TR';
      _isPremium = prefs.getBool('isPremium') ?? false;
      _aiCredits = prefs.getInt('aiCredits') ?? 2;
      _premiumDailyUses = prefs.getInt('premiumDailyUses') ?? 0;
      _adRewardCount = prefs.getInt('adRewardCount') ?? 0;
      _lastResetDate = prefs.getString('lastResetDate') ?? '';
      
      final toolCreditsJson = prefs.getString('toolCredits');
      if (toolCreditsJson != null) {
        _toolCredits = Map<String, int>.from(jsonDecode(toolCreditsJson));
      }

      // Reload translations after language is loaded from prefs
      translations = AppTranslations.getTranslations(_currentLanguage);
    });
    _initAds();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _currentTheme);
    await prefs.setBool('isVibrationEnabled', _isVibrationEnabled);
    await prefs.setBool('isSoundEnabled', _isSoundEnabled);
    await prefs.setBool('isAutoSaveHistory', _isAutoSaveHistory);
    await prefs.setInt('decimalPlaces', _decimalPlaces);
    await prefs.setBool('isPremium', _isPremium);
    await prefs.setInt('aiCredits', _aiCredits);
    await prefs.setInt('premiumDailyUses', _premiumDailyUses);
    await prefs.setInt('adRewardCount', _adRewardCount);
    await prefs.setString('lastResetDate', _lastResetDate);
    await prefs.setString('toolCredits', jsonEncode(_toolCredits));
    _initAds();
  }

  void _loadRewardedAd() {
    if (_isPremium) return;
    setState(() => _isRewardedAdLoading = true);
    RewardedAd.load(
      adUnitId: Platform.isAndroid 
          ? 'ca-app-pub-9358975861980527/8575351982' 
          : 'ca-app-pub-9358975861980527/5090117710',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _rewardedAd = ad;
          setState(() => _isRewardedAdLoading = false);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          setState(() => _isRewardedAdLoading = false);
        },
      ),
    );
  }

  void _loadInterstitialAd() {
    if (_isPremium) return;
    if (_isInterstitialAdLoading) return;
    setState(() => _isInterstitialAdLoading = true);

    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-9358975861980527/3786830244'
          : 'ca-app-pub-9358975861980527/6403199388',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          setState(() => _isInterstitialAdLoading = false);
        },
        onAdFailedToLoad: (err) {
          debugPrint('InterstitialAd failed to load: $err');
          setState(() => _isInterstitialAdLoading = false);
        },
      ),
    );
  }

  void _showInterstitialAdIfReady(VoidCallback onComplete) {
    if (_isPremium || _interstitialAd == null) {
      onComplete();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd();
        onComplete();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd();
        onComplete();
      },
    );

    _interstitialAd!.show();
  }

  void _showRewardedAd(String type) {
    if (_rewardedAd == null) {
      _loadRewardedAd();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reklam henüz hazır değil, lütfen tekrar deneyin.')),
      );
      return;
    }
    _pendingRewardType = type;
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewardedAd();
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      _grantReward();
    });
  }

  Future<void> _grantReward() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _pendingRewardType == null) return;

    final analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(name: 'rewarded_ad_complete', parameters: {'type': _pendingRewardType!});

    if (_pendingRewardType == 'ai') {
      // Set flag so Firestore listener knows to notify AISolverScreen after this update
      _isWaitingForRewardSync = true;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'aiCredits': FieldValue.increment(2),
        'adRewardCount': FieldValue.increment(1),
      });
      // NOTE: Do NOT manually increment _aiCredits here.
      // _syncFirestoreCredits listener will pick up the Firestore change
      // and update _aiCredits + notify AISolverScreen automatically.
      _saveSettings();
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Icon(Icons.celebration, color: Colors.amber, size: 48),
            content: Text(
              translations['ai_credits_rewarded'] ?? 'Tebrikler! +2 AI Kredisi kazandınız.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else if (_toolCredits.containsKey(_pendingRewardType)) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'toolCredits.$_pendingRewardType': FieldValue.increment(2),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Tebrikler! +2 ${_pendingRewardType!.toUpperCase()} Kredisi kazandınız.')),
        );
      }
    }
    _pendingRewardType = null;
  }

  void _showAdRewardDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 8),
            Text(translations['credits_label'] ?? 'Kredi'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translations['ai_no_credits'] ?? 'Krediniz bitti. Premium ile sınırsız kullanımın keyfini çıkarın!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // PRIMARY: Premium button — big and prominent
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.workspace_premium, color: Colors.white),
                label: Text(
                  translations['purchase_premium'] ?? 'Premium Al',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showPremiumPurchase();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // SECONDARY: Watch ad — smaller, less prominent
            TextButton.icon(
              icon: const Icon(Icons.play_circle_outline, size: 18),
              label: Text(
                translations['watch_ad_btn'] ?? 'Reklam İzle (+2)',
                style: const TextStyle(fontSize: 13),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showRewardedAd(type);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                translations['cancel'] ?? 'İptal',
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initAds() {
    if (!_isPremium) {
      _loadBannerAd();
    } else {
      _bannerAd?.dispose();
      _bannerAd = null;
      setState(() {
        _isBannerAdReady = false;
      });
    }
  }

  void _loadBannerAd() async {
    final AnchoredAdaptiveBannerAdSize? size = 
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) return;

    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-9358975861980527/9782610572'
          : 'ca-app-pub-3940256099942544/2934735716',
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    )..load();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _history = prefs.getStringList('history') ?? [];
    });
  }

  Future<void> _saveToHistory(String expression, String result) async {
    if (!_isAutoSaveHistory) return;
    
    final prefs = await SharedPreferences.getInstance();
    final newEntry = '$expression = $result';
    setState(() {
      _history.insert(0, newEntry);
      if (_history.length > 50) {
        _history = _history.take(50).toList();
      }
      _historyIndex = -1;
    });
    await prefs.setStringList('history', _history);
  }

  void _onNavArrowUp() {
    if (_history.isEmpty) return;
    if (_historyIndex < _history.length - 1) {
      if (_isVibrationEnabled) HapticFeedback.lightImpact();
      setState(() {
        _historyIndex++;
        String exp = _history[_historyIndex].split(' = ')[0];
        _expression = exp;
      });
    }
  }

  void _onNavArrowDown() {
    if (_history.isEmpty) return;
    if (_historyIndex > 0) {
      if (_isVibrationEnabled) HapticFeedback.lightImpact();
      setState(() {
        _historyIndex--;
        String exp = _history[_historyIndex].split(' = ')[0];
        _expression = exp;
      });
    } else if (_historyIndex == 0) {
      if (_isVibrationEnabled) HapticFeedback.lightImpact();
      setState(() {
        _historyIndex = -1;
        _expression = '';
      });
    }
  }

  void _onNavArrowLeft() {
    if (_isVibrationEnabled) HapticFeedback.lightImpact();
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    });
  }

  void _onNavArrowRight() {
    if (_isVibrationEnabled) HapticFeedback.lightImpact();
    setState(() {
      _expression += ' ';
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', _history);
  }

  void _loadTranslations() {
    setState(() {
      translations = AppTranslations.getTranslations(_currentLanguage);
    });
  }

  void _onButtonPressed(String buttonText) {
    if (_isVibrationEnabled) {
      HapticFeedback.lightImpact();
    }
    if (_isSoundEnabled) {
      SystemSound.play(SystemSoundType.click);
    }
    setState(() {
      if (buttonText == 'AC') {
        _expression = '';
        _result = '';
      } else if (buttonText == 'DEL') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'Ans') {
        if (_result.isNotEmpty) {
          _expression += _result;
        }
      } else if (buttonText == '+/-') {
        if (_expression.isNotEmpty) {
          if (_expression.startsWith('-')) {
            _expression = _expression.substring(1);
          } else {
            _expression = '-' + _expression;
          }
        }
      } else if (buttonText == 'π') {
        _expression += '3.14159';
      } else if (buttonText == 'e') {
        _expression += '2.71828';
      } else if (buttonText == 'φ') {
        _expression += '1.61803';
      } else if (buttonText == '^') {
        _expression += '^';
      } else if (buttonText == 'x!') {
        _expression += '!';
      } else if (buttonText == '√') {
        _expression += '√(';
      } else if (buttonText == '∛') {
        _expression += '∛(';
      } else if (buttonText == '|x|') {
        _expression += '|(';
      } else if (buttonText == '1/x') {
        _expression += '1/(';
      } else if (buttonText == 'x²') {
        _expression += '^2';
      } else if (buttonText == 'x³') {
        _expression += '^3';
      } else if (buttonText == '×10ˣ') {
        _expression += '*10^';
      } else if (buttonText == 'rand') {
        _expression += (Random().nextDouble()).toStringAsFixed(4);
      } else if (buttonText == 'MENU') {
      } else if (buttonText == 'HIST') {
        _showHistory();
      } else {
        if (_isOperator(buttonText) && _expression.isNotEmpty && _isOperator(_expression[_expression.length - 1])) {
          _expression = _expression.substring(0, _expression.length - 1) + buttonText;
        } else {
          _expression += buttonText;
        }
      }
    });
  }

  void _onSecondaryPressed(String secondary) {
    if (_isVibrationEnabled) HapticFeedback.lightImpact();
    if (_isSoundEnabled) SystemSound.play(SystemSoundType.click);

    setState(() {
      if (secondary == 'CLR') {
        _expression = ''; _result = '';
      } else if (secondary == 'SOLVE') {
        _calculateResult();
      } else if (secondary == 'x³') {
        _expression += '^3';
      } else if (secondary == '∛') {
        _expression += '∛(';
      } else if (secondary == '10^x') {
        _expression += '10^(';
      } else if (secondary == 'e^x') {
        _expression += 'e^(';
      } else if (secondary == '← ') {
        if (_expression.isNotEmpty) _expression = _expression.substring(0, _expression.length - 1);
      } else if (secondary == 'sin⁻¹') {
        _expression += 'arcsin(';
      } else if (secondary == 'cos⁻¹') {
        _expression += 'arccos(';
      } else if (secondary == 'tan⁻¹') {
        _expression += 'arctan(';
      } else if (secondary == 'Rnd') {
        _expression += (Random().nextDouble()).toStringAsFixed(4);
      } else if (secondary == 'π') {
        _expression += '3.141592653589793';
      } else if (secondary == 'φ') {
        _expression += '1.618033988749895';
      } else if (secondary == 'd/dx') {
        _expression += 'd/dx(';
      } else if (secondary == 'y') {
        _expression += 'y';
      } else if (secondary == ';') {
        _expression += ';';
      }
      else {
        _expression += secondary;
      }
      _isShiftActive = false;
    });
  }

  void _showGuidePopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Guide',
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: const Color(0xFF2C2C2E).withOpacity(0.85),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(20),
            title: Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.orange),
                const SizedBox(width: 10),
                Text(translations['guide_title']!, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGuideSection(translations['guide_mod_title']!, translations['guide_mod_desc']!),
                    _buildGuideSection(translations['guide_nav_title']!, translations['guide_nav_desc']!),
                    _buildGuideSection(translations['guide_integral_title']!, translations['guide_integral_desc']!),
                    _buildGuideSection(translations['guide_ai_title']!, translations['guide_ai_desc']!),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(translations['close']!.toUpperCase(), style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }

  bool _isOperator(String text) {
    return ['+', '-', '×', '÷', '%'].contains(text);
  }

  double _evaluateIntegral(String funcExpr, double a, double b) {
    int n = 1000;
    double h = (b - a) / n;
    double sum1 = 0;
    double sum2 = 0;
    
    Parser p = Parser();
    Expression exp = p.parse(funcExpr);
    ContextModel cm = ContextModel();
    
    for (int i = 1; i <= n - 1; i++) {
      double x = a + i * h;
      cm.bindVariableName('x', Number(x));
      double fx = exp.evaluate(EvaluationType.REAL, cm);
      if (i % 2 == 0) sum2 += fx;
      else sum1 += fx;
    }
    
    cm.bindVariableName('x', Number(a));
    double fa = exp.evaluate(EvaluationType.REAL, cm);
    cm.bindVariableName('x', Number(b));
    double fb = exp.evaluate(EvaluationType.REAL, cm);
    
    return (h / 3) * (fa + 4 * sum1 + 2 * sum2 + fb);
  }

  void _calculateResult() {
    try {
      String expr = _expression;
      
      final RegExp integralRegex = RegExp(r'∫\(([^,]+),([^,]+),([^)]+)\)');
      expr = expr.replaceAllMapped(integralRegex, (match) {
        String func = match.group(1)!;
        String lowerStr = match.group(2)!;
        String upperStr = match.group(3)!;
        
        Parser p = Parser();
        double a = p.parse(lowerStr).evaluate(EvaluationType.REAL, ContextModel());
        double b = p.parse(upperStr).evaluate(EvaluationType.REAL, ContextModel());
        
        double val = _evaluateIntegral(func, a, b);
        return val.toString();
      });
      
      expr = expr.replaceAll('×', '*');
      expr = expr.replaceAll('÷', '/');
      expr = expr.replaceAll('π', '3.141592653589793');
      expr = expr.replaceAll('e', '2.718281828459045');
      expr = expr.replaceAll('φ', '1.618033988749895');
      expr = expr.replaceAll('√(', 'sqrt(');
      expr = expr.replaceAll('√', 'sqrt');
      expr = expr.replaceAll('∛(', 'nrt(3,');
      expr = expr.replaceAll('|(', 'abs(');
      expr = expr.replaceAll('|', 'abs');

      int openBrackets = 0;
      for (int i = 0; i < expr.length; i++) {
        if (expr[i] == '(') openBrackets++;
        if (expr[i] == ')') openBrackets--;
      }
      while (openBrackets > 0) {
        expr += ')';
        openBrackets--;
      }
      
      Parser p = Parser();
      Expression expression = p.parse(expr);
      ContextModel cm = ContextModel();
      cm.bindVariableName('x', Number(0));
      double eval = expression.evaluate(EvaluationType.REAL, cm);
      
      String result = eval.toStringAsFixed(_decimalPlaces);
      if (result.endsWith('.00')) {
          result = result.substring(0, result.length - 3);
      }
      
      setState(() {
        _result = result;
      });
      
      _saveToHistory(_expression, _result);
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  Widget _buildCasioKey({
    required String label,
    String? secondary,
    Color? bgColor,
    Color? labelColor,
    Color? secondaryColor,
    int flex = 1,
    VoidCallback? onTap,
    double fontSize = 13,
  }) {
    VoidCallback finalOnTap = () {
      if (_isShiftActive && secondary != null && secondary.isNotEmpty) {
        _onSecondaryPressed(secondary);
      } else {
        if (onTap != null) {
          onTap();
        } else {
          _onButtonPressed(label);
        }
      }
    };

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.5),
        child: Column(
          children: [
            if (secondary != null)
              Text(
                secondary,
                style: TextStyle(
                  color: secondaryColor ?? const Color(0xFFF5A623),
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              )
            else
              const SizedBox(height: 9.0),
            const SizedBox(height: 3),
            Expanded(
              child: GestureDetector(
                onTap: finalOnTap,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor ?? const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: labelColor ?? Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['history']!),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: _history.isEmpty
                ? Center(child: Text(translations['no_history']!))
                : ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_history[index]),
                        onTap: () {
                          setState(() {
                            final parts = _history[index].split(' = ');
                            if (parts.length == 2) {
                              _expression = parts[0];
                              _result = parts[1];
                            }
                          });
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _history.clear();
                });
                _saveHistory();
                Navigator.of(context).pop();
              },
              child: Text(translations['clear_history']!),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translations['close']!),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['select_language']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('TR', 'Türkçe'),
              _buildLanguageOption('EN', 'English'),
              _buildLanguageOption('ES', 'Español'),
              _buildLanguageOption('DE', 'Deutsch'),
              _buildLanguageOption('AR', 'العربية'),
              _buildLanguageOption('FR', 'Français'),
              _buildLanguageOption('PT', 'Português'),
              _buildLanguageOption('RU', 'Русский'),
              _buildLanguageOption('HI', 'हिन्दी'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    return ListTile(
      title: Text(name),
      trailing: _currentLanguage == code ? const Icon(Icons.check) : null,
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language', code);
        setState(() {
          _currentLanguage = code;
        });
        _loadTranslations();
        Navigator.of(context).pop();
      },
    );
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['settings']!),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ListTile(
                    title: Text(translations['theme'] ?? 'Theme'),
                    subtitle: Text(_currentTheme),
                    trailing: DropdownButton<String>(
                      value: _currentTheme,
                      items: ['Classic', 'Dark', 'Pink', 'Orange'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _currentTheme = value;
                            CalculatorApp.themeNotifier.value = _currentTheme;
                          });
                          _saveSettings();
                        }
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text(translations['vibration']!),
                    value: _isVibrationEnabled,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red.withOpacity(0.5),
                    onChanged: (value) {
                      setState(() {
                        _isVibrationEnabled = value;
                      });
                      _saveSettings();
                    },
                  ),
                  SwitchListTile(
                    title: Text(translations['sound_effects']!),
                    value: _isSoundEnabled,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red.withOpacity(0.5),
                    onChanged: (value) {
                      setState(() {
                        _isSoundEnabled = value;
                      });
                      _saveSettings();
                    },
                  ),
                  SwitchListTile(
                    title: Text(translations['auto_save_history']!),
                    value: _isAutoSaveHistory,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red.withOpacity(0.5),
                    onChanged: (value) {
                      setState(() {
                        _isAutoSaveHistory = value;
                      });
                      _saveSettings();
                    },
                  ),
                  ListTile(
                    title: Text(translations['decimal_places']!),
                    subtitle: Text('$_decimalPlaces'),
                    trailing: DropdownButton<int>(
                      value: _decimalPlaces,
                      items: [0, 1, 2, 3, 4, 5, 6].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() {
                            _decimalPlaces = value;
                          });
                          _saveSettings();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translations['close']!),
            ),
          ],
        );
      },
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['about_app']!),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translations['about_desc']!),
                const SizedBox(height: 20),
                Text('${translations['version']!}: $_appVersion'),
                const SizedBox(height: 20),
                Text(
                  translations['company']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(translations['company_desc']!),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translations['close']!),
            ),
          ],
        );
      },
    );
  }

  void _showPremiumPurchase() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['premium_purchase']!),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.diamond,
                  size: 64,
                  color: Colors.amber,
                ),
                const SizedBox(height: 20),
                Text(
                  translations['premium_desc']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildPremiumFeature(translations['ad_free']!),
                    _buildPremiumFeature(translations['custom_themes']!),
                    _buildPremiumFeature(translations['advanced_functions']!),
                    _buildPremiumFeature(translations['unlimited_history']!),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translations['cancel']!),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await RevenueCatUI.presentPaywallIfNeeded("Premium");
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ödeme sayfası yüklenemedi: $e')),
                    );
                  }
                }
              },
              child: Text(translations['purchase_premium']!),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPremiumFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Text(feature),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, Color color, VoidCallback onTap, {required Brightness brightness}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title, 
        style: TextStyle(
          color: brightness == Brightness.dark ? Colors.white : Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = CalculatorThemes.getTheme(_currentTheme);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3478F6), Color(0xFF0A2A6E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Text(
                    translations['app_title']?.toUpperCase() ?? 'BOTMATH HESAP MAKİNESİ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isPremium ? '★ PREMIUM' : (translations['free_credits'] ?? 'Ücretsiz Hak: {0}').replaceAll('{0}', '$_aiCredits'),
                    style: const TextStyle(color: Color(0xFFF5A623), fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerTile(Icons.psychology, translations['ai_solver'] ?? 'AI Çözücü', Colors.amber, () {
              Navigator.of(context).pop();
              final theme = CalculatorThemes.getTheme(_currentTheme);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AISolverScreen(
                  translations: translations,
                  theme: theme,
                  isPremium: _isPremium,
                  aiCredits: _aiCredits,
                  premiumDailyUses: _premiumDailyUses,
                  onCreditUsed: (r) => setState(() { _aiCredits = r; _saveSettings(); }),
                  onPremiumCreditUsed: (r) => setState(() { _premiumDailyUses = r; _saveSettings(); }),
                  onPremiumRestored: () => _refreshPremiumStatus(),
                  onOutOfCredits: () => _showAdRewardDialog('ai'),
                  currentLanguage: _currentLanguage,
                  showInterstitialAd: _showInterstitialAdIfReady,
                  onCreditsRestored: (newCredits, callback) {
                    // Just store the callback — no setState here (would cause build error)
                    _pendingAICreditsCallback = callback;
                  },
                ),
              ));
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.grid_view, translations['tools'] ?? 'Araçlar', Colors.blue, () {
              Navigator.of(context).pop();
              final theme = CalculatorThemes.getTheme(_currentTheme);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ToolsScreen(
                  translations: translations, 
                  theme: theme, 
                  isPremium: _isPremium,
                  toolCredits: _toolCredits,
                  onUseTool: (tool) async {
                    if (!_isPremium) {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                          'toolCredits.$tool': FieldValue.increment(-1),
                        });
                      }
                    }
                  },
                  onOutOfCredits: (tool) => _showAdRewardDialog(tool),
                ),
              ));
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.diamond, translations['premium_purchase'] ?? 'Premium Satın Al', const Color(0xFFF5A623), () {
              Navigator.of(context).pop();
              _showPremiumPurchase();
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.history, translations['history'] ?? 'Geçmiş', Colors.teal, () {
              Navigator.of(context).pop();
              _showHistory();
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.settings, translations['settings'] ?? 'Ayarlar', Colors.grey, () {
              Navigator.of(context).pop();
              _showSettings();
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.language, translations['language'] ?? 'Dil', Colors.green, () {
              Navigator.of(context).pop();
              _showLanguageDialog();
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.info, translations['about'] ?? 'Hakkında', Colors.blueGrey, () {
              Navigator.of(context).pop();
              _showAbout();
            }, brightness: theme.brightness),
            const Divider(color: Color(0xFF3A3A3A)),
            _buildDrawerTile(Icons.share, translations['share_app'] ?? 'Paylaş', Colors.purple, () {
              Navigator.of(context).pop();
              Share.share(translations['share_message']!);
            }, brightness: theme.brightness),
            _buildDrawerTile(Icons.star, translations['rate_app'] ?? 'Uygulamayı Oyla', Colors.orange, () {
              Navigator.of(context).pop();
              final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.botlab.calculator');
              launchUrl(url, mode: LaunchMode.externalApplication);
            }, brightness: theme.brightness),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                decoration: BoxDecoration(
                  color: theme.displayBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: theme.borderColor, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              _isPremium ? '★ PREMIUM' : 'MATH',
                              style: TextStyle(
                                color: theme.displayTextColor,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _isShiftActive ? '[S]' : (_isAlphaActive ? '[A]' : ''),
                              style: TextStyle(
                                color: theme.displayTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        ),
                        Row(
                          children: [
                            if (!_isPremium)
                              BlinkingPremiumButton(
                                translations: translations,
                                onTap: () {
                                  final theme = CalculatorThemes.getTheme(_currentTheme);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PremiumOfferScreen(
                                        translations: translations,
                                        theme: theme,
                                        remoteConfig: widget.remoteConfig,
                                        onContinue: () {
                                          Navigator.of(context).pop();
                                          _refreshPremiumStatus();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            GestureDetector(
                              onTap: _showHistory,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(Icons.history, color: theme.displayTextColor, size: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: _showGuidePopup,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(Icons.help_outline, color: theme.displayTextColor, size: 16),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _isScientificMode ? 'SCI' : '',
                              style: TextStyle(
                                color: theme.displayTextColor,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Text(
                            _expression.isEmpty ? ' ' : _expression,
                            style: TextStyle(
                              fontSize: 32,
                              color: theme.displayTextColor,
                              fontFamily: 'monospace',
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _result.isEmpty ? '0' : _result,
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: theme.displayTextColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ——— TOP CONTROL ROW: SHIFT | ALPHA | NAV PAD | MENU | ON ———
            SizedBox(
              height: 65,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(
                children: [
                  _buildCasioKey(label: 'SHIFT', bgColor: theme.functionBackground, labelColor: theme.functionTextColor, fontSize: 10, onTap: () => setState(() => _isShiftActive = !_isShiftActive)),
                  _buildCasioKey(label: 'ALPHA', bgColor: theme.functionBackground, labelColor: theme.functionTextColor, fontSize: 10, onTap: () => setState(() => _isAlphaActive = !_isAlphaActive)),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 44,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: theme.functionBackground,
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          Positioned(
                            top: 0, 
                            child: GestureDetector(
                              onTap: _onNavArrowUp,
                              child: Container(color: Colors.transparent, padding: const EdgeInsets.all(4), child: const Icon(Icons.keyboard_arrow_up, color: Colors.white70, size: 14)),
                            ),
                          ),
                          Positioned(
                            bottom: 0, 
                            child: GestureDetector(
                              onTap: _onNavArrowDown,
                              child: Container(color: Colors.transparent, padding: const EdgeInsets.all(4), child: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 14)),
                            ),
                          ),
                          Positioned(
                            left: 0, 
                            child: GestureDetector(
                              onTap: _onNavArrowLeft,
                              child: Container(color: Colors.transparent, padding: const EdgeInsets.all(4), child: const Icon(Icons.keyboard_arrow_left, color: Colors.white70, size: 14)),
                            ),
                          ),
                          Positioned(
                            right: 0, 
                            child: GestureDetector(
                              onTap: _onNavArrowRight,
                              child: Container(color: Colors.transparent, padding: const EdgeInsets.all(4), child: const Icon(Icons.keyboard_arrow_right, color: Colors.white70, size: 14)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _onButtonPressed('='),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(color: theme.buttonBackground, shape: BoxShape.circle),
                              child: Center(child: Text('OK', style: TextStyle(color: theme.buttonTextColor, fontSize: 7, fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildCasioKey(label: 'MENU', bgColor: theme.functionBackground, labelColor: theme.functionTextColor, fontSize: 10, onTap: () => _scaffoldKey.currentState?.openDrawer()),
                  _buildCasioKey(label: 'ON', bgColor: theme.actionBackground, labelColor: theme.actionTextColor, fontSize: 10, onTap: () => setState(() { _expression = ''; _result = ''; })),
                ],
              ),
            ),
          ),

            // ——— ALL BUTTON ROWS (uniform grid) ————————————————————————
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 4),
                child: Column(
                  children: [
                    // Function Row 1: OPTN CALC x² x^a log f(-) ln
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '∫', secondary: 'd/dx', fontSize: 16, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('∫(')),
                          _buildCasioKey(label: 'x', secondary: 'y', fontSize: 16, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('x')),
                          _buildCasioKey(label: ',', secondary: ';', fontSize: 16, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed(',')),
                          _buildCasioKey(label: 'x²', secondary: 'x³', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('^2')),
                          _buildCasioKey(label: 'x^a', secondary: '∛', fontSize: 10, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('^')),
                          _buildCasioKey(label: 'log', secondary: '10^x', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('log(')),
                          _buildCasioKey(label: 'ln', secondary: 'e^x', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('ln(')),
                        ],
                      ),
                    ),
                    // Function Row 2: (-) °'" x⁻¹ sin cos tan
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '(-)', secondary: 'DRG', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('+/-')),
                          _buildCasioKey(label: "°'\"", secondary: '← ', fontSize: 9, bgColor: theme.functionBackground, labelColor: theme.functionTextColor),
                          _buildCasioKey(label: 'x⁻¹', secondary: 'FRAC', fontSize: 10, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('1/')),
                          _buildCasioKey(label: 'sin', secondary: 'sin⁻¹', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('sin(')),
                          _buildCasioKey(label: 'cos', secondary: 'cos⁻¹', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('cos(')),
                          _buildCasioKey(label: 'tan', secondary: 'tan⁻¹', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('tan(')),
                        ],
                      ),
                    ),
                    // Function Row 3: STO ENG Abs ) S⇔D M+
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: 'STO', secondary: 'RCL', fontSize: 10, bgColor: theme.functionBackground, labelColor: theme.functionTextColor),
                          _buildCasioKey(label: 'ENG', secondary: '← ENG', fontSize: 10, bgColor: theme.functionBackground, labelColor: theme.functionTextColor),
                          _buildCasioKey(label: 'Abs', secondary: 'HYP', fontSize: 10, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed('|x|')),
                          _buildCasioKey(label: ')', secondary: '(', fontSize: 13, bgColor: theme.functionBackground, labelColor: theme.functionTextColor, onTap: () => _onButtonPressed(')')),
                          _buildCasioKey(label: 'S⇔D', secondary: 'CONV', fontSize: 9, bgColor: theme.functionBackground, labelColor: theme.functionTextColor),
                          _buildCasioKey(label: 'M+', secondary: 'M-', fontSize: 11, bgColor: theme.functionBackground, labelColor: theme.functionTextColor),
                        ],
                      ),
                    ),
                    // Numpad Row 1: 7 8 9 DEL AC
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '7', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '8', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '9', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: 'DEL', secondary: 'INS', bgColor: theme.actionBackground, labelColor: theme.actionTextColor, fontSize: 11, onTap: () => _onButtonPressed('DEL')),
                          _buildCasioKey(label: 'AC', bgColor: theme.actionBackground, labelColor: theme.actionTextColor, fontSize: 13, onTap: () => _onButtonPressed('AC')),
                        ],
                      ),
                    ),
                    // Numpad Row 2: 4 5 6 × ÷
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '4', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '5', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '6', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '×', bgColor: theme.operatorBackground, labelColor: theme.operatorTextColor, fontSize: 16, onTap: () => _onButtonPressed('×')),
                          _buildCasioKey(label: '÷', bgColor: theme.operatorBackground, labelColor: theme.operatorTextColor, fontSize: 16, onTap: () => _onButtonPressed('÷')),
                        ],
                      ),
                    ),
                    // Numpad Row 3: 1 2 3 + -
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '1', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '2', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '3', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '+', bgColor: theme.operatorBackground, labelColor: theme.operatorTextColor, fontSize: 16, onTap: () => _onButtonPressed('+')),
                          _buildCasioKey(label: '-', bgColor: theme.operatorBackground, labelColor: theme.operatorTextColor, fontSize: 16, onTap: () => _onButtonPressed('-')),
                        ],
                      ),
                    ),
                    // Numpad Row 4: 0 . ×10ˣ Ans =
                    Expanded(
                      child: Row(
                        children: [
                          _buildCasioKey(label: '0', secondary: 'Rnd', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '.', secondary: 'π', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 16),
                          _buildCasioKey(label: '×10ˣ', secondary: 'φ', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 11, onTap: () => _onButtonPressed('×10ˣ')),
                          _buildCasioKey(label: 'Ans', bgColor: theme.buttonBackground, labelColor: theme.buttonTextColor, fontSize: 12, onTap: () => _onButtonPressed('Ans')),
                          _buildCasioKey(label: '=', bgColor: theme.operatorBackground, labelColor: theme.operatorTextColor, fontSize: 18, onTap: () => _onButtonPressed('=')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_isBannerAdReady && _bannerAd != null && !_isPremium)
              Container(
                width: double.infinity,
                height: _bannerAd!.size.height.toDouble(),
                alignment: Alignment.center,
                child: AdWidget(ad: _bannerAd!),
              ),
          ],
        ),
      ),
    );
  }
}

class CommonBannerAd extends StatefulWidget {
  final bool isPremium;
  final AdSize adSize;

  const CommonBannerAd({
    super.key,
    required this.isPremium,
    this.adSize = AdSize.banner,
  });

  @override
  State<CommonBannerAd> createState() => _CommonBannerAdState();
}

class _CommonBannerAdState extends State<CommonBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isPremium) {
      _loadAd();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() async {
    AdSize size = widget.adSize;
    
    // If it's a standard banner, we try to make it adaptive if it matches the banner height
    if (size == AdSize.banner) {
      final AnchoredAdaptiveBannerAdSize? adaptiveSize = 
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
              MediaQuery.of(context).size.width.truncate());
      if (adaptiveSize != null) {
        size = adaptiveSize;
      }
    }

    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-9358975861980527/9782610572'
          : 'ca-app-pub-3940256099942544/2934735716',
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) {
            setState(() {
              _isAdLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          if (mounted) {
            setState(() {
              _isAdLoaded = false;
            });
          }
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPremium || !_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      height: _bannerAd!.size.height.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}


class AISolverScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;
  final int aiCredits;
  final int premiumDailyUses;
  final Function(int) onCreditUsed;
  final Function(int) onPremiumCreditUsed;
  final VoidCallback? onPremiumRestored;
  final VoidCallback? onOutOfCredits;
  final String currentLanguage;
  final Function(VoidCallback) showInterstitialAd;
  // Called with (currentCredits, updateCallback) so parent can push credit changes back
  final Function(int, Function(int))? onCreditsRestored;

  const AISolverScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
    required this.aiCredits,
    required this.premiumDailyUses,
    required this.onCreditUsed,
    required this.onPremiumCreditUsed,
    this.onPremiumRestored,
    this.onOutOfCredits,
    required this.currentLanguage,
    required this.showInterstitialAd,
    this.onCreditsRestored,
  });

  @override
  State<AISolverScreen> createState() => _AISolverScreenState();
}

class _AISolverScreenState extends State<AISolverScreen> {
  File? _selectedImage;
  bool _isSolving = false;
  bool _isCooldown = false;
  String? _solution;
  final finalImagePicker = ImagePicker();
  final _aiService = AIService();
  late int _localCredits;
  late int _localPremiumUses;
  bool _localIsPremium = false;

  @override
  void initState() {
    super.initState();
    _localCredits = widget.aiCredits;
    _localPremiumUses = widget.premiumDailyUses;
    _localIsPremium = widget.isPremium;
    // Register callback so parent can push credit updates (e.g. after rewarded ad)
    widget.onCreditsRestored?.call(_localCredits, (newCredits) {
      if (mounted) {
        setState(() {
          _localCredits = newCredits;
        });
      }
    });
    // Also do a fresh check from RevenueCat when screen opens
    _checkPremiumOnOpen();
  }

  Future<void> _checkPremiumOnOpen() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final activeKeys = customerInfo.entitlements.active.keys.toList();
      debugPrint('AISolver - RevenueCat active entitlements: $activeKeys');
      // Check specifically for 'premium' or 'Premium' ID
      final isPremium = customerInfo.entitlements.active.containsKey('premium') || 
                        customerInfo.entitlements.active.containsKey('Premium');
      if (mounted && isPremium != _localIsPremium) {
        setState(() {
          _localIsPremium = isPremium;
        });
        if (isPremium) {
          widget.onPremiumRestored?.call();
        }
      }
    } catch (e) {
      debugPrint('AISolver premium check failed: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_localIsPremium) {
       if (_localPremiumUses >= 15) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Günlük soru limitinize (15) ulaştınız. Yarın tekrar deneyin.')),
         );
         return;
       }
    } else {
       if (_localCredits <= 0) {
         widget.onOutOfCredits?.call();
         return;
       }
    }
    
    try {
      final XFile? image = await finalImagePicker.pickImage(source: source);
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Soruyu Kırp',
                toolbarColor: widget.theme.operatorBackground,
                toolbarWidgetColor: widget.theme.operatorTextColor,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Soruyu Kırp',
            ),
          ],
        );

        if (croppedFile != null) {
          setState(() {
            _selectedImage = File(croppedFile.path);
            _solution = null;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _solveEquation() async {
    if (_selectedImage == null) return;
    if (_isCooldown) return;
    
    if (_localIsPremium) {
       if (_localPremiumUses >= 15) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Günlük soru limitine (15) ulaştınız. Yarın tekrar deneyin.')),
         );
         return;
       }
    } else {
       if (_localCredits <= 0) {
         widget.onOutOfCredits?.call();
         return;
       }
    }

    setState(() {
      _isSolving = true;
      _isCooldown = true;
      _solution = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Oturum açılmadı.");
      
      final appUserId = user.uid;
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      final result = await _aiService.solveImage(_selectedImage!, appUserId, appVersion, !_localIsPremium, widget.currentLanguage);
      
      if (!mounted) return;

      setState(() {
        if (_localIsPremium) {
          _localPremiumUses += 1;
        } else {
          _localCredits = (_localCredits - 1).clamp(0, 999);
        }
        _isSolving = false;
        _solution = result;
      });
      
      if (_localIsPremium) {
        widget.onPremiumCreditUsed(_localPremiumUses);
      } else {
        widget.onCreditUsed(_localCredits);
      }

      // Save to AI History
      if (_selectedImage != null && _solution != null) {
        AIHistoryService.saveEntry(_selectedImage!, _solution!);
      }

      // 3 Saniye Cooldown Koruması
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isCooldown = false;
          });
        }
      });

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSolving = false;
        _isCooldown = false;
      });
      
      String errorMsg = e.toString();
      if (errorMsg.contains('network_error') || errorMsg.contains('unavailable') || errorMsg.contains('network') || errorMsg.contains('connection')) {
        errorMsg = widget.translations['no_internet'] ?? 'Lütfen internet bağlantınızı kontrol edin.';
      } else if (errorMsg.contains('failed-precondition')) {
        errorMsg = widget.translations['update_desc'] ?? 'Lütfen uygulamayı güncelleyin.';
        _showUpdateDialog();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 8),
            action: SnackBarAction(
              label: widget.translations['update_button'] ?? 'GÜNCELLE',
              textColor: Colors.white,
              onPressed: () {
                final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.botlab.calculator');
                launchUrl(url, mode: LaunchMode.externalApplication);
              },
            ),
          ),
        );
        return; 
      } else if (errorMsg.contains('permission-denied')) {
        errorMsg = widget.translations['premium_required'] ?? 'Bu özellik için aktif bir Premium abonelik gereklidir.';
        _showPurchaseDialog();
      } else {
        errorMsg = errorMsg.replaceAll('Exception: ', ''); // "Exception: " kısmını temizle
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _shareAsPdf() async {
    if (_solution == null) return;
    await PDFService.generateAndShare(
      solution: _solution!,
      imageFile: _selectedImage,
      shareMessage: widget.translations['share_ai_message'] ?? 'AI ile çözülen probleme bak!',
      title: widget.translations['ai_solver'] ?? 'AI Çözücü',
    );
  }

  void _showUpdateDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, anim1, anim2) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(widget.translations['update_required'] ?? 'Update Required'),
            content: Text(widget.translations['update_desc'] ?? 'A new version is available.'),
            actions: [
              TextButton(
                onPressed: () {
                  final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.botlab.calculator');
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: Text(widget.translations['update_button'] ?? 'Update Now'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPurchaseDialog() async {
    try {
      await RevenueCatUI.presentPaywallIfNeeded('Premium');
      // After paywall closes, re-check actual subscription status from RevenueCat
      final customerInfo = await Purchases.getCustomerInfo();
      final activeKeys = customerInfo.entitlements.active.keys.toList();
      debugPrint('Paywall closed - RevenueCat active entitlements: $activeKeys');
      final isPremium = customerInfo.entitlements.active.containsKey('premium') || 
                        customerInfo.entitlements.active.containsKey('Premium');
      if (mounted && isPremium) {
        setState(() {
          _localIsPremium = true;
        });
        // Notify parent CalculatorScreen to also update its premium state
        widget.onPremiumRestored?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ödeme sayfası yüklenemedi: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;
    final cardColor = theme.keypadBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.translations['ai_solver'] ?? 'AI Çözücü'),
        backgroundColor: widget.theme.operatorBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                children: [
                   Text(
                    _localIsPremium
                      ? 'Günlük Kalan Limitiniz: ${100 - _localPremiumUses}'
                      : (widget.translations['free_credits'] ?? 'Ücretsiz Hak: {0}').replaceAll('{0}', '${_localCredits.clamp(0, 999)}'),
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _localIsPremium
                      ? (widget.translations['daily_limit_renews'] ?? 'Her gece 00:00\'da 100 hak yenilenir.')
                      : (widget.translations['ai_freemium_desc'] ?? 'Ücretsiz hak: {0} | Premium\'a geç → Sınırsız!')
                          .replaceAll('{0}', '${_localCredits.clamp(0, 999)}'),
                    style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  widget.showInterstitialAd(() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AIHistoryScreen(
                        translations: widget.translations,
                        isPremium: _localIsPremium,
                      ),
                    ));
                  });
                },
                icon: const Icon(Icons.history, color: Colors.blue),
                label: Text(
                  widget.translations['ai_history'] ?? 'Geçmiş Çözümler',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 10),
             Text(
              widget.translations['ai_desc'] ?? 'Take a photo to solve!',
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, size: 64, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 10),
                         Text(
                          'No Image Selected',
                          style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(widget.translations['take_photo'] ?? 'Camera'),
                  style: ElevatedButton.styleFrom(backgroundColor: theme.operatorBackground, foregroundColor: theme.operatorTextColor),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: Text(widget.translations['pick_gallery'] ?? 'Gallery'),
                  style: ElevatedButton.styleFrom(backgroundColor: theme.buttonBackground, foregroundColor: theme.buttonTextColor),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedImage != null && !_isSolving) ? _solveEquation : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green, // Keep success green for solve button
                  disabledBackgroundColor: Colors.grey,
                ),
                child: _isSolving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        widget.translations['solve'] ?? 'SOLVE',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            if (_solution != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4), // Darker background for visibility
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: SelectionArea(
                  child: Text(
                    _solution!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _shareAsPdf,
                  icon: const Icon(Icons.share),
                  label: Text(widget.translations['share'] ?? 'Paylaş'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
          ],
        ),
      ),
    );
  }
}

class ToolsScreen extends StatelessWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;
  final Map<String, int> toolCredits;
  final Function(String) onUseTool;
  final Function(String) onOutOfCredits;

  const ToolsScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
    required this.toolCredits,
    required this.onUseTool,
    required this.onOutOfCredits,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(translations['tools'] ?? 'Tools', style: TextStyle(color: textColor)),
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildToolCard(
                  context,
                  Icons.swap_horiz,
                  translations['unit_converter'] ?? 'Unit Converter',
                  Colors.orange,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnitConverterScreen(
                        translations: translations,
                        theme: theme,
                        isPremium: isPremium,
                      ),
                    ),
                  ),
                ),
                _buildToolCard(
                  context,
                  Icons.code,
                  translations['programmer'] ?? 'Programmer',
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgrammerCalculatorScreen(
                        translations: translations,
                        theme: theme,
                        isPremium: isPremium,
                      ),
                    ),
                  ),
                ),
                _buildToolCard(
                  context,
                  Icons.change_history,
                  translations['geometry'] ?? 'Geometry',
                  Colors.purple,
                   () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeometryCalculatorScreen(
                        translations: translations,
                        theme: theme,
                        isPremium: isPremium,
                      ),
                    ),
                  ),
                ),
                _buildToolCard(
                  context,
                  Icons.attach_money,
                  translations['finance'] ?? 'Finance',
                  Colors.green,
                   () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinanceCalculatorScreen(
                        translations: translations,
                        theme: theme,
                        isPremium: isPremium,
                      ),
                    ),
                  ),
                ),
                _buildToolCard(
                  context,
                  Icons.cake,
                  translations['age_calc'] ?? 'Yaş Hesaplama',
                  Colors.pink,
                  () {
                    if (!isPremium && (toolCredits['age'] ?? 0) <= 0) {
                      onOutOfCredits('age');
                    } else {
                      onUseTool('age');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AgeCalculatorScreen(translations: translations, theme: theme, isPremium: isPremium)));
                    }
                  },
                ),
                _buildToolCard(
                  context,
                  Icons.monitor_weight,
                  translations['bmi_calc'] ?? 'VKI Hesaplama',
                  Colors.teal,
                  () {
                    if (!isPremium && (toolCredits['bmi'] ?? 0) <= 0) {
                      onOutOfCredits('bmi');
                    } else {
                      onUseTool('bmi');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BMICalculatorScreen(translations: translations, theme: theme, isPremium: isPremium)));
                    }
                  },
                ),
                _buildToolCard(
                  context,
                  Icons.local_offer,
                  translations['discount_calc'] ?? 'İndirim Hesaplama',
                  Colors.redAccent,
                  () {
                    if (!isPremium && (toolCredits['discount'] ?? 0) <= 0) {
                      onOutOfCredits('discount');
                    } else {
                      onUseTool('discount');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountCalculatorScreen(translations: translations, theme: theme, isPremium: isPremium)));
                    }
                  },
                ),
                _buildToolCard(
                  context,
                  Icons.restaurant,
                  translations['tip_calc'] ?? 'Bahşiş Hesaplama',
                  Colors.amber,
                  () {
                    if (!isPremium && (toolCredits['tip'] ?? 0) <= 0) {
                      onOutOfCredits('tip');
                    } else {
                      onUseTool('tip');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TipCalculatorScreen(translations: translations, theme: theme, isPremium: isPremium)));
                    }
                  },
                ),
              ],
            ),
          ),
          if (!isPremium)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                (translations['tool_credits_summary'] ?? 'Ücretsiz Araç Kredileriniz: {0} / {1}')
                    .replaceFirst('{0}', toolCredits.values.where((v) => v > 0).length.toString())
                    .replaceFirst('{1}', toolCredits.length.toString()),
                style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
              ),
            ),
          CommonBannerAd(isPremium: isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    final cardColor = theme.keypadBackgroundColor;
    final textColor = theme.displayTextColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const UnitConverterScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
  });

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _inputController = TextEditingController();
  
  String _result = '';
  
  // Units
  final List<String> _lengthUnits = ['Meter', 'Kilometer', 'Centimeter', 'Inch', 'Foot'];
  final List<String> _weightUnits = ['Kilogram', 'Gram', 'Pound', 'Ounce'];
  final List<String> _tempUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];

  String _fromUnit = 'Meter';
  String _toUnit = 'Kilometer';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
         _inputController.clear();
         _result = '';
         if (_tabController.index == 0) {
           _fromUnit = _lengthUnits[0];
           _toUnit = _lengthUnits[1];
         } else if (_tabController.index == 1) {
           _fromUnit = _weightUnits[0];
           _toUnit = _weightUnits[2];
         } else {
           _fromUnit = _tempUnits[0];
           _toUnit = _tempUnits[1];
         }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    if (_inputController.text.isEmpty) return;
    double input = double.tryParse(_inputController.text) ?? 0;
    double output = 0;

    if (_tabController.index == 0) {
      // Length conversion logic (simplified)
      output = _convertLength(input, _fromUnit, _toUnit);
    } else if (_tabController.index == 1) {
      // Weight
      output = _convertWeight(input, _fromUnit, _toUnit);
    } else {
      // Temp
      output = _convertTemp(input, _fromUnit, _toUnit);
    }

    setState(() {
      _result = output.toStringAsFixed(4);
    });
  }

  double _convertLength(double val, String from, String to) {
    // Convert to meters first
    double meters = 0;
    switch (from) {
      case 'Meter': meters = val; break;
      case 'Kilometer': meters = val * 1000; break;
      case 'Centimeter': meters = val / 100; break;
      case 'Inch': meters = val * 0.0254; break;
      case 'Foot': meters = val * 0.3048; break;
    }
    // Convert from meters to target
    switch (to) {
      case 'Meter': return meters;
      case 'Kilometer': return meters / 1000;
      case 'Centimeter': return meters * 100;
      case 'Inch': return meters / 0.0254;
      case 'Foot': return meters / 0.3048;
    }
    return 0;
  }

  double _convertWeight(double val, String from, String to) {
    // Convert to kg first
    double kg = 0;
    switch (from) {
      case 'Kilogram': kg = val; break;
      case 'Gram': kg = val / 1000; break;
      case 'Pound': kg = val * 0.453592; break;
      case 'Ounce': kg = val * 0.0283495; break;
    }
    switch (to) {
      case 'Kilogram': return kg;
      case 'Gram': return kg * 1000;
      case 'Pound': return kg / 0.453592;
      case 'Ounce': return kg / 0.0283495;
    }
    return 0;
  }

  double _convertTemp(double val, String from, String to) {
    if (from == to) return val;
    // to Celsius
    double c = 0;
    if (from == 'Celsius') c = val;
    if (from == 'Fahrenheit') c = (val - 32) * 5/9;
    if (from == 'Kelvin') c = val - 273.15;

    // from Celsius
    if (to == 'Celsius') return c;
    if (to == 'Fahrenheit') return c * 9/5 + 32;
    if (to == 'Kelvin') return c + 273.15;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;
    final cardColor = theme.keypadBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.translations['unit_converter'] ?? 'Unit Converter', style: TextStyle(color: textColor)),
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: textColor),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.displayTextColor,
          unselectedLabelColor: theme.displayTextColor.withOpacity(0.5),
          indicatorColor: theme.actionBackground,
          tabs: [
            Tab(text: widget.translations['length'] ?? 'Length'),
            Tab(text: widget.translations['weight'] ?? 'Weight'),
            Tab(text: widget.translations['temperature'] ?? 'Temp'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _fromUnit,
                          dropdownColor: cardColor,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: (_tabController.index == 0 ? _lengthUnits : _tabController.index == 1 ? _weightUnits : _tempUnits)
                              .map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                          onChanged: (val) => setState(() => _fromUnit = val!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _toUnit,
                          dropdownColor: cardColor,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: (_tabController.index == 0 ? _lengthUnits : _tabController.index == 1 ? _weightUnits : _tempUnits)
                               .map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                          onChanged: (val) => setState(() => _toUnit = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor, fontSize: 24),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: (_) => _convert(),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.operatorBackground.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.operatorBackground),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.translations['convert'] ?? 'Result',
                          style: TextStyle(color: theme.operatorTextColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          _result.isEmpty ? '0' : _result,
                          style: TextStyle(color: textColor, fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}

class ProgrammerCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const ProgrammerCalculatorScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
  });

  @override
  State<ProgrammerCalculatorScreen> createState() => _ProgrammerCalculatorScreenState();
}

class _ProgrammerCalculatorScreenState extends State<ProgrammerCalculatorScreen> {
  int _value = 0;
  String _input = '0';

  void _onPressed(String char) {
    setState(() {
      if (char == 'C') {
        _value = 0;
        _input = '0';
      } else if (char == '⌫') {
        if (_input.length > 1) {
          _input = _input.substring(0, _input.length - 1);
        } else {
          _input = '0';
        }
        _value = int.tryParse(_input) ?? 0;
      } else {
        if (_input == '0') _input = char;
        else _input += char;
        _value = int.tryParse(_input) ?? 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;
    final cardColor = theme.keypadBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.translations['programmer'] ?? 'Programmer', style: TextStyle(color: textColor)),
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: cardColor,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDisplayRow(widget.translations['hex'] ?? 'HEX', _value.toRadixString(16).toUpperCase(), textColor),
                _buildDisplayRow(widget.translations['dec'] ?? 'DEC', _value.toString(), textColor, isMain: true),
                _buildDisplayRow(widget.translations['oct'] ?? 'OCT', _value.toRadixString(8), textColor),
                _buildDisplayRow(widget.translations['bin'] ?? 'BIN', _value.toRadixString(2), textColor),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.2,
              children: [
                ...['A', 'B', 'C', 'D', 'E', 'F'].map((e) => _buildButton(e, Colors.orange)),
                ...['7', '8', '9', 'C'].map((e) => _buildButton(e, e == 'C' ? theme.actionBackground : theme.buttonBackground)),
                ...['4', '5', '6', '⌫'].map((e) => _buildButton(e, e == '⌫' ? theme.actionBackground : theme.buttonBackground)),
                ...['1', '2', '3', '0'].map((e) => _buildButton(e, theme.buttonBackground)),
              ],
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }

  Widget _buildDisplayRow(String label, String value, Color color, {bool isMain = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color.withOpacity(0.7), fontSize: 14)),
          Text(value, style: TextStyle(color: color, fontSize: isMain ? 32 : 18, fontWeight: isMain ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _onPressed(label),
      child: Text(label, style: TextStyle(fontSize: 20, color: widget.theme.buttonTextColor)),
    );
  }
}

class GeometryCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const GeometryCalculatorScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
  });

  @override
  State<GeometryCalculatorScreen> createState() => _GeometryCalculatorScreenState();
}

class _GeometryCalculatorScreenState extends State<GeometryCalculatorScreen> {
  String _selectedShape = 'Circle';
  final TextEditingController _param1Controller = TextEditingController();
  final TextEditingController _param2Controller = TextEditingController();
  String _result = '';

  final List<String> _shapes = ['Circle', 'Rectangle', 'Triangle'];

  void _calculate() {
    double p1 = double.tryParse(_param1Controller.text) ?? 0;
    double p2 = double.tryParse(_param2Controller.text) ?? 0;
    String res = '';

    if (_selectedShape == 'Circle') {
      double area = 3.14159 * p1 * p1;
      double circumference = 2 * 3.14159 * p1;
      res = '${widget.translations['area']}: ${area.toStringAsFixed(2)}\n${widget.translations['circumference']}: ${circumference.toStringAsFixed(2)}';
    } else if (_selectedShape == 'Rectangle') {
      double area = p1 * p2;
      double perimeter = 2 * (p1 + p2);
      res = '${widget.translations['area']}: ${area.toStringAsFixed(2)}\n${widget.translations['perimeter']}: ${perimeter.toStringAsFixed(2)}';
    } else if (_selectedShape == 'Triangle') {
      double area = 0.5 * p1 * p2;
      res = '${widget.translations['area']}: ${area.toStringAsFixed(2)}';
    }

    setState(() {
      _result = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;
    final cardColor = theme.keypadBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.translations['geometry'] ?? 'Geometry', style: TextStyle(color: textColor)),
        backgroundColor: cardColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedShape,
                    dropdownColor: cardColor,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelText: widget.translations['shape'] ?? 'Shape',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                    ),
                    items: _shapes.map((s) => DropdownMenuItem(value: s, child: Text(widget.translations[s.toLowerCase()] ?? s))).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedShape = val!;
                        _param1Controller.clear();
                        _param2Controller.clear();
                        _result = '';
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _param1Controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      labelText: _selectedShape == 'Circle' ? widget.translations['radius'] : (_selectedShape == 'Rectangle' ? widget.translations['width'] : widget.translations['base']),
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  if (_selectedShape != 'Circle') ...[
                    const SizedBox(height: 10),
                    TextField(
                      controller: _param2Controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cardColor,
                        labelText: _selectedShape == 'Rectangle' ? widget.translations['height'] : widget.translations['height'],
                        labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: theme.actionBackground),
                      onPressed: _calculate,
                      child: Text(widget.translations['calculate'] ?? 'Calculate', style: TextStyle(color: theme.actionTextColor)),
                    ),
                  ),
                  const SizedBox(height: 20),
                   Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Text(
                      _result.isEmpty ? 'Result will appear here' : _result,
                      style: TextStyle(color: textColor, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}

class FinanceCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const FinanceCalculatorScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.isPremium,
  });

  @override
  State<FinanceCalculatorScreen> createState() => _FinanceCalculatorScreenState();
}

class _FinanceCalculatorScreenState extends State<FinanceCalculatorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  String _result = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _rateController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _calculate() {
    double P = double.tryParse(_amountController.text) ?? 0;
    double r = double.tryParse(_rateController.text) ?? 0;
    double t = double.tryParse(_durationController.text) ?? 0;
    
    if (P == 0 || t == 0) return;

    if (_tabController.index == 0) {
      // Loan (Mortgage) Calculation: M = P [i(1+i)^n] / [(1+i)^n i¢φÂ¬—Å“ 1]
      // r is annual rate, t is years
      double i = r / 100 / 12; // monthly rate
      double n = t * 12; // total months
      
      double m = 0;
      if (i == 0) {
         m = P / n;
      } else {
         m = P * (i * pow((1 + i), n)) / (pow((1 + i), n) - 1);
      }
      
      double totalPayment = m * n;
      double totalInterest = totalPayment - P;

      setState(() {
        _result = '${widget.translations['monthly_payment']}: ${m.toStringAsFixed(2)}\n'
                  '${widget.translations['total_payment']}: ${totalPayment.toStringAsFixed(2)}\n'
                  '${widget.translations['total_interest']}: ${totalInterest.toStringAsFixed(2)}';
      });
    } else {
      // Savings (Compound Interest): A = P(1 + r/n)^(nt)
      // Assuming Annually compounded for simplicity
      double amount = P * pow((1 + r / 100), t);
      double interest = amount - P;

      setState(() {
        _result = '${widget.translations['total_amount']}: ${amount.toStringAsFixed(2)}\n'
                  '${widget.translations['total_interest']}: ${interest.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.displayTextColor;
    final cardColor = theme.keypadBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.translations['finance'] ?? 'Finance', style: TextStyle(color: textColor)),
        backgroundColor: cardColor,
        iconTheme: IconThemeData(color: textColor),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.displayTextColor,
          unselectedLabelColor: theme.displayTextColor.withOpacity(0.5),
          indicatorColor: theme.actionBackground,
          tabs: [
            Tab(text: widget.translations['loan'] ?? 'Loan'),
            Tab(text: widget.translations['savings'] ?? 'Savings'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      labelText: widget.translations['principal'] ?? 'Principal Amount',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      labelText: widget.translations['rate'] ?? 'Interest Rate (%)',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      labelText: widget.translations['duration'] ?? 'Duration (Years)',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: theme.actionBackground),
                      onPressed: _calculate,
                      child: Text(widget.translations['calculate'] ?? 'Calculate', style: TextStyle(color: theme.actionTextColor)),
                    ),
                  ),
                  const SizedBox(height: 20),
                   Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Text(
                      _result.isEmpty ? 'Result will appear here' : _result,
                      style: TextStyle(color: textColor, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}



class LanguageSelectionScreen extends StatelessWidget {
  final FirebaseRemoteConfig remoteConfig;
  final Map<String, dynamic> languages = {
    "TR": {"name": "Türkçe", "icon": "🇹🇷"},
    "EN": {"name": "English", "icon": "🇺🇸"},
    "DE": {"name": "Deutsch", "icon": "🇩🇪"},
    "ES": {"name": "Español", "icon": "🇪🇸"},
    "AR": {"name": "العربية", "icon": "🇸🇦"},
    "FR": {"name": "Français", "icon": "🇫🇷"},
    "PT": {"name": "Português", "icon": "🇵🇹"},
    "RU": {"name": "Русский", "icon": "🇷🇺"},
    "HI": {"name": "हिन्दी", "icon": "🇮🇳"},
  };

  LanguageSelectionScreen({super.key, required this.remoteConfig});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Select Language / Dil Seçin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please select a language to continue.\nLütfen devam etmek için bir dil seçiniz.",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    String code = languages.keys.elementAt(index);
                    var lang = languages[code];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () => _selectLanguage(context, code),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2E),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Row(
                            children: [
                              Text(lang["icon"], style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 20),
                              Text(
                                lang["name"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    "BOTLAB AI TECHNOLOGY",
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectLanguage(BuildContext context, String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", code);
    await prefs.setBool("languageSelected", true);
    
    final translations = AppTranslations.getTranslations(code);
    final theme = CalculatorThemes.getTheme('Classic');

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PremiumOfferScreen(
            translations: translations,
            theme: theme,
            remoteConfig: remoteConfig,
            onContinue: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CalculatorScreen(remoteConfig: remoteConfig)),
              );
            },
          ),
        ),
      );
    }
  }
}
// --- BLINKING PREMIUM BUTTON ---
class BlinkingPremiumButton extends StatefulWidget {
  final Map<String, String> translations;
  final VoidCallback onTap;
  
  const BlinkingPremiumButton({Key? key, required this.translations, required this.onTap}) : super(key: key);

  @override
  State<BlinkingPremiumButton> createState() => _BlinkingPremiumButtonState();
}

class _BlinkingPremiumButtonState extends State<BlinkingPremiumButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF5A623), Color(0xFFFFCC80)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.black, size: 14),
              const SizedBox(width: 4),
              Text(
                widget.translations['try_free'] ?? 'Ücretsiz Dene',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW TOOLS SCREENS ---

class AgeCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const AgeCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? _birthDate;
  String _result = '';

  void _calculateAge() {
    if (_birthDate == null) return;
    final now = DateTime.now();
    int years = now.year - _birthDate!.year;
    int months = now.month - _birthDate!.month;
    int days = now.day - _birthDate!.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final isTR = widget.translations['power'] == 'Üs';
    setState(() {
      _result = '$years ${isTR ? 'Yıl' : 'Years'}, $months ${isTR ? 'Ay' : 'Months'}, $days ${isTR ? 'Gün' : 'Days'}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['age_calc'] ?? 'Age Calculator'), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
          children: [
            ListTile(
              title: Text(_birthDate == null ? widget.translations['select_birth_date']! : '${widget.translations['birth_date']!}: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}', style: TextStyle(color: widget.theme.displayTextColor)),
              trailing: Icon(Icons.calendar_today, color: widget.theme.operatorBackground),
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1900), lastDate: DateTime.now());
                if (date != null) setState(() => _birthDate = date);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateAge, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_result.isNotEmpty) Text(_result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.theme.displayTextColor)),
          ],
        ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const BMICalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _result = '';
  String _status = '';

  void _calculateBMI() {
    final h = double.tryParse(_heightController.text);
    final w = double.tryParse(_weightController.text);
    if (h == null || w == null || h == 0) return;

    final bmi = w / ((h / 100) * (h / 100));
    String status = '';
    final isTR = widget.translations['power'] == 'Üs';
    if (bmi < 18.5) status = isTR ? 'Zayıf' : 'Underweight';
    else if (bmi < 25) status = isTR ? 'Normal' : 'Normal';
    else if (bmi < 30) status = isTR ? 'Kilolu' : 'Overweight';
    else status = isTR ? 'Obez' : 'Obese';

    setState(() {
      _result = bmi.toStringAsFixed(1);
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['bmi_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
          children: [
            TextField(controller: _heightController, decoration: InputDecoration(labelText: widget.translations['height_cm'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _weightController, decoration: InputDecoration(labelText: widget.translations['weight_kg'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBMI, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_result.isNotEmpty) ...[
              Text('${widget.translations['bmi_label']}: $_result', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.theme.displayTextColor)),
              Text('${widget.translations['status_label']}: $_status', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ]
          ],
        ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}

class DiscountCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const DiscountCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<DiscountCalculatorScreen> createState() => _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends State<DiscountCalculatorScreen> {
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  String _finalPrice = '';
  String _savings = '';

  void _calculate() {
    final price = double.tryParse(_priceController.text);
    final discount = double.tryParse(_discountController.text);
    if (price == null || discount == null) return;

    final savings = price * (discount / 100);
    final finalPrice = price - savings;

    setState(() {
      _finalPrice = finalPrice.toStringAsFixed(2);
      _savings = savings.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['discount_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
          children: [
            TextField(controller: _priceController, decoration: InputDecoration(labelText: widget.translations['price_label'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _discountController, decoration: InputDecoration(labelText: widget.translations['discount_percent'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_finalPrice.isNotEmpty) ...[
              Text('${widget.translations['final_price']}: $_finalPrice TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
              Text('${widget.translations['savings_label']}: $_savings TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
            ]
          ],
        ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const TipCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final _billController = TextEditingController();
  final _tipController = TextEditingController();
  final _peopleController = TextEditingController();
  String _totalTip = '';
  String _perPerson = '';

  void _calculate() {
    final bill = double.tryParse(_billController.text);
    final tipPercent = double.tryParse(_tipController.text);
    final people = int.tryParse(_peopleController.text);
    if (bill == null || tipPercent == null || people == null || people == 0) return;

    final totalTip = bill * (tipPercent / 100);
    final totalBill = bill + totalTip;
    final perPerson = totalBill / people;

    setState(() {
      _totalTip = totalTip.toStringAsFixed(2);
      _perPerson = perPerson.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['tip_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
          children: [
            TextField(controller: _billController, decoration: InputDecoration(labelText: widget.translations['bill_amount'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _tipController, decoration: InputDecoration(labelText: widget.translations['tip_percent'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _peopleController, decoration: InputDecoration(labelText: widget.translations['people_count'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_totalTip.isNotEmpty) ...[
              Text('${widget.translations['total_tip']}: $_totalTip TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
              Text('${widget.translations['per_person']}: $_perPerson TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            ]
          ],
        ),
            ),
          ),
          CommonBannerAd(isPremium: widget.isPremium, adSize: AdSize.largeBanner),
        ],
      ),
    );
  }
}