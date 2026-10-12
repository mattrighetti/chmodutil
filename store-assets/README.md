# iPhone App Store update assets

## Designed App Store page

Use **`chmodutil-app-store-page-flat.zip`** for the new framed screenshots with
marketing headlines, branding and uniform solid charcoal backgrounds. The final PNGs are in `iphone-framed/`.
See `APP-STORE-PAGE.md` for the upload order and details.

## Original screenshots: iPhone

The three screenshots are user-supplied originals, copied without cropping,
resizing, recoloring or status-bar changes. All are **1179 × 2556**, portrait PNGs
with no alpha channel.

Upload the files from `iphone/` in this order to the **iPhone with Dynamic Island
(medium display)** screenshot slot:

1. `01-permissions.png` — home, showing rwx controls and explained common modes.
2. `02-manual.png` — the terminal-style documentation index.
3. `03-basics.png` — the guide to owner, group and others.

These dimensions are accepted by
[Apple’s screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications),
checked on 12 October 2026. `screenshots.json` records the original filenames,
dimensions and SHA-256 checksums.

This package covers the iPhone listing only.

## Icon

`icons/ios-1024.png` contains the new rwx artwork.
The iOS app target already uses this icon. The App Store icon comes from the
uploaded app build; these copies are included for convenient reference.

## Update text

Paste `whats-new.txt` into the update’s “What’s New” field. It has no version
number, so it can be used with the version you select in App Store Connect.

The archive `chmodutil-store-assets.zip` contains this complete folder.
