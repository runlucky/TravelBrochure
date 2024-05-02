import SwiftUI

extension ToggleStyle where Self == CheckboxToggleStyle {
    internal static var checkBox: CheckboxToggleStyle { CheckboxToggleStyle() }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
                Image(systemName: "square")
                    .frame(width: 25)
                    .foregroundColor(.text.opacity(0.6))
                
                if configuration.isOn {
                    Image(systemName: "checkmark.square.fill")
                        .frame(width: 25)
                        .foregroundColor(.blue)
                }
            }

            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
