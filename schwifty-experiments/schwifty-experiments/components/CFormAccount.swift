import SwiftUI

enum NotifyMeAboutType {
  case directMessages
  case mentions
  case anything
}

enum ProfileImageSize {
  case large
  case medium
  case small
}

struct CFormAccount: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  @Binding var username: String
  @State var notifyMeAbout: NotifyMeAboutType? = nil
  @State var profileImageSize: ProfileImageSize? = nil
  @State var playNotificationSounds = false
  @State var sendReadReceipts = false

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
//    Form {
    Section(header: Text("Notifications")) {
      TextField("Username", text: $username)
      TextField("Username 2", text: $username)
      Picker("Notify Me About", selection: $notifyMeAbout) {
        Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
        Text("Mentions").tag(NotifyMeAboutType.mentions)
        Text("Anything").tag(NotifyMeAboutType.anything)
      }
      Toggle("Play notification sounds", isOn: $playNotificationSounds)
      Toggle("Send read receipts", isOn: $sendReadReceipts)
    }
    Section(header: Text("User Profiles")) {
      Picker("Profile Image Size", selection: $profileImageSize) {
        Text("Large").tag(ProfileImageSize.large)
        Text("Medium").tag(ProfileImageSize.medium)
        Text("Small").tag(ProfileImageSize.small)
      }.pickerStyle(.inline)
      Button("Clear Image Cache") {}
    }
//    }
  }
}

#Preview {
  @State var username = ""

  return CFormAccount(username: $username)
}
