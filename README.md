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

## GitHub Release automation

This repository includes `.github/workflows/release.yml`.

- Trigger: push a tag matching `v*` (for example: `v0.1.0`)
- Build: runs `./BuildSupport/make_app.sh release` on `macos-14`
- Release assets:
  - `NothingStatusBar-macOS.zip`
  - `NothingStatusBar-macOS.zip.sha256`

### Publish a new release

```bash
git tag v0.1.0
git push origin v0.1.0
```
