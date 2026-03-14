import Foundation
import UserNotifications

/// Handles filtering tasks based on user session and time, and scheduling local notifications.
class QuestScheduler {
    
    static let shared = QuestScheduler()
    private init() {}
    
    /// Returns only the tasks that have "unlocked" based on the current hour and user's session.
    func getUnlockedTasks(from allTasks: [QuestTask], session: String, currentHour: Int) -> [QuestTask] {
        return allTasks.filter { task in
            let unlock = task.unlockHour(session)
            return currentHour >= unlock
        }
    }
    
    /// Requests notification permissions and schedules local alerts for all tasks based on the user's session.
    func scheduleNotifications(for tasks: [QuestTask], session: String) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
            // Clear existing scheduled notifications to avoid duplicates
            center.removeAllPendingNotificationRequests()
            
            for task in tasks {
                let hour = task.unlockHour(session)
                self.scheduleNotification(for: task, atHour: hour)
            }
        }
    }
    
    /// Cancels all pending notifications for a specific completed task.
    func cancelNotifications(for taskId: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = [
            taskId,
            "\(taskId)_reminder1",
            "\(taskId)_reminder2"
        ]
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        print("Cancelled pending notifications for completed task: \(taskId)")
    }
    
    private func scheduleNotification(for task: QuestTask, atHour hour: Int) {
        // 1. Primary Notification (Time of Unlock)
        scheduleSingleAlert(id: task.id, title: "Quest Baru Tersedia!", body: "Waktunya untuk: \(task.title)", hour: hour)
        
        // 2. First Reminder (+1 Hour)
        scheduleSingleAlert(id: "\(task.id)_reminder1", title: "Jangan Lupa Quest-mu!", body: "Yuk, sempatkan \(task.title) sebentar biar badan lebih segar.", hour: hour + 1)
        
        // 3. Second Reminder (+2 Hours)
        scheduleSingleAlert(id: "\(task.id)_reminder2", title: "Quest Masih Menunggu!", body: "Hanya butuh beberapa saat untuk menyelesaikan: \(task.title).", hour: hour + 2)
    }
    
    private func scheduleSingleAlert(id: String, title: String, body: String, hour: Int) {
        // Prevent scheduling invalid hours
        guard hour >= 0 && hour <= 23 else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = 0
        
        // This repeats every day at the given hour
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification for \(id): \(error.localizedDescription)")
            } else {
                print("Scheduled: \(id) for \(hour):00")
            }
        }
    }
}
