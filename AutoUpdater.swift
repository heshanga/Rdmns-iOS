import Foundation
import UIKit

class AutoUpdater {
    static let shared = AutoUpdater()
    private constUrl = "https://rdmns.hesn.xyz/update.json"

    func checkForUpdates(presentingViewController: UIViewController? = nil) {
        guard let url = URL(string: constUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let serverVersionCode = json["versionCode"] as? Int,
                   let serverVersionName = json["versionName"] as? String,
                   let releaseNotes = json["releaseNotes"] as? String,
                   let apkUrl = json["apkUrl"] as? String {

                    let currentVersionCode = 7 // Matches Android versionCode 7 (v1.0.6)

                    if serverVersionCode > currentVersionCode {
                        DispatchQueue.main.async {
                            self.showUpdateAlert(versionName: serverVersionName, notes: releaseNotes, updateUrl: apkUrl)
                        }
                    }
                }
            } catch {}
        }.resume()
    }

    private func showUpdateAlert(versionName: String, notes: String, updateUrl: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }

        let alert = UIAlertController(
            title: "New Update Available (v\(versionName))",
            message: "\(notes)\n\nWould you like to update now?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Update Now", style: .default) { _ in
            if let url = URL(string: updateUrl) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Later", style: .cancel, handler: nil))

        rootViewController.present(alert, animated: true)
    }
}
