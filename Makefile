# 検討文書ビルドシステム Makefile
# 設計原則：
# 1. templates/ = テンプレートファイル（ビルド対象外、コピー元）
# 2. reports/ = ユーザーの検討文書（ビルド対象）
# 3. examples/ = サンプル検討文書（ビルド対象、GitHub Pages表示）
# 4. output/ = ビルド成果物
# 5. dist/ = 配布用パッケージ

# 設定
OUTPUT_DIR := output
DIST_DIR := dist
PACKAGE_NAME := deliberation-$(shell date +%Y%m%d)

# デフォルトターゲット
.PHONY: all
all: examples

# ヘルプ表示
.PHONY: help
help:
	@echo "利用可能なコマンド:"
	@echo ""
	@echo "【検討文書作成】"
	@echo "  make report          - reports/内の検討文書をビルド（HTML + PDF）"
	@echo "  make report-html     - reports/内の検討文書をHTMLでビルド"
	@echo "  make report-pdf      - reports/内の検討文書をPDFでビルド"
	@echo ""
	@echo "【サンプル・デモ】"
	@echo "  make examples        - examples/内のサンプル検討文書をビルド（HTML + PDF）"
	@echo "  make examples-html   - examples/内のサンプル検討文書をHTMLでビルド"
	@echo "  make examples-pdf    - examples/内のサンプル検討文書をPDFでビルド"
	@echo ""
	@echo "【配布】"
	@echo "  make package         - 検討文書を配布用パッケージ化（成果物 + ソース）"
	@echo ""
	@echo "【開発・プレビュー】"
	@echo "  make preview         - ライブプレビュー起動"
	@echo "  make clean           - ビルド成果物を削除"
	@echo ""
	@echo "【使い方】"
	@echo "  1. cp templates/deliberation_template.qmd reports/my-deliberation.qmd"
	@echo "  2. vim reports/my-deliberation.qmd  # 検討文書を編集"
	@echo "  3. make report                      # ビルド"
	@echo "  4. make package                     # 配布用ZIP作成"

# ===============================================
# ユーザー検討文書のビルド
# ===============================================

.PHONY: report
report: report-html report-pdf
	@echo "ビルド完了"
	@echo "成果物: $(OUTPUT_DIR)/"
	@find $(OUTPUT_DIR) -maxdepth 1 \( -name "*.html" -o -name "*.pdf" \) -exec ls -lh {} \; 2>/dev/null || echo "  （ファイルなし）"

.PHONY: report-html
report-html:
	@echo "reports/内の検討文書をHTMLでビルド中..."
	@if [ -z "$$(find reports -name '*.qmd' -not -name 'README.md' 2>/dev/null)" ]; then \
		echo "reports/内に.qmdファイルがありません"; \
		echo "   cp templates/deliberation_template.qmd reports/my-deliberation.qmd"; \
		exit 0; \
	fi
	@quarto render reports/ --to html --output-dir $(OUTPUT_DIR)
	@echo "HTML生成完了"
	@echo "HTML出力先: $(OUTPUT_DIR)/"

.PHONY: report-pdf
report-pdf:
	@echo "reports/内の検討文書をPDFでビルド中..."
	@if [ -z "$$(find reports -name '*.qmd' -not -name 'README.md' 2>/dev/null)" ]; then \
		echo "reports/内に.qmdファイルがありません"; \
		exit 0; \
	fi
	@quarto render reports/ --to pdf --output-dir $(OUTPUT_DIR)
	@echo "PDF生成完了"
	@echo "PDF出力先: $(OUTPUT_DIR)/"

# ===============================================
# サンプル検討文書のビルド（GitHub Pages表示用）
# ===============================================

.PHONY: examples
examples: examples-html examples-pdf
	@echo "サンプルビルド完了"
	@echo "成果物: $(OUTPUT_DIR)/examples/"
	@find $(OUTPUT_DIR)/examples -name "*.html" -o -name "*.pdf" 2>/dev/null | xargs ls -lh 2>/dev/null || echo "  （ファイルなし）"

.PHONY: examples-html
examples-html:
	@echo "examples/内のサンプル検討文書をHTMLでビルド中..."
	@mkdir -p $(OUTPUT_DIR)
	@quarto render examples/ --to html --output-dir $(OUTPUT_DIR)
	@echo "サンプルHTML生成完了"
	@echo "HTML出力先: $(OUTPUT_DIR)/examples/"
	@ls -lh $(OUTPUT_DIR)/examples/*.html 2>/dev/null || echo "  （HTMLファイルなし）"

.PHONY: examples-pdf
examples-pdf:
	@echo "examples/内のサンプル検討文書をPDFでビルド中..."
	@mkdir -p $(OUTPUT_DIR)
	@quarto render examples/ --to pdf --output-dir $(OUTPUT_DIR)
	@echo "サンプルPDF生成完了"
	@echo "PDF出力先: $(OUTPUT_DIR)/examples/"
	@ls -lh $(OUTPUT_DIR)/examples/*.pdf 2>/dev/null || echo "  （PDFファイルなし）"

# ===============================================
# 配布用パッケージ作成
# ===============================================

.PHONY: package
package:
	@echo "Quartoビルド可能な配布パッケージ作成中..."
	@
	@# ディレクトリ構造を作成
	@mkdir -p $(DIST_DIR)/package/templates/styles
	@mkdir -p $(DIST_DIR)/package/sources/references
	@mkdir -p $(DIST_DIR)/package/sources/diagrams
	@mkdir -p $(DIST_DIR)/package/reports
	@mkdir -p $(DIST_DIR)/package/scripts
	@
	@# Quarto設定ファイルを生成（パッケージ用に調整）
	@echo "  - Quarto設定ファイルを生成中..."
	@echo "project:" > $(DIST_DIR)/package/_quarto.yml
	@echo "  output-dir: output" >> $(DIST_DIR)/package/_quarto.yml
	@echo "" >> $(DIST_DIR)/package/_quarto.yml
	@echo "format:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  html:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    theme:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "      - journal" >> $(DIST_DIR)/package/_quarto.yml
	@echo "      - templates/styles/custom.scss" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    toc: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    toc-depth: 3" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    number-sections: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    code-fold: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    css: templates/styles/report-style.css" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    link-external-newwindow: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  pdf:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    documentclass: ltjsbook" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    toc: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    number-sections: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    geometry: margin=2cm" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    pdf-engine: lualatex" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    include-in-header:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "      - text: |" >> $(DIST_DIR)/package/_quarto.yml
	@echo "          \\usepackage{luatexja-fontspec}" >> $(DIST_DIR)/package/_quarto.yml
	@echo "          \\setmainjfont{Noto Sans CJK JP}" >> $(DIST_DIR)/package/_quarto.yml
	@echo "" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  docx:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    toc: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    number-sections: true" >> $(DIST_DIR)/package/_quarto.yml
	@echo "    highlight-style: github" >> $(DIST_DIR)/package/_quarto.yml
	@echo "" >> $(DIST_DIR)/package/_quarto.yml
	@echo "bibliography: sources/references/bibliography.bib" >> $(DIST_DIR)/package/_quarto.yml
	@echo "" >> $(DIST_DIR)/package/_quarto.yml
	@echo "crossref:" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  fig-title: \"図\"" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  tbl-title: \"表\"" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  title-delim: \":\"" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  fig-prefix: \"図\"" >> $(DIST_DIR)/package/_quarto.yml
	@echo "  tbl-prefix: \"表\"" >> $(DIST_DIR)/package/_quarto.yml
	@
	@# テンプレートとスタイルをコピー
	@echo "  - テンプレートとスタイルをコピー中..."
	@cp templates/deliberation_template.qmd $(DIST_DIR)/package/templates/ 2>/dev/null || true
	@cp -r templates/styles/* $(DIST_DIR)/package/templates/styles/ 2>/dev/null || true
	@
	@# 参考文献をコピー
	@echo "  - 参考文献をコピー中..."
	@cp sources/references/*.bib $(DIST_DIR)/package/sources/references/ 2>/dev/null || true
	@
	@# 図表ソースをコピー
	@echo "  - 図表ソースをコピー中..."
	@cp -r sources/diagrams/* $(DIST_DIR)/package/sources/diagrams/ 2>/dev/null || true
	@
	@# 検討文書ソースをコピー（reports/ または examples/）
	@echo "  - 検討文書ソースをコピー中..."
	@if [ -n "$$(find reports -name '*.qmd' -not -name 'README.md' 2>/dev/null)" ]; then \
		find reports -name '*.qmd' -not -name 'README.md' -exec cp {} $(DIST_DIR)/package/reports/ \; 2>/dev/null || true; \
		echo "    reports/からコピーしました"; \
	else \
		find examples -name '*.qmd' -exec cp {} $(DIST_DIR)/package/reports/ \; 2>/dev/null || true; \
		echo "    examples/からコピーしました（サンプル）"; \
	fi
	@
	@# ビルドスクリプトをコピー
	@echo "  - ビルドスクリプトをコピー中..."
	@cp scripts/build-quarto.sh $(DIST_DIR)/package/scripts/ 2>/dev/null || true
	@cp scripts/setup-quarto.sh $(DIST_DIR)/package/scripts/ 2>/dev/null || true
	@chmod +x $(DIST_DIR)/package/scripts/*.sh 2>/dev/null || true
	@
	@# Makefileをコピー
	@echo "  - Makefileをコピー中..."
	@cp Makefile $(DIST_DIR)/package/
	@
	@# ZIP圧縮
	@echo "  - アーカイブを作成中..."
	@cd $(DIST_DIR) && zip -r $(PACKAGE_NAME).zip package/ > /dev/null
	@rm -rf $(DIST_DIR)/package
	@
	@echo "パッケージ生成完了: $(DIST_DIR)/$(PACKAGE_NAME).zip"
	@ls -lh $(DIST_DIR)/$(PACKAGE_NAME).zip

# ===============================================
# プレビュー・開発
# ===============================================

.PHONY: preview
preview:
	@echo "ライブプレビューを開始..."
	@echo "   reports/内の.qmdファイルを編集すると自動的に再ビルドされます"
	@quarto preview reports/

# ===============================================
# クリーンアップ
# ===============================================

.PHONY: clean
clean:
	@echo "ビルド成果物を削除中..."
	@rm -rf $(OUTPUT_DIR)/
	@rm -rf $(DIST_DIR)/
	@rm -rf .quarto/
	@rm -rf reports/*.html reports/*.pdf reports/*.epub reports/*_files/
	@rm -rf examples/*.html examples/*.pdf examples/*.epub examples/*_files/
	@echo "クリーンアップ完了"

# ===============================================
# ディレクトリ作成
# ===============================================

$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

$(DIST_DIR):
	@mkdir -p $(DIST_DIR)
