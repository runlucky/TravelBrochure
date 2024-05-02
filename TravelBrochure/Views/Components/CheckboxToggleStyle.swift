import SwiftUI

extension ToggleStyle where Self == CheckboxToggleStyle {
    internal static var checkBox: CheckboxToggleStyle { CheckboxToggleStyle() }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
                Image(systemName: "square.fill")
                    .frame(width: 25)
                    .foregroundColor(.white)
                if configuration.isOn {
                    Image(systemName: "checkmark.square.fill")
                        .frame(width: 25)
                        .font(Font.headline)
                        .foregroundColor(.blue)
                }
                Image(systemName: "square")
                    .frame(width: 25)
                    .font(Font.headline.weight(.ultraLight))
                    .foregroundColor(.gray)
            }
            .animation(.default)

            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
