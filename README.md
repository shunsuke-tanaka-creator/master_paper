# master_paper

研究用キーボードと生活情報による生活状態モデルの修士論文原稿。

## 原稿の編集とPDFの生成

[thesis.tex](thesis.tex)で表紙と文書全体の設定を管理し、本文は`chapters/`内の章別`.tex`を編集する。章節・図の番号はLaTeXが付ける。本文の引用には`\autocite{引用キー}`、相互参照には`\label`と`\ref`を使う。

XeLaTeX、latexmk、Biber、Noto Serif CJK JPが必要。Ubuntuでは`texlive-xetex`、`texlive-lang-chinese`（`xeCJK`に必要なパッケージを含む）、`texlive-latex-extra`、`texlive-fonts-recommended`、`texlive-bibtex-extra`、`latexmk`、`biber`、`fonts-noto-cjk`で揃う。

```bash
bash scripts/build_pdf.sh
```

生成先は`build/thesis.pdf`。`sample/`には過去の版を収録している。

## 論文の主構成と関連PR

**固定24活動分類と独立Task推定の重複をやめ、共有三階層LSTMからPlace・Behavior・現在/日次5尺度を扱う。** Behaviorのカテゴリ数は固定せず、埋め込みのプロトタイプと時間遷移から個人固有の候補を発見する。本人確認と命名を機械の候補生成とは区別する。

本READMEは、指定された2026-11-18の統合後を想定した構成を記す。

- サーバー実装: [switch_bot_python #9](https://github.com/shunsuke-tanaka-creator/switch_bot_python/pull/9)は2026-11-18に`main`へマージ済みである。
- iOSアプリ互換性: [communication-keyboard #8](https://github.com/shunsuke-tanaka-creator/communication-keyboard/pull/8)は2026-11-18に`main`へマージ済みである。
- 修論原稿: PR #1（`feat/unified-life-pattern-discovery`）は、`main`の`c4af3d2`を統合した本原稿を`main`へ取り込むPRである。関連実装PRの統合と、修論PR自身のマージは別の操作である。
- サーバー仕様: `main`の[life-pattern-discovery.md](https://github.com/shunsuke-tanaka-creator/switch_bot_python/blob/main/docs/life-pattern-discovery.md)および`research/discovery_{model,learning,map,service,cli}.py`を基準とする。

本番への切替・デプロイ・実参加者での精度検証は別途必要である。サーバーの既定は`legacy`で、新方式は`research_architecture=discovery`で明示選択する。

## 章構成

- 第1章: [序論](chapters/01-introduction.tex)
- 第2章: [ライフログ研究の展開と生活状態モデルの数理的基盤](chapters/02-related-work.tex)
- 第3章: [生活情報の観測と学習データ構築](chapters/03-system.tex)
- 第4章: [共有三階層LSTMによる生活パターン発見と状態推定](chapters/04-model.tex)
- 第5章: [探索的予備研究の評価計画と考察観点](chapters/05-evaluation.tex)
- 第6章: [結論](chapters/06-conclusion.tex)
- [謝辞](chapters/07-acknowledgements.tex)
- [参考文献](references.bib)

**方式の区別:** 第2章2.3.3のGrowingMapの詳細は従来方式の数理である。生観測の共通座標による距離、半径0.35、12時間の状態変更条件は、提案方式の埋め込み・コサイン類似度0.88・1時間の状態変更条件へ流用しない。従来方式の固定24活動分類、独立Task推定、個人履歴による条件付け、部分プーリング、暫定推定と切替、状態内歩数による提案、PMTTは、第2章および第4章末尾で背景・比較条件として保持する。提案方式の仕様は第3・4章と対応実装を基準とする。

## モデルの役割

| 要素 | 提案構成 | 従来・比較構成 |
| --- | --- | --- |
| 三階層LSTM | 一つの共有エンコーダ、入力98・隠れ48 | 24活動と現在/日次5尺度 |
| Place / Behavior | 独立した各32次元射影と本人確認ID | 独立ContextLSTMのplace/task |
| パターンマップ | DiscoveryMap、訓練側で構築し推論時は固定 | 生観測GrowingMap |
| 24活動 | 事後の説明注釈・旧分類器の比較 | 固定分類の教師と出力 |
| 5尺度 | 回答済み座標のHuber損失、支持不足は非表示 | 旧個人履歴条件付け・暫定値の経路 |
| SSL | 再構成・将来予測と教師損失の同時学習 | 独立した事前学習実験 |
| 個人適応 | 個人の観測・確認による表現とID | 部分プーリング・prequentialは独立比較 |

新構成の版は`life-discovery-v1`。`task`は保存・通信上のBehaviorの互換名で、別の推定器ではない。旧基本モデルの86,050というパラメータ数を新構成の数値として引用しない。

文章特徴は共通のLocalEncoderで生成する。主条件はローカルSentenceTransformerの`sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2`であり、384次元の出力を固定射影で32次元化する。新方式のCLIでは`--text-model`による明示指定が必要で、未指定の文字n-gram経路は比較条件として区別する。入力原文を外部AIサービスへ送信しない。

従来の基本モデルの版は`hierarchical-v2-received-cutoff`、独立ContextLSTMの版は`behavior-context-v2-received-cutoff`である。独立ContextLSTMの隠れ次元24は、提案する共有エンコーダの隠れ次元48とは区別する。GPSによる拠点推定は用いない。

補助的な「普段との差」の処理には、入力訂正率の`typing_change`、過去56日の`conditional`、過去84日の`weekday_trends`がある。訂正率は日単位に集約し、1日50 inserts以上を有効日、基準を暫定3日・正式5日、閾値を99パーセンタイルと0.02の大きい方とする。これらは共有エンコーダによる推定とは別の処理であり、新状態に基づく運動提案の有効性を示すものではない。

## 実装と評価の境界

重みと候補マップの更新はバッチ再学習で行う。ライブ推論時に隠れ状態を持ち越したり、クラスタを逐次永続化したりする構成ではない。未知観測からの候補生成は次回学習へ反映する。モデル更新時は既知IDの元観測を再埋め込みし、異なるモデルの重心を混ぜない。

新状態に基づく運動提案は停止する。Discoveryの休憩支援は既定の `discovery_support_mode=shadow` では判定・記録のみを行い、新支援質問を配信しない。研究処理と `live` を明示的に有効化した場合は、支援条件・質問予算等を満たす質問を配信する。支援効果は未検証である。旧方式の動作は変更しない。状態保持型TBPTT、参加者間共有、全アブレーションの切替、参加者macro集計、未知検出の詳細評価は、実装済みの基本経路と評価計画を分けて記述する。

第5章は最大5名・14日間の探索的計画である。実験結果・有効性を追記する際は、実行したcommit、モデル版、分割時刻、文章モデル、データモードを固定する。合成テストの成功は実データ精度の証明ではない。

## 補助資料と履歴

`notes/ideas`・`notes/literature`・`notes/meeting`は検討メモ、`figures`は図、`experiments/YYYY-MM-DD-名前/`は実験記録を保存する。旧図を新方式の構造としてそのまま流用しない。

以下は変更前の原稿・実装を対象とした履歴資料であり、改稿後の新方式の図・数式や有効性を検証した資料として流用しない。

- [2026-11-17 総合査読](reviews/2026-11-17-comprehensive-review.md)
- [変更前の全51表示数式の点検](reviews/2026-11-17-equations.md)
- [検証範囲・未検証事項](reviews/2026-11-17-coverage.md)
- [参考文献19件の書誌照合](reviews/2026-11-17-bibliography.md)
- [変更前の出現索引](reviews/2026-11-17-manuscript-index.json)

`fig_hierarchical_lstm.png`、`fig_system_overview.png`、`fig_growingmap.png`は従来構成の図としてのみ参照する。ファイルは保持するが、共有エンコーダとDiscoveryMapの検証済み構造図とは扱わない。

## mainの整合修正と動作確認資料

`main`の`c4af3d2`に含まれる整合修正を保持する。従来GrowingMapでは、使用しない近傍更新式を採用せず、座標別回数に基づく逐次平均（coordinate means）を用いる。状態変更回数を$N_{ab}$、自己遷移を除く変更先構成比（state-change ratios）を$Q_{ab}$とし、分母0は未定義とする。これは滞在を含む次観測の予測確率ではない。提案DiscoveryMapの正規化プロトタイプ更新とは別の式である。

文エンコーダのSentenceTransformerへの整合は、両方式に共通する入力特徴の条件として第3章3.2.2に保持する。[2026-11-17の導入確認](experiments/2026-11-17-sentence-encoder/README.md)は合成データ等による実装動作確認であり、実参加者での精度改善や新方式の意味分離の結果ではない。

[thesis_updated_20261117.pdf](sample/thesis_updated_20261117.pdf)は、2026-11-17の修正を記録した版である。
