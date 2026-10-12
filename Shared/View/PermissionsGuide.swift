import SwiftUI

struct PermissionsGuide: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("$ man chmod")
                    .font(.system(.title3, design: .monospaced).weight(.semibold))
                    .padding(.bottom, 28)
                Text("CONTENTS")
                    .font(.system(.caption2, design: .monospaced))
                    .tracking(2)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)

                ForEach(Array(GuideTopic.allCases.enumerated()), id: \.element.id) { index, topic in
                    NavigationLink {
                        GuideTopicView(topic: topic)
                    } label: {
                        HStack(alignment: .top, spacing: 14) {
                            Text(String(format: "%02d", index + 1))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundStyle(.secondary)
                                .frame(width: 24, alignment: .leading)
                                .padding(.top, 2)
                                .accessibilityHidden(true)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(topic.title)
                                    .font(.system(.callout, design: .monospaced).weight(.medium))
                                    .foregroundStyle(.primary)
                                Text(topic.subtitle)
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Text(">")
                                .font(.system(.callout, design: .monospaced))
                                .foregroundStyle(.secondary)
                                .accessibilityHidden(true)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                        .padding(.vertical, 16)
                        .contentShape(Rectangle())
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(topic.title)
                        .accessibilityHint(topic.subtitle)
                        .accessibilityIdentifier("guide\(topic.rawValue)")
                    }
                    .buttonStyle(.plain)
                    if topic != GuideTopic.allCases.last {
                        Divider()
                    }
                }
            }
            .padding(24)
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Guide")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private enum GuideTopic: String, CaseIterable, Identifiable {
    case basics, memory, directories, patterns, commands
    var id: Self { self }
    var number: String {
        String(format: "%02d", (Self.allCases.firstIndex(of: self) ?? 0) + 1)
    }
    var subtitle: String {
        switch self {
        case .basics: "Who gets access"
        case .memory: "The 4–2–1 rule"
        case .directories: "What each bit allows"
        case .patterns: "All eight patterns"
        case .commands: "Commands and syntax"
        }
    }

    var title: String {
        switch self {
        case .basics: "Basics"
        case .memory: "Remember rwx"
        case .directories: "Files & directories"
        case .patterns: "Cheat sheet"
        case .commands: "Using chmod"
        }
    }
}

private struct GuideTopicView: View {
    let topic: GuideTopic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                HStack {
                    Text("CHMOD(1)")
                    Spacer()
                    Text("\(topic.number) / \(topic.rawValue.uppercased())")
                }
                .font(.system(.caption2, design: .monospaced))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)

                content
            }
            .font(.system(.callout, design: .monospaced))
            .lineSpacing(4)
            .frame(maxWidth: 520, alignment: .leading)
            .padding(24)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(topic.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    @ViewBuilder private var content: some View {
        switch topic {
        case .basics:
            title("Three people, three digits")
            section("ORDER") {
                Text("The three rwx triplets control access for three different audiences. Read them from left to right: owner → group → others. The three numeric digits follow the same order.")
            }
            section("AUDIENCES") {
                ForEach(Array(Audience.allCases.enumerated()), id: \.element.id) { index, audience in
                    HStack(alignment: .top, spacing: 14) {
                        Text(String(format: "%02d", index + 1))
                            .foregroundStyle(.secondary)
                            .accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(audience.title).fontWeight(.medium)
                            Text(audience.explanation).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            section("READ / WRITE / EXECUTE") {
                Text("Within each triplet, r means read, w means write, and x means execute. A dash means that permission is off.")
            }
            section("EXAMPLE") {
                code("755 = rwx | r-x | r-x")
                Text("Here the owner can read, write and execute; group members and everyone else can read and execute, but cannot write.")
            }
            section("REMEMBER") {
                Text("UGO: User (owner), Group, Others.")
            }
            section("ACCESS RULE") {
                Text("The owner’s permissions apply to the owner; otherwise the group permissions apply to members of the owning group; otherwise the others permissions apply. The three groups aren’t added together.")
            }
        case .memory:
            title("Read 4. Write 2. Execute 1.")
            section("THE 4–2–1 RULE") {
                code("r = 4\nw = 2\nx = 1")
                Text("Start at four and halve: 4 → 2 → 1. The letters always stay in rwx order; a dash fills the place of a permission that is off.")
            }
            section("THREE SWITCHES") {
                code("100 = read\n010 = write\n001 = execute")
                Text("These are binary bits. Add their values to get one octal digit, from 0 to 7.")
            }
            section("ADD THE ENABLED BITS") {
                code("6 = 4 + 2     = rw-\n5 = 4 + 1     = r-x\n7 = 4 + 2 + 1 = rwx")
            }
        case .directories:
            title("Files and directories")
            section("r / READ / 4") {
                code("file:      read contents\ndirectory: list entry names")
            }
            section("w / WRITE / 2") {
                Text("file: modify contents")
                Text("directory: create, delete or rename entries¹")
            }
            section("x / EXECUTE / 1") {
                Text("file: run as a program²")
                Text("directory: traverse and access entries")
            }
            section("NOTES") {
                Text("¹ Changing directory entries normally also requires execute permission. Deleting a file depends on its parent directory’s permissions, rather than the file’s write bit. A sticky directory adds restrictions.")
                Text("² Execute allows execution, but the file must also be a runnable program or script. Script interpreters generally need read permission too.")
            }
            .foregroundStyle(.secondary)
        case .patterns:
            title("Your eight-pattern cheat sheet")
            section("OCTAL / RWX / CALCULATION") {
                ForEach(0..<8) { digit in
                    HStack(alignment: .firstTextBaseline, spacing: 16) {
                        Text("\(digit)")
                            .frame(width: 16, alignment: .leading)
                        Text(Permission(rawValue: digit).symbolic)
                            .frame(width: 44, alignment: .leading)
                        Text(Permission(rawValue: digit).calculation)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 3)
                }
            }
            section("SHORTCUT") {
                Text("Even numbers have no execute bit. Odd numbers do. Six is read + write; seven adds execute.")
            }
        case .commands:
            title("Using chmod")
            section("EXAMPLES") {
                code("$ chmod 644 file\n$ chmod u+x script.sh\n$ chmod go-w file")
            }
            section("SYNTAX") {
                Text("A numeric mode sets all nine basic permission bits. Symbolic modes let you change selected bits.")
                code("u  owner\ng  group\no  others\na  all three\n\n+  add\n-  remove\n=  set exactly")
            }
            section("CHOOSING A MODE") {
                Text("777 gives everyone write access; it is rarely a useful default. Choose the access the file actually needs.")
                Text("Avoid applying one mode recursively to mixed files and directories: directories need execute for traversal, while ordinary files usually don’t.")
            }
            section("SCOPE") {
                Text("This calculator covers the nine basic bits. Special bits (setuid, setgid, sticky), ACLs and other system controls can also affect access.")
                    .foregroundStyle(.secondary)
            }
            section("SEE ALSO") {
                Link(destination: URL(string: "https://www.gnu.org/software/coreutils/manual/html_node/chmod-invocation.html")!) {
                    Text("GNU chmod manual >").underline()
                }
                .foregroundStyle(.primary)
            }
        }
    }

    private func title(_ text: String) -> some View {
        Text(text)
            .font(.system(.title3, design: .monospaced).weight(.semibold))
            .accessibilityAddTraits(.isHeader)
    }

    private func section<Content: View>(_ heading: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(heading)
                .font(.system(.caption2, design: .monospaced))
                .tracking(1.5)
                .foregroundStyle(.secondary)
                .accessibilityAddTraits(.isHeader)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func code(_ text: String) -> some View {
        Text(text)
            .fontWeight(.medium)
            .textSelection(.enabled)
    }
}

#Preview { NavigationStack { PermissionsGuide() } }
