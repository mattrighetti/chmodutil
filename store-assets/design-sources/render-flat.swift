import AppKit
import CoreGraphics
import ImageIO
import Foundation

// Render only supplied PNGs; this script does not capture any screen or window.
let root = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let width = 1179
let height = 2556
let backdrop = NSColor(srgbRed: 24 / 255, green: 24 / 255, blue: 24 / 255, alpha: 1)
let foreground = NSColor.white
let secondary = NSColor(srgbRed: 0.72, green: 0.72, blue: 0.72, alpha: 1)
let designs: [(String, [String], String)] = [
    ("01-permissions.png", ["Unix permissions.", "Made simple."], "Tap rwx. See the number change."),
    ("02-manual.png", ["Small app.", "Proper manual."], "Clear explanations, one topic at a time."),
    ("03-basics.png", ["Owner. Group.", "Everyone else."], "Know exactly who gets access.")
]

func text(_ value: String, y: CGFloat, size: CGFloat, weight: NSFont.Weight,
          color: NSColor, x: CGFloat = 60, availableWidth: CGFloat = 1059) {
    var pointSize = size
    var font = NSFont.monospacedSystemFont(ofSize: pointSize, weight: weight)
    while (value as NSString).size(withAttributes: [.font: font]).width > availableWidth {
        pointSize -= 0.5
        font = NSFont.monospacedSystemFont(ofSize: pointSize, weight: weight)
    }
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    (value as NSString).draw(in: NSRect(x: x, y: y, width: availableWidth, height: size * 1.5),
                            withAttributes: [.font: font, .foregroundColor: color, .paragraphStyle: paragraph])
}

for (name, headline, subtitle) in designs {
    guard let context = CGContext(data: nil, width: width, height: height,
                                  bitsPerComponent: 8, bytesPerRow: width * 4,
                                  space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                  bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
        fatalError("Cannot create RGB export context")
    }
    context.translateBy(x: 0, y: CGFloat(height))
    context.scaleBy(x: 1, y: -1)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: true)
    backdrop.setFill()
    NSRect(x: 0, y: 0, width: width, height: height).fill()

    // Flat brand tile and type, with no bevel, gradient or shadow.
    let iconRect = NSRect(x: 311, y: 80, width: 148, height: 148)
    NSColor.black.setFill()
    NSBezierPath(roundedRect: iconRect, xRadius: 30, yRadius: 30).fill()
    text("rwx", y: 113, size: 68, weight: .bold, color: foreground, x: 311, availableWidth: 148)
    text("chmod util", y: 115, size: 62, weight: .medium, color: foreground, x: 496, availableWidth: 372)
    text(headline[0], y: 300, size: 86, weight: .bold, color: foreground)
    text(headline[1], y: 410, size: 86, weight: .bold, color: foreground)
    text(subtitle, y: 538, size: 43, weight: .regular, color: secondary)

    // Uniform-color device frame. Source screenshot keeps its original aspect ratio.
    let deviceWidth: CGFloat = 840
    let bezel: CGFloat = 18
    let screenWidth = deviceWidth - bezel * 2
    let screenHeight = screenWidth * CGFloat(height) / CGFloat(width)
    let deviceRect = NSRect(x: (CGFloat(width) - deviceWidth) / 2, y: 650,
                            width: deviceWidth, height: screenHeight + bezel * 2)
    NSColor(srgbRed: 0.42, green: 0.42, blue: 0.42, alpha: 1).setFill()
    NSBezierPath(roundedRect: deviceRect, xRadius: 110, yRadius: 110).fill()
    NSColor.black.setFill()
    NSBezierPath(roundedRect: deviceRect.insetBy(dx: 3, dy: 3), xRadius: 107, yRadius: 107).fill()
    for (x, y, buttonHeight) in [(deviceRect.minX - 5, deviceRect.minY + 260, CGFloat(65)),
                                (deviceRect.minX - 5, deviceRect.minY + 365, CGFloat(110)),
                                (deviceRect.minX - 5, deviceRect.minY + 505, CGFloat(110)),
                                (deviceRect.maxX, deviceRect.minY + 365, CGFloat(170))] {
        NSColor(srgbRed: 0.42, green: 0.42, blue: 0.42, alpha: 1).setFill()
        NSBezierPath(roundedRect: NSRect(x: x, y: y, width: 5, height: buttonHeight), xRadius: 2, yRadius: 2).fill()
    }
    let screenRect = deviceRect.insetBy(dx: bezel, dy: bezel)
    guard let screenshot = NSImage(contentsOf: root.appendingPathComponent("iphone/" + name)) else {
        fatalError("Missing source screenshot: \(name)")
    }
    context.saveGState()
    NSBezierPath(roundedRect: screenRect, xRadius: 92, yRadius: 92).addClip()
    screenshot.draw(in: screenRect, from: .zero, operation: .sourceOver, fraction: 1,
                    respectFlipped: true, hints: [.interpolation: NSImageInterpolation.high])
    context.restoreGState()
    NSGraphicsContext.restoreGraphicsState()

    // Check all outer backdrop pixels; every pixel must be exactly RGB 24,24,24.
    let pixels = context.data!.assumingMemoryBound(to: UInt8.self)
    for y in 0..<height {
        for x in [0, 1, 20, width - 21, width - 2, width - 1] {
            let offset = y * context.bytesPerRow + x * 4
            precondition(pixels[offset] == 24 && pixels[offset + 1] == 24 && pixels[offset + 2] == 24,
                         "Backdrop is not a uniform solid color")
        }
    }
    let output = root.appendingPathComponent("iphone-framed/" + name)
    guard let cgImage = context.makeImage(),
          let destination = CGImageDestinationCreateWithURL(output as CFURL, "public.png" as CFString, 1, nil) else {
        fatalError("Cannot create PNG")
    }
    CGImageDestinationAddImage(destination, cgImage, nil)
    precondition(CGImageDestinationFinalize(destination))
    print("Exported \(name): 1179x2556, opaque RGB, solid #181818 backdrop")
}
