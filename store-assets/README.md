# App Store update assets

The icons and release notes are prepared. Add user-supplied screenshots to the
platform folders before uploading. No screen-capture automation is included.

## Screenshots

Use plain screenshots of the current app, without device frames or marketing
headlines. Suggested upload order:

1. `01-permissions.png` — home, showing rwx controls and explained common modes.
2. `02-manual.png` — the terminal-style documentation index.
3. `03-remember-rwx.png` — the 4–2–1 memory aid.
4. `04-cheat-sheet.png` — the eight permission patterns.

| Folder | Upload slot | Suggested dimensions |
| --- | --- | --- |
| `iphone/` | iPhone with Dynamic Island, medium display | 1206 × 2622, portrait |
| `ipad/` | iPad 13-inch | 2064 × 2752, portrait |
| `macos/` | Mac | 2560 × 1600, landscape |

These are accepted dimensions, not the only choices. Supply original PNG or JPEG
files; screenshot uploads must have no alpha channel. Use the same orientation
and dimensions within each device set. Sizes were checked on 12 October 2026
against [Apple’s screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications).

## Icon

`icons/ios-1024.png` and `icons/macos-1024.png` contain the new rwx artwork.
The app targets already use these icons. The App Store icon comes from the
uploaded app build; these copies are included for convenient reference.

## Update text

Paste `whats-new.txt` into the update’s “What’s New” field. It has no version
number, so it can be used with the version you select in App Store Connect.
