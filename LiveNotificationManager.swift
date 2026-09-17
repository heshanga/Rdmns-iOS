import Foundation
import UserNotifications

class LiveNotificationManager {
    static let shared = LiveNotificationManager()

    private var timer: Timer?
    private var lastStatus: Int = -1

    var userId: String {
        let key = "rdmns_user_unique_id"
        if let id = UserDefaults.standard.string(forKey: key) {
            return id
        } else {
            let newId = "user_" + UUID().uuidString.prefix(8)
            UserDefaults.standard.set(newId, forKey: key)
            return String(newId)
        }
    }

    func startLiveStatusPolling() {
        stopLiveStatusPolling()
        timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
            self?.checkStatusFromApi()
        }
        checkStatusFromApi()
    }

    func stopLiveStatusPolling() {
        timer?.invalidate()
        timer = nil
        lastStatus = -1
    }

    private func checkStatusFromApi() {
        let urlString = "https://rdmns.hesn.xyz/api/status.php?userId=\(userId)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? Int,
                   let title = json["title"] as? String,
                   let message = json["message"] as? String {

                    if status > 0 && status != self?.lastStatus {
                        self?.lastStatus = status
                        self?.triggerNotification(status: status, title: title, message: message)
                    }
                }
            } catch {}
        }.resume()
    }

    func triggerNotification(status: Int, title: String, message: String) {
        let content = UNMutableNotificationContent()
        
        let (defaultTitle, defaultMsg) = getStatusDetails(status)
        content.title = title.isEmpty ? defaultTitle : title
        content.body = message.isEmpty ? defaultMsg : message
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: "rdmns_live_status_\(status)",
            content: content,
            trigger: nil // Present immediately
        )

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    private func getStatusDetails(_ status: Int) -> (String, String) {
        switch status {
        case 1: return ("🛒 Order Received", "Your order has been placed successfully. (20%)")
        case 2: return ("🍳 Preparing Your Order", "The kitchen is currently preparing your meal. (40%)")
        case 3: return ("🛵 On The Way", "Delivery partner is on the way to your location. (60%)")
        case 4: return ("📍 Arriving Soon", "Delivery partner is nearby! Please get ready. (80%)")
        case 5: return ("✅ Order Delivered", "Enjoy your order! Thank you for choosing Rdmns. (100%)")
        default: return ("📦 Order Status Update", "Status update for your order.")
        }
    }
}
