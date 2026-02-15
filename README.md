# DeliberationTemplate

[![GitHub Pages](https://img.shields.io/badge/docs-GitHub%20Pages-blue)](https://dobachi.github.io/DeliberationTemplate/)
[![License](https://img.shields.io/badge/license-Apache%202.0-green)](LICENSE)

Quartoを使用した考察・戦略・検討内容の文書化テンプレートリポジトリです。
調査をしながら得られた知見を基に、考察や戦略立案、検討内容を体系的に文書化します。

> 詳細な使い方は[GitHub Pages](https://dobachi.github.io/DeliberationTemplate/)をご覧ください

## 特徴

- **調査と考察の統合**: 調査で得た知見を基に考察・戦略を文書化
- **意思決定の記録**: 検討過程と判断根拠を構造的に記録
- **多角的分析**: 複数の選択肢の比較検討をサポート
- **高品質出力**: HTML / PDF / EPUB対応
- **参考文献管理**: BibTeX統合
- **自動化**: GitHub Actions対応

## ResearchTemplateとの違い

| 観点 | ResearchTemplate | DeliberationTemplate |
|------|-----------------|---------------------|
| 目的 | 調査結果の報告 | 考察・戦略・検討の文書化 |
| 重点 | 事実の収集と整理 | 分析・判断・意思決定 |
| 成果物 | 調査報告書 | 検討文書・戦略文書 |
| 構成 | 調査方法→結果→考察 | 問題定義→選択肢分析→戦略→判断 |

## クイックスタート

### 1. リポジトリの準備

```bash
# このリポジトリをfork/cloneまたはテンプレートから作成
git clone https://github.com/dobachi/DeliberationTemplate.git
cd DeliberationTemplate
```

### 2. 環境セットアップ（初回のみ）

```bash
# Git submoduleの初期化
git submodule update --init --recursive
```

Quartoの自動セットアップ（推奨）:

```bash
scripts/setup.sh
```

### 3. 検討文書を作成

```bash
# テンプレートをコピー
cp templates/deliberation_template.qmd reports/my-deliberation.qmd

# エディタで編集
vim reports/my-deliberation.qmd
```

### 4. ビルド

```bash
# HTML + PDFでビルド
make report

# 成果物を確認
ls output/
```

### 5. 配布パッケージ作成（オプション）

```bash
# 検討文書をZIPパッケージ化（成果物 + ソース）
make package

# dist/に生成されます
ls dist/
```

## 基本コマンド

```bash
make help              # ヘルプ表示
make report            # 検討文書をビルド（HTML + PDF）-> output/
make examples          # サンプルをビルド（HTML + PDF）-> output/examples/
make package           # 配布パッケージ作成 -> dist/
make preview           # ライブプレビュー
make clean             # ビルド成果物削除
```

## ドキュメント

- **[使い方ガイド](https://dobachi.github.io/DeliberationTemplate/)** - 詳細な使用方法とワークフロー
- **[サンプル検討文書](https://dobachi.github.io/DeliberationTemplate/examples/strategy-ai-adoption.html)** - 検討文書の実例
- **[テンプレート一覧](templates/README.md)** - 利用可能なテンプレート

## 要件

### 必須

- [Quarto](https://quarto.org/docs/get-started/) 1.3以上
- Git
- Pandoc

### 推奨（PDF生成用）

- LuaLaTeX（日本語PDF対応）
- luatexja（日本語組版パッケージ）
- Noto Sans CJK JP フォント（日本語対応）

## プロジェクト構造

```
DeliberationTemplate/
├── templates/          # テンプレートファイル
├── reports/            # ユーザーの検討文書（あなたが作成）
├── examples/           # サンプル検討文書
├── sources/            # リソース（参考文献、図表）
├── output/             # ビルド成果物
└── dist/               # 配布パッケージ
```

## AI指示書システム（オプション）

このプロジェクトは[AI指示書システム](https://github.com/dobachi/AI_Instruction_Kits)をgitサブモジュールとして導入できます。

**対応AIツール**:
- Claude Code（推奨）
- Cursor
- その他のAIコーディングアシスタント

**使い方**:
- AIツールは自動的に`CLAUDE.md`や`CURSOR.md`を読み込みます
- プロジェクト固有の指示は`instructions/PROJECT.md`を参照
- チェックポイント機能: `scripts/checkpoint.sh`で作業履歴を記録

詳細は[CLAUDE.md](CLAUDE.md)を参照してください。

## ライセンス

[Apache-2.0](LICENSE)

## リンク

- [GitHub Pages](https://dobachi.github.io/DeliberationTemplate/) - 詳細ドキュメント
- [Issues](https://github.com/dobachi/DeliberationTemplate/issues) - バグ報告・機能要望
- [ResearchTemplate](https://github.com/dobachi/ResearchTemplate) - 調査報告書テンプレート（姉妹プロジェクト）
- [Quarto公式ドキュメント](https://quarto.org/docs/guide/) - Quartoの詳細
