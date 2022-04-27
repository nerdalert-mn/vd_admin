navigator.serviceWorker.register('/flutter_service_worker.js').then(registration => {
  firebase.messaging().useServiceWorker(registration)
})



firebase.messaging().setBackgroundMessageHandler(function (payload) {
  console.log(
    "[firebase-messaging-sw.js] Received background message ",
    payload,
  );
  // Customize notification here
  console.log(payload)
  const notificationTitle = "Background Message Title";
  const notificationOptions = {
    body: "Background Message body.",
    icon: "/itwonders-web-logo.png",
  };

  return self.registration.showNotification(
    notificationTitle,
    notificationOptions,
  );
});

firebase.messaging().onMessage(function (message) {
  console.log(message)
})