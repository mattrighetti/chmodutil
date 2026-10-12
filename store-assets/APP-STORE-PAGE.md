# chmod util — App Store page

This package contains three matching, designed iPhone screenshots: a solid
#181818 charcoal background, a flat rwx brand mark, short monospaced headlines
and a simple front-facing phone outline containing the supplied app screenshots.
There are no decorative gradients, lighting effects or cast shadows.

Upload the three files from `iphone/` in the archive in numerical order:

1. **01-permissions.png** — “Unix permissions. Made simple.”
2. **02-manual.png** — “Small app. Proper manual.”
3. **03-basics.png** — “Owner. Group. Everyone else.”

All final files are opaque PNGs at **1179 × 2556**, suitable for the iPhone with
Dynamic Island (medium display) slot in
[Apple’s screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications).

Paste `whats-new.txt` into the update’s “What’s New” field. `icons/ios-1024.png`
is included for reference; the store icon is supplied by the app build.

The concept was developed with the built-in imagegen tool. The final flat
posters are exported with native Swift/AppKit typesetting and vector outlines,
using the original supplied PNGs for the app UI. This ensures a truly uniform
background without gradients, shadows, or text artifacts. The original user-supplied screenshots are retained unchanged in
`store-assets/iphone/` and `chmodutil-iphone-original-screenshots.zip`.
The generated artwork and prompts are in `store-assets/design-sources/`.
No screen recording or new device captures were used for these designs.

The final package is `chmodutil-app-store-page-flat.zip`. The native export
script is `store-assets/design-sources/render-flat.swift`.
