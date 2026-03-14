import Foundation
import UserNotifications

/// Handles filtering tasks based on user session and time, and scheduling local notifications.
class QuestScheduler {
    
    static let shared = QuestScheduler()
    private init() {}
    
    /// Returns only the tasks that have "unlocked" based on the current hour and user's session.
    func getUnlockedTasks(from allTasks: [QuestTask], session: String, currentHour: Int) -> [QuestTask] {
        if AppConfig.isDevelopment {
            return allTasks // Bypass time lock in development mode
        }
        
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
    
    private func scheduleNotification(for task: QuestTask, atHour hour: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Quest Baru Tersedia!"
        content.body = "Waktunya untuk: \(task.title)"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = 0
        
        // This repeats every day at the given hour
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification for \(task.id): \(error.localizedDescription)")
            }
        }
    }
}
