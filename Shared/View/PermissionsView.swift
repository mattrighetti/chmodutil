import SwiftUI

struct PermissionsView: View {
    @State private var mode = PermissionMode.standard

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text(mode.octal)
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .accessibilityLabel("Octal permissions \(mode.octal)")
                        .accessibilityIdentifier("octalResult")

                    HStack(alignment: .top, spacing: 12) {
                        ForEach(Audience.allCases) { audience in
                            PermissionColumn(audience: audience, permissions: Binding(
                                get: { mode[audience] },
                                set: { mode[audience] = $0 }
                            ))
                        }
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Common modes")
                            .font(.headline)
                            .padding(.bottom, 8)
                        ForEach(PermissionExample.all) { example in
                            Button {
                                if let selection = PermissionMode(octal: example.octal) {
                                    mode = selection
                                }
                            } label: {
                                HStack(alignment: .top, spacing: 16) {
                                    Text(example.octal)
                                        .font(.system(.body, design: .monospaced))
                                        .foregroundStyle(.primary)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(example.title)
                                            .font(.callout.weight(.medium))
                                            .foregroundStyle(.primary)
                                        Text(example.detail)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Image(systemName: "checkmark")
                                        .font(.caption)
                                        .foregroundStyle(.tint)
                                        .opacity(mode.octal == example.octal ? 1 : 0)
                                        .accessibilityHidden(true)
                                }
                                .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                                .padding(.vertical, 12)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("\(example.octal), \(example.title)")
                            .accessibilityHint(example.detail)
                            .accessibilityIdentifier("preset\(example.octal)")
                            if example.id != PermissionExample.all.last?.id {
                                Divider()
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .frame(maxWidth: 420)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Permissions")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                NavigationLink {
                    PermissionsGuide()
                } label: {
                    Label("Permission guide", systemImage: "book")
                }
            }
        }
    }
}

private struct PermissionColumn: View {
    let audience: Audience
    @Binding var permissions: Permission

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 3) {
                Text(audience.title)
                    .font(.system(.caption, design: .monospaced))
                Text(audienceDescription)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(.secondary)
            HStack(spacing: 0) {
                permissionToggle("Read", letter: "r", permission: .read)
                permissionToggle("Write", letter: "w", permission: .write)
                permissionToggle("Execute", letter: "x", permission: .execute)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var audienceDescription: String {
        switch audience {
        case .owner: "File owner"
        case .group: "Group members"
        case .others: "Everyone else"
        }
    }

    private func permissionToggle(_ title: String, letter: String, permission: Permission) -> some View {
        let enabled = permissions.contains(permission)
        return Toggle(isOn: Binding(
            get: { permissions.contains(permission) },
            set: { enabled in
                if enabled { permissions.insert(permission) }
                else { permissions.remove(permission) }
            }
        )) {
            Text(enabled ? letter : "-")
                .font(.system(.title3, design: .monospaced).bold())
                .foregroundStyle(enabled ? Color.primary : Color.secondary)
                .frame(maxWidth: .infinity, minHeight: 44)
                .contentShape(Rectangle())
        }
        .toggleStyle(.button)
        .buttonStyle(.plain)
        .accessibilityLabel("\(audience.title) \(title.lowercased())")
        .accessibilityIdentifier("\(audience.rawValue)_\(letter)")
    }
}

private struct PermissionExample: Identifiable {
    let octal: String
    let title: String
    let detail: String
    var id: String { octal }

    static let all = [
        PermissionExample(octal: "644", title: "Readable file", detail: "Owner can edit; group and others can read."),
        PermissionExample(octal: "755", title: "Executable or directory", detail: "Owner has full access; everyone else can read and execute."),
        PermissionExample(octal: "600", title: "Private file", detail: "Only the owner can read and write."),
        PermissionExample(octal: "700", title: "Private directory or script", detail: "Only the owner has access.")
    ]
}

#Preview { PermissionsView() }
