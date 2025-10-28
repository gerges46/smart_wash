const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

exports.sendBookingReminderOnCreate = functions.firestore
  .document("users/{userId}/bookings/{bookingId}")
  .onCreate(async (snap, context) => {
    const bookingData = snap.data();
    const fcmToken = bookingData.fcmToken;
    const bookingTime = bookingData.bookingTime.toDate();

    if (!fcmToken) return null;

    const now = new Date();
    const diffMs = bookingTime - now;
    const diffMinutes = diffMs / 1000 / 60;

    if (diffMinutes <= 30) {
      // لو باقي أقل من 30 دقيقة
      const message = {
        token: fcmToken,
        notification: {
          title: "تذكير بالحجز",
          body: `لديك حجز بعد ${Math.round(diffMinutes)} دقيقة`,
        },
        android: { priority: "high" },
        apns: { headers: { "apns-priority": "10" } },
      };

      try {
        await messaging.send(message);
        console.log(`Notification sent for booking ${context.params.bookingId}`);
      } catch (error) {
        console.error("Error sending message:", error);
      }
    }

    return null;
  });
