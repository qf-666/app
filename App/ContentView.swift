import CryptoAlgorithmKit
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: DemoViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("算法") {
                    Picker("当前算法", selection: $viewModel.selectedAlgorithmID) {
                        ForEach(viewModel.availableAlgorithms) { algorithm in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(algorithm.name)
                                Text(algorithm.summary)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .tag(algorithm.id)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("输入") {
                    TextField("演示明文", text: $viewModel.message, axis: .vertical)
                        .lineLimit(3...6)

                    TextField("SM2 User ID", text: $viewModel.userID)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section {
                    Button("运行演示") {
                        viewModel.runSelectedDemo()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                if let result = viewModel.result {
                    Section(result.algorithmName) {
                        Text(result.summary)
                            .font(.subheadline)

                        ForEach(result.fields) { field in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(field.title)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(field.value)
                                    .font(.footnote.monospaced())
                                    .textSelection(.enabled)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Section("错误") {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }

                Section("扩展方式") {
                    Text("新增算法时，实现 AlgorithmDemo 协议并注册到 AlgorithmRegistry 即可，界面层无需再写新的分支逻辑。")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("国密算法 Demo")
        }
    }
}

