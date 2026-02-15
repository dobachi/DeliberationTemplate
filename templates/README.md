# 検討文書テンプレート

このディレクトリには、検討文書作成用のテンプレートファイルが含まれています。

## 使い方

1. **テンプレートをコピー**
   ```bash
   cp templates/deliberation_template.qmd reports/my-deliberation.qmd
   ```

2. **検討文書を編集**
   - `reports/my-deliberation.qmd`をエディタで開く
   - タイトル、著者、内容を記入

3. **ビルド**
   ```bash
   make report
   ```

4. **成果物を確認**
   - `output/my-deliberation.html` - HTML版
   - `output/my-deliberation.pdf` - PDF版

## テンプレート一覧

### deliberation_template.qmd
検討文書の基本テンプレート。以下が含まれます：

- エグゼクティブサマリ
- 検討の背景・目的
- 現状分析
- 選択肢の検討と比較分析
- 考察と戦略提言
- 実行計画
- リスクと対策
- 参考文献

### スタイル

- `styles/` - カスタムCSSとSCSSファイル
  - `report-style.css` - 基本スタイル
  - `custom.scss` - カスタマイズ用

## カスタマイズ

テンプレートのメタデータ（YAMLフロントマター）をプロジェクトに合わせて編集してください：

```yaml
title: "検討文書タイトル"
subtitle: "サブタイトル（必要に応じて）"
author:
  - name: 主執筆者名
    affiliation: 所属組織
    email: email@example.com
date: today
```

## 参考

- [Quarto公式ドキュメント](https://quarto.org/docs/guide/)
- [プロジェクトREADME](../README.md)
