import CryptoAlgorithmKit
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: DemoViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("算法") {
                    ForEach(viewModel.availableAlgorithms) { algorithm in
                        Button {
                            viewModel.selectAlgorithmAndRun(algorithm.id)
                        } label: {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(algorithm.name)
                                        .font(.body.weight(.semibold))
                                        .foregroundStyle(.primary)
                                    Text(algorithm.summary)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                if algorithm.id == viewModel.selectedAlgorithmID {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                } else {
                                    Image(systemName: "play.circle")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }

                Section("输入") {
                    TextField("演示明文", text: $viewModel.message, axis: .vertical)
                        .lineLimit(3...6)

                    TextField("SM2 User ID", text: $viewModel.userID)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section("说明") {
                    Text("点上面的算法项会立即执行当前算法，并用下面的输入参数生成结果。")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
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
