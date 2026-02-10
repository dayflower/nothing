import AppKit
import ServiceManagement

final class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    private var statusItem: NSStatusItem?
    private var launchAtLoginItem: NSMenuItem?

    func applicationDidFinishLaunching(_: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item.button?.title = "Nothing"

        let menu = NSMenu()
        menu.delegate = self
        menu.addItem(withTitle: versionLine(), action: nil, keyEquivalent: "")
        menu.addItem(.separator())

        let launchItem = NSMenuItem(
            title: "Launch at Login",
            action: #selector(toggleLaunchAtLogin),
            keyEquivalent: ""
        )
        launchItem.target = self
        launchAtLoginItem = launchItem
        menu.addItem(launchItem)
        menu.addItem(.separator())

        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)

        item.menu = menu
        statusItem = item
        updateLaunchAtLoginMenuState()
    }

    func menuWillOpen(_: NSMenu) {
        updateLaunchAtLoginMenuState()
    }

    @objc
    private func toggleLaunchAtLogin() {
        do {
            let service = SMAppService.mainApp
            switch service.status {
            case .enabled:
                try service.unregister()
            case .notRegistered, .requiresApproval, .notFound:
                try service.register()
            @unknown default:
                return
            }
            updateLaunchAtLoginMenuState()
        } catch {
            NSSound.beep()
        }
    }

    private func updateLaunchAtLoginMenuState() {
        let status = SMAppService.mainApp.status
        launchAtLoginItem?.state = status == .enabled ? .on : .off
    }

    @objc
    private func quitApp() {
        NSApplication.shared.terminate(nil)
    }

    private func versionLine() -> String {
        let info = Bundle.main.infoDictionary
        let version = (info?["CFBundleShortVersionString"] as? String) ?? "0.1.0"
        let build = (info?["CFBundleVersion"] as? String) ?? "1"
        return "Version \(version) (\(build))"
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
