# GitHub リポジトリ設定ガイド

このドキュメントでは、検討文書テンプレートプロジェクトをGitHubで公開・管理する手順を説明します。

## 前提条件

- GitHubアカウントを持っていること
- Git CLIがインストールされていること
- GitHub CLI (`gh`) がインストールされていること（推奨）

## セットアップ手順

### 1. GitHubでリポジトリを作成

#### 方法A: GitHub CLI を使用（推奨）

```bash
# GitHub CLIでログイン（初回のみ）
gh auth login

# リポジトリを作成（publicテンプレート）
gh repo create DeliberationTemplate --public --description "考察・戦略・検討文書化テンプレート" --clone=false

# リモートリポジトリを追加
git remote add origin https://github.com/YOUR_USERNAME/DeliberationTemplate.git
```

#### 方法B: GitHub Webサイトで作成

1. [GitHub](https://github.com) にログイン
2. 右上の「+」から「New repository」を選択
3. 以下を設定：
   - Repository name: `DeliberationTemplate`
   - Description: `考察・戦略・検討文書化テンプレート`
   - Public を選択
   - **Initialize this repository with a README は選択しない**（既にあるため）
4. 「Create repository」をクリック

### 2. ローカルリポジトリをGitHubに接続

```bash
# リモートリポジトリを追加（Webでリポジトリを作成した場合）
git remote add origin https://github.com/YOUR_USERNAME/DeliberationTemplate.git

# リモートの確認
git remote -v

# メインブランチをpushして追跡設定
git push -u origin main
```

### 3. テンプレートリポジトリとして設定

GitHubでテンプレートリポジトリとして設定すると、他の人が「Use this template」ボタンで簡単に使用できます。

1. GitHubでリポジトリページを開く
2. Settings タブをクリック
3. General セクションで「Template repository」にチェック
4. 保存

### 4. GitHub Pages の設定（オプション）

サンプル検討文書をWebで公開する場合：

1. Settings → Pages
2. Source: Deploy from a branch
3. Branch: main、フォルダ: `/docs` または `/` を選択
4. Save

### 5. トピックスとAboutの設定

リポジトリを見つけやすくするため：

1. リポジトリトップページの歯車アイコン（About欄）をクリック
2. 以下を設定：
   - Description: 考察・戦略・検討文書化テンプレート
   - Website: GitHub Pages URL（設定した場合）
   - Topics:
     - `deliberation-template`
     - `strategy-document`
     - `ai-powered`
     - `documentation`
     - `japanese`

## リリースの作成

安定版をリリースとして公開：

```bash
# タグを作成
git tag -a v1.0.0 -m "初回リリース: 検討文書テンプレート完成"

# タグをpush
git push origin v1.0.0
```

またはGitHub上で：

1. Releases → Create a new release
2. Tag version: `v1.0.0`
3. Release title: `v1.0.0 - 初回リリース`
4. リリースノートを記載
5. 「Publish release」

## 推奨される追加設定

### Issue テンプレート

`.github/ISSUE_TEMPLATE/` ディレクトリに以下のテンプレートを作成：

#### bug_report.md
```markdown
---
name: バグ報告
about: 問題の報告
title: '[BUG] '
labels: bug
---

## 問題の説明

## 再現手順

## 期待される動作

## 環境
- OS:
- ブラウザ:
```

#### feature_request.md
```markdown
---
name: 機能要望
about: 新機能の提案
title: '[FEATURE] '
labels: enhancement
---

## 提案内容

## 理由・背景

## 想定される使用例
```

### Pull Request テンプレート

`.github/pull_request_template.md`:

```markdown
## 変更内容

## 変更の理由

## チェックリスト
- [ ] README.mdを更新した
- [ ] サンプルをテストした
- [ ] ドキュメントを更新した
```

### GitHub Actions（CI/CD）

`.github/workflows/check.yml`:

```yaml
name: 品質チェック

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup Quarto
      uses: quarto-dev/quarto-actions/setup@v2
    - name: Build test
      run: |
        quarto render examples/ --to html
```

## 使用開始

他の人がこのテンプレートを使う方法：

### テンプレートから新規リポジトリ作成

1. テンプレートリポジトリにアクセス
2. 「Use this template」ボタンをクリック
3. 新しいリポジトリ名を入力
4. 「Create repository from template」をクリック

### クローンして使用

```bash
# テンプレートをクローン
git clone https://github.com/YOUR_USERNAME/DeliberationTemplate.git my-deliberation

# ディレクトリに移動
cd my-deliberation

# originを削除して自分のリポジトリに変更
git remote remove origin
git remote add origin https://github.com/MY_USERNAME/my-deliberation.git

# サブモジュールを初期化
git submodule update --init --recursive
```

## プロジェクトの説明文

GitHubのREADMEに追加する説明：

```markdown
## このテンプレートの特徴

- **AI支援**: AI指示書システムによる分析・執筆支援
- **構造化**: エグゼクティブサマリと戦略提言を含む標準構成
- **品質管理**: 論理的整合性と多角的視点の確保
- **マルチフォーマット**: HTML/PDF出力対応
- **実例付き**: AI導入戦略検討のサンプル文書

## クイックスタート

[![Use this template](https://img.shields.io/badge/Use%20this-template-blue)](https://github.com/YOUR_USERNAME/DeliberationTemplate/generate)

詳細は[セットアップガイド](GITHUB_SETUP.md)を参照してください。
```

## バッジの追加

README.mdに以下のバッジを追加可能：

```markdown
![License](https://img.shields.io/badge/license-Apache%202.0-blue)
![Template](https://img.shields.io/badge/template-deliberation-green)
![AI Powered](https://img.shields.io/badge/AI-Powered-orange)
```

## プロジェクトの成長

- Star数の追跡
- Fork数の確認
- Issue/PRの管理
- Discussionsの活用（Q&Aやアイデア共有）

---

これでGitHubテンプレートリポジトリとして公開準備が完了です！
