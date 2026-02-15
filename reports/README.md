# ユーザー検討文書ディレクトリ

このディレクトリには、あなたが作成する検討文書を配置します。

## 使い方

### 1. テンプレートから検討文書を作成

```bash
# テンプレートをコピー
cp templates/deliberation_template.qmd reports/my-deliberation.qmd

# エディタで編集
vim reports/my-deliberation.qmd
```

### 2. 検討文書をビルド

```bash
# HTML + PDF形式でビルド
make report

# 成果物は output/ に生成されます
ls output/my-deliberation.*
```

### 3. 配布用パッケージを作成

```bash
# 成果物 + ソースをZIPでパッケージ化
make package

# dist/ に生成されます
ls dist/
```

## ファイル構成の推奨

### 単一の検討文書の場合

```
reports/
└── my-deliberation.qmd
```

### 複数の検討文書の場合

```
reports/
├── 2025-ai-strategy.qmd
├── 2025-architecture-review.qmd
└── 2025-tech-selection.qmd
```

## 参考

- [テンプレート一覧](../templates/README.md)
- [サンプル検討文書](../examples/)
- [プロジェクトREADME](../README.md)

## 注意事項

- このディレクトリ内の`.qmd`ファイルはgit管理されません（`.gitignore`で除外）
- ビルド成果物（`.html`, `.pdf`等）も自動的に無視されます
- 検討文書を共有したい場合は、`make package`で配布用パッケージを作成してください
