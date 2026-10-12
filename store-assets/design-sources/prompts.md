# App Store screenshot design prompts

Tool: built-in imagegen. Image 1 in each call is the user-supplied screenshot;
image 2 is the app icon. The second and third designs additionally reference
the first poster for consistent style and layout. Generated originals are saved
here; final upload images are in `../iphone-framed/`.

## Design 1

Use case: ads-marketing. Create the first of three matching portrait App Store screenshots for the native app "chmod util". Input image 1 is the genuine user-supplied app screenshot to place inside the phone; input image 2 is the app icon to use as a small brand mark. Design an elegant, simple, nerdy App Store poster in the same neutral monochrome aesthetic as the icon: deep charcoal backdrop, restrained soft lighting, crisp white typography, generous space. One large, realistic, front-facing dark titanium iPhone frame, no tilt or perspective, centered in the lower three quarters of the canvas. The actual supplied screenshot must fill its display and remain legible. Preserve the screenshot's exact interface, text, permissions, numbers and layout: paste the supplied screenshot faithfully, do not redraw or invent app content. Keep the whole phone visible, with a fine metallic rim and discreet shadow. Above it, a small icon plus the exact brand name "chmod util", followed by a confident two-line bold monospaced headline and a short muted subtitle. Exact headline: "Unix permissions.\nMade simple." Exact subtitle: "Tap rwx. See the number change." Keep all text accurate and unclipped. No other slogans, badges, ratings or invented features. Use no bright colors. Full-bleed opaque portrait background, intended final aspect ratio 1179:2556, ideally 1179 × 2556 pixels. The supplied app screenshot is the hero, the marketing typography is secondary.

## Design 2

Use case: ads-marketing. Create one portrait App Store screenshot poster for "chmod util", as part of a three-image series. Input image 1 is the genuine app screenshot to display inside the phone. Input image 2 is the brand icon. Input image 3 is the approved first poster, a strict style and layout reference. Match image 3's exact deep charcoal backdrop, neutral soft lighting, small icon plus "chmod util" brand row at top, bold white monospaced centered headline, muted centered subtitle, and large front-facing dark titanium iPhone frame in the lower part. Match the phone's position, size, frame, proportions, shadow, and overall spacing. Replace only the screen content and the headline/subtitle for this topic. Preserve image 1's exact visible app text, numbers, interface and layout inside the phone screen; faithfully place the supplied screenshot rather than inventing or rewriting its UI. Keep the entire phone visible. No invented badges, ratings, app features, extra copy, bright colors or perspective. Output an opaque portrait PNG at aspect ratio 1179:2556, intended final dimensions 1179 × 2556. Exact headline: "Small app.\nProper manual." Exact subtitle: "Clear explanations, one topic at a time."

## Design 3

Use case: ads-marketing. Create one portrait App Store screenshot poster for "chmod util", as part of a three-image series. Input image 1 is the genuine app screenshot to display inside the phone. Input image 2 is the brand icon. Input image 3 is the approved first poster, a strict style and layout reference. Match image 3's exact deep charcoal backdrop, neutral soft lighting, small icon plus "chmod util" brand row at top, bold white monospaced centered headline, muted centered subtitle, and large front-facing dark titanium iPhone frame in the lower part. Match the phone's position, size, frame, proportions, shadow, and overall spacing. Replace only the screen content and the headline/subtitle for this topic. Preserve image 1's exact visible app text, numbers, interface and layout inside the phone screen; faithfully place the supplied screenshot rather than inventing or rewriting its UI. Keep the entire phone visible. No invented badges, ratings, app features, extra copy, bright colors or perspective. Output an opaque portrait PNG at aspect ratio 1179:2556, intended final dimensions 1179 × 2556. Exact headline: "Owner. Group.\nEveryone else." Exact subtitle: "Know exactly who gets access."



## Final flat design

User request: use a single-color backdrop and eliminate gradients, shading and
shadows. The final background is exactly RGB (24, 24, 24), #181818.

Imagegen edits were tried, but retained shading and produced artifacts around
text during background extraction. These drafts were discarded. The final
posters are rendered by `render-flat.swift`, with crisp monospaced type, flat
vector frames, and the user's original screenshot PNGs. The renderer checks the
outer background pixels and exports opaque 1179 × 2556 PNGs.

Run from the repository root:

```sh
xcrun swiftc -module-cache-path /tmp/chmodutil-flat-module-cache store-assets/design-sources/render-flat.swift -o /tmp/chmodutil-render-flat
/tmp/chmodutil-render-flat "$PWD/store-assets"
```
