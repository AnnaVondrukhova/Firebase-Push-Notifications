let functions = require('firebase-functions')
let admin = require('firebase-admin')
admin.initializeApp(functions.config().firebase)

exports.announceProduct = functions.database
  .ref('/products/{productId}')
  .onCreate((snap, context) => {
    let product = snap.val()
    sendNotification(product)
  })

  function sendNotification(product) {
    let title = product.title
    let cost = product.cost

    let payload = {
      notification: {
        title: 'New product available',
        body: title + ' for $' + cost,
        sound: "default",
        mutable_content: 'true'
      },
      data: {
        imageUrl: 'https://lh3.googleusercontent.com/proxy/YrrsoVMJDcYHCj060na-P3VnS2HnAKqCwKR-W6RnhIvt1PWKnRDZQnV2MviTGHJtp8zaJiAipqrSGkzbtokH2m4h3VDdCkk9fpPC6jDuVfcI3LCHRRHmH0dQV2Ix3-qLZ310XjU'
      }
    }

    console.log(payload)
    let topic = "newProduct"
    admin.messaging().sendToTopic(topic, payload)
  }
