# 考察・戦略・検討文書作成プロジェクト設定

このプロジェクトは考察・戦略・検討内容の文書化に特化したテンプレートリポジトリです。
調査をしながら得られた知見を基に、考察や戦略立案、検討内容を体系的に文書化します。
AI指示書システムを活用して、論理的で質の高い検討文書を効率的に作成します。

## AI指示書システムの使用

タスク開始時は`instructions/ai_instruction_kits/instructions/ja/system/ROOT_INSTRUCTION.md`を読み込んでください。

## プロジェクト設定

- **目的**: 考察・戦略・検討内容の文書化支援
- **対象分野**: IT技術戦略、事業戦略、技術選定、アーキテクチャ検討等
- **言語**: 日本語（英語版も対応可）
- **出力形式**: HTML, PDF, Markdown
- **チェックポイント管理**: 有効
- **チェックポイントスクリプト**: scripts/checkpoint.sh
- **ログファイル**: checkpoint.log

## 重要なパス

- AI指示書システム: `instructions/ai_instruction_kits/`
- 検討文書テンプレート: `templates/deliberation_template.qmd`
- 資料: `sources/`
- 出力先: `output/`
- チェックポイントスクリプト: `scripts/checkpoint.sh`
- プロジェクト固有の設定: このファイル（`instructions/PROJECT.md`）

## 検討文書作成の基本方針

### 必須要素

1. **エグゼクティブサマリ**
   - 1-2ページで検討の背景・結論を要約
   - 主要な検討結果と推奨する方向性を明記

2. **問題定義・検討の背景**
   - 検討が必要となった背景・課題を明確化
   - 検討のスコープと制約条件を定義

3. **選択肢の分析**
   - 複数の選択肢を提示し比較検討
   - 各選択肢のメリット・デメリットを整理

4. **参考文献一覧**
   - 調査で参照した情報源を記載
   - 判断の根拠となるデータの出典を明記

### 品質基準

1. **論理的一貫性**
   - 問題定義から結論までの論理的つながりを確保
   - 判断基準を明確に定義し一貫して適用

2. **多角的視点**
   - 複数の選択肢や視点を検討
   - ステークホルダーごとの影響を分析

3. **明確な区別**
   - 調査で得た事実と考察・推論を明確に区別
   - 前提条件と仮説を明示

4. **判断根拠の明示**
   - 意思決定の根拠をデータや分析に基づいて提示
   - トレードオフの内容を具体的に記述

## コミットルール

- **必須**: `bash scripts/commit.sh "メッセージ"` または `git commit -m "メッセージ"`
- **禁止**: AI署名付きコミット（自動検出・拒否）

## ビルドコマンド

### Quarto統合ビルドシステム（推奨）
```bash
# 初回セットアップ
scripts/setup-quarto.sh

# 基本ビルド
scripts/build-quarto.sh                  # 全形式ビルド
scripts/build-quarto.sh --format html    # HTML形式のみ
scripts/build-quarto.sh --format pdf     # PDF形式のみ
scripts/build-quarto.sh --preview        # ライブプレビュー起動

# 統合開発環境（推奨）
scripts/dev-server.sh

# 直接Quartoコマンド
quarto render                             # プロジェクト全体をビルド
quarto render reports/deliberation.qmd    # 特定ファイルをビルド
quarto preview                            # ライブプレビュー開始
```

### 参考文献チェック（引き続き利用可能）
```bash
scripts/check-references.sh reports/deliberation.qmd
scripts/check-references.sh reports/deliberation.qmd --check-urls
```

### AIによる自動活用指示（Quarto版）
検討文書作成タスクでは、以下のワークフローを活用してください：

1. **初期設定**: `scripts/setup-quarto.sh`でQuarto環境を構築
2. **執筆段階**: `scripts/dev-server.sh`で統合開発環境を開始（推奨）
3. **品質管理**: `scripts/check-references.sh`で引用の整合性確認
4. **中間レビュー**: `quarto render --to html`で高品質プレビュー
5. **最終出力**: `quarto render`で HTML/PDF同時生成

## プロジェクト固有の追加指示

### 検討時の留意事項

- 検討の目的とスコープを最初に明確化する
- 複数の選択肢を必ず提示し比較検討する
- 判断基準（評価軸）を事前に定義する
- 調査で得た事実と独自の考察を明確に分離する

### 執筆時の留意事項

- 専門用語は初出時に説明
- 図表には必ず説明文を付与
- 略語は初出時にフルスペルを記載
- 判断の根拠となるデータは必ず出典を記載

### Markdown記法の留意事項

- **強調表現の後は必ず空行を挿入**: `**太字**`や`*斜体*`の直後に箇条書きや段落を続ける場合は、間に空行を必ず入れる
- **箇条書きの前後**: 箇条書きの前後には空行を入れ、レンダリングの崩れを防ぐ
- **見出しとコンテンツの分離**: 見出し（`#`、`##`等）の後は空行を入れてから本文を開始する

### レビュー時の留意事項

- 論理的一貫性をチェック
- 判断基準の妥当性を確認
- 検討の漏れがないか確認
- 読者視点での分かりやすさを評価
