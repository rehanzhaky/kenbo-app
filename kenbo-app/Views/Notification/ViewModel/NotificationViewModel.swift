import SwiftUI
import Combine

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    init() {
        // Sample data - nanti bisa diganti dengan data dinamis
        loadNotifications()
    }
    
    func loadNotifications() {
        // Load notifications here
    }
    
    func addNotification(userName: String, message: String) {
        let notification = NotificationItem(
            id: UUID(),
            userName: userName,
            message: message,
            timestamp: Date()
        )
        notifications.insert(notification, at: 0)
    }
}

struct NotificationItem: Identifiable {
    let id: UUID
    let userName: String
    let message: String
    let timestamp: Date
}
