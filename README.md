# master_paper

研究用キーボードと生活情報による生活状態モデルの修士論文原稿。

## このブランチの提案構成

**固定24活動分類と独立Task推定の重複をやめ、共有三階層LSTMからPlace・Behavior・現在/日次5尺度を扱う。** Behaviorのカテゴリ数は固定せず、埋め込みのプロトタイプと時間遷移から個人固有の候補を発見する。本人確認と命名を機械の候補生成とは区別する。

- 実装PR: [switch_bot_python #9](https://github.com/shunsuke-tanaka-creator/switch_bot_python/pull/9)
- アプリ互換性PR: [communication-keyboard #8](https://github.com/shunsuke-tanaka-creator/communication-keyboard/pull/8)
- サーバー仕様: [life-pattern-discovery.md](https://github.com/shunsuke-tanaka-creator/switch_bot_python/blob/feat/unified-life-pattern-discovery/docs/life-pattern-discovery.md)

本番への切替・デプロイ・実参加者での精度検証を完了したという意味ではない。サーバーの既定はlegacyで、新方式は`research_architecture=discovery`で明示選択する。

## 章構成

- 第1章: [序論](chapters/01-introduction.md)
- 第2章: [ライフログ研究の展開と生活状態モデルの数理的基盤](chapters/02-related-work.md)
- 第3章: [生活情報の観測と学習データ構築](chapters/03-system.md)
- 第4章: [共有三階層LSTMによる生活パターン発見と状態推定](chapters/04-model.md)
- 第5章: [探索的予備研究の評価計画と考察観点](chapters/05-evaluation.md)
- 第6章: [結論](chapters/06-conclusion.md)
- [謝辞](chapters/07-acknowledgements.md)
- [参考文献](references.bib): BibTeXを正本とし、本文は`[@キー]`で引用する。

**方式の区別:** 第2章2.3.3のGrowingMapの詳細は従来方式の数理である。生観測の共通座標による距離、半径0.35、12時間の遷移条件は、提案方式の埋め込み・コサイン類似度0.88・1時間の遷移条件へ流用しない。提案方式の仕様は第3・4章と対応実装を基準とする。旧方式の関連説明と提案方式の表現の整理は査読時にも確認する。

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

ローカルSentenceTransformerの文章表現は固定射影で32次元化する。未指定の文字n-gram経路は意味モデルとは区別する。入力原文を外部AIサービスへ送信しない。

## 実装と評価の境界

重みと候補マップの更新はバッチ再学習で行う。ライブ推論時に隠れ状態を持ち越したり、クラスタを逐次永続化したりする構成ではない。新たな未知候補は次回学習へ反映する。モデル更新時は既知IDの元観測を再埋め込みし、異なるモデルの重心を混ぜない。

新状態に対する運動・休憩の自動提案は未検証のため停止する。旧方式の動作は変更しない。状態保持型TBPTT、参加者間共有、全アブレーションの切替、参加者macro集計、未知検出の詳細評価は、実装済みの基本経路と評価計画を分けて記述する。

第5章は最大5名・14日間の探索的計画である。実験結果・有効性を追記する際は、実行したcommit、モデル版、分割時刻、文章モデル、データモードを固定する。合成テストの成功は実データ精度の証明ではない。

## 補助資料と履歴

`notes/ideas`・`notes/literature`・`notes/meeting`は検討メモ、`figures`は図、`experiments/YYYY-MM-DD-名前/`は実験記録を保存する。旧図を新方式の構造としてそのまま流用しない。

以下は変更前の原稿・実装を対象とした履歴資料であり、今回の改稿後に表示数式数や指摘番号を再検証した資料ではない。

- [2026-11-17 総合査読](reviews/2026-11-17-comprehensive-review.md)
- [変更前の全51表示数式の点検](reviews/2026-11-17-equations.md)
- [検証範囲・未検証事項](reviews/2026-11-17-coverage.md)
- [参考文献19件の書誌照合](reviews/2026-11-17-bibliography.md)
- [変更前の出現索引](reviews/2026-11-17-manuscript-index.json)
