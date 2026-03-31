# app

一个基于 `SwiftUI + XcodeGen` 的 iOS 国密算法演示项目。当前已接入 **SM2**，并预留了统一算法注册层，便于后续继续接入 `SM3`、`SM4` 或其他算法实现。

## 项目目标

- 提供一个可以直接运行的 iOS SM2 演示界面
- 演示密钥生成、加密解密、签名验签的完整调用链
- 通过统一协议和注册表支持后续扩展更多算法
- 通过 GitHub Actions 自动完成构建、测试、打包和 Release 发布

## 技术栈

- `SwiftUI`：用于构建 iOS 演示界面
- `XcodeGen`：通过 `project.yml` 生成 Xcode 工程
- `GMObjC 4.0.3`：提供 SM2 能力的 Swift Package 依赖
- `XCTest`：用于算法层单元测试

## 目录结构

```text
App/
  ContentView.swift
  CryptoAlgorithmDemoApp.swift
  DemoViewModel.swift
Sources/
  CryptoAlgorithmKit/
    AlgorithmDemo.swift
    AlgorithmDescriptor.swift
    AlgorithmInput.swift
    AlgorithmRegistry.swift
    AlgorithmRunResult.swift
    SM2Algorithm.swift
Tests/
  CryptoAlgorithmKitTests/
    AlgorithmRegistryTests.swift
    SM2AlgorithmTests.swift
.github/workflows/build.yml
project.yml
```

## 本地开发

### 1. 生成工程

```bash
xcodegen generate
```

### 2. 打开工程

```bash
open CryptoAlgorithmDemo.xcodeproj
```

### 3. 命令行测试

```bash
xcodebuild \
  -project CryptoAlgorithmDemo.xcodeproj \
  -scheme CryptoAlgorithmDemo \
  -destination "platform=iOS Simulator,name=iPhone 16" \
  CODE_SIGNING_ALLOWED=NO \
  test
```

## 如何扩展新算法

新增算法时只需要两步：

1. 实现 [`AlgorithmDemo`](./Sources/CryptoAlgorithmKit/AlgorithmDemo.swift) 协议
2. 在 [`AlgorithmRegistry`](./Sources/CryptoAlgorithmKit/AlgorithmRegistry.swift) 中注册新实现

这样 UI 层不需要新增分支逻辑，就能自动显示并执行新的算法演示。

## GitHub Actions / Release

- 推送到 `main`：自动生成工程、执行测试、构建 `iphoneos` 无签名 `.ipa` 并上传 Actions artifact
- 推送 `v*` 标签：在构建成功后自动创建或更新 GitHub Release，并上传无签名 `.ipa`

当前版本号为 `v1.0.3`。

## 平台说明

当前会话运行在 **Windows + PowerShell**。由于本地没有 `Xcode`，iOS 编译与测试验证依赖 GitHub 的 `macOS` Runner 完成。
