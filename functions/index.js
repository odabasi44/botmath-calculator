const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// --- AYARLAR ---
const PRIMARY_MODEL = "gemini-2.5-flash"; 
const MIN_VERSION = "1.0.26"; 

// Günlük Limitler (2026 Güncellemesi)
const FREE_DAILY_LIMIT = 2;
const PREMIUM_DAILY_LIMIT = 15;
const REWARDED_CREDITS_PER_AD = 2;

const CONFIGS_TO_TRY = [
  { version: "v1", model: "gemini-2.5-flash" },
  { version: "v1", model: "gemini-2.5-pro" },
  { version: "v1", model: "gemini-2.0-flash" }
];

const geminiApiKey = defineSecret("GEMINI_API_KEY");
const revenueCatSecret = defineSecret("REVENUECAT_SECRET_KEY");

exports.solveMathProblem = onCall(
  {
    secrets: [geminiApiKey, revenueCatSecret],
    region: "us-central1",
    memory: "256MiB",
    maxInstances: 10
  },
  async (request) => {
    const { image, appUserId, appVersion, language } = request.data;
    
    if (!appVersion || _compareVersions(appVersion, MIN_VERSION) < 0) {
      throw new HttpsError("failed-precondition", "Güncelleme gerekli.");
    }
    if (!appUserId) throw new HttpsError("unauthenticated", "Giriş hatası.");

    let isPremium = false;
    try {
      isPremium = await _checkRevenueCatSubscription(appUserId, revenueCatSecret.value());
    } catch (e) { console.warn("RC Error skipped"); }

    const userRef = db.collection("users").doc(appUserId);
    const userDoc = await userRef.get();
    
    // Günlük Sıfırlama Mantığı (UTC 00:00)
    const today = new Date().toISOString().split('T')[0];
    let userData = userDoc.exists ? userDoc.data() : {};
    
    if (!userDoc.exists || userData.lastResetDate !== today) {
      // Yeni gün veya yeni kullanıcı
      userData = {
        ...userData,
        aiCredits: FREE_DAILY_LIMIT,
        premiumDailyUses: 0,
        adRewardCount: 0,
        lastResetDate: today,
        // Araçlar için de kredileri sıfırla
        toolCredits: {
          age: 2,
          bmi: 2,
          discount: 2,
          tip: 2,
          unit: 2,
          finance: 2,
          geometry: 2,
          programmer: 2
        }
      };
      await userRef.set(userData, { merge: true });
    }

    // Hak Kontrolü
    if (isPremium) {
      if (userData.premiumDailyUses >= PREMIUM_DAILY_LIMIT) {
        throw new HttpsError("permission-denied", "Günlük 15 olan Premium haklarınız bitti.");
      }
    } else {
      if (userData.aiCredits <= 0) {
        throw new HttpsError("permission-denied", "Ücretsiz haklarınız bitti. Reklam izleyerek kredi kazanabilirsiniz.");
      }
    }

    if (!image) throw new HttpsError("invalid-argument", "Görüntü yok.");

    const apiKey = geminiApiKey.value().trim();
    let lastError = null;

    const systemPrompts = {
      'TR': "Sen bir matematik öğretmenisin. Fotoğraftaki problemi adım adım çöz ve Türkçe açıkla.",
      'EN': "You are a math teacher. Solve the problem in the photo step by step and explain in English.",
      'AR': "أنت مدرس رياضيات. حل المسألة في الصورة خطوة بخطوة واشرح باللغة العربية.",
      'DE': "Sie sind Mathematiklehrer. Lösen Sie das Problem auf dem Foto Schritt für Schritt und erklären Sie es auf Deutsch.",
      'ES': "Eres un profesor de matemáticas. Resuelve el problema de la foto paso a paso y explica en español."
    };
    const promptText = systemPrompts[language] || systemPrompts['EN'];

    for (const config of CONFIGS_TO_TRY) {
      try {
        const url = `https://generativelanguage.googleapis.com/${config.version}/models/${config.model}:generateContent?key=${apiKey}`;
        const response = await fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            contents: [{
              parts: [
                { text: promptText },
                { inline_data: { mime_type: "image/jpeg", data: image } }
              ]
            }]
          })
        });

        const responseText = await response.text();
        if (response.ok) {
          const result = JSON.parse(responseText);
          const text = result.candidates?.[0]?.content?.parts?.[0]?.text;
          if (text) {
            if (isPremium) {
              await userRef.update({ premiumDailyUses: admin.firestore.FieldValue.increment(1) });
            } else {
              await userRef.update({ aiCredits: admin.firestore.FieldValue.increment(-1) });
            }
            return { solution: text };
          }
        } else {
          lastError = `${config.model}: ${response.status}`;
        }
      } catch (err) { lastError = err.message; }
    }

    throw new HttpsError("internal", `AI servisi şu an meşgul. Son hata: ${lastError}`);
  }
);

async function _checkRevenueCatSubscription(appUserId, secretKey) {
  try {
    const userId = encodeURIComponent(appUserId);
    const response = await fetch(`https://api.revenuecat.com/v1/subscribers/${userId}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${secretKey}`,
        'Accept': 'application/json',
        'X-Platform': 'android'
      }
    });
    if (!response.ok) return false;
    const data = await response.json();
    const premium = data.subscriber.entitlements?.premium || data.subscriber.entitlements?.Premium;
    if (premium) {
      return premium.expires_date === null || new Date(premium.expires_date) > new Date();
    }
    return false;
  } catch (e) { return false; }
}

function _compareVersions(v1, v2) {
  const parts1 = v1.split('.').map(Number);
  const parts2 = v2.split('.').map(Number);
  for (let i = 0; i < Math.max(parts1.length, parts2.length); i++) {
    const p1 = parts1[i] || 0;
    const p2 = parts2[i] || 0;
    if (p1 > p2) return 1;
    if (p1 < p2) return -1;
  }
  return 0;
}
