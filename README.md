# NothingStatusBar

A minimal macOS status bar app written in Swift.

## Behavior

- Runs as a menu bar only app (no Dock icon).
- Shows a simple status item titled `Nothing`.
- Opens a menu with:
  - `Version x.y.z (build)`
  - `Launch at Login` (toggle on/off)
  - `Quit`

## Requirements

- macOS 13+
- Xcode Command Line Tools (Swift 5.9+)

## Run

```bash
swift run
```

## Build .app bundle (CLT only)

```bash
./BuildSupport/make_app.sh release
cp -R ./dist/NothingStatusBar.app /Applications/
```

Notes:
- Login item registration (`Launch at Login`) should be tested from the `.app` bundle.
- You can use `debug` instead of `release`.

## Edit version

Update these values in `BuildSupport/Info.plist`:

- `CFBundleShortVersionString`
- `CFBundleVersion`
