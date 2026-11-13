# master_paper

修士論文の原稿を少しずつ構築するためのリポジトリ。
対象システムは `switch_bot_python`（収集・学習・推論サーバー）と `communication-keyboard`（iOS研究用キーボード）。

## 関連リポジトリ

- 収集・学習・推論サーバー: [switch_bot_python](https://github.com/shunsuke-tanaka-creator/switch_bot_python)
- iOS研究用キーボード: [communication-keyboard](https://github.com/shunsuke-tanaka-creator/communication-keyboard)

## 使用モデル概要

本文の「提案手法」「実装」で参照するためのメモ。詳細は各リポジトリのコードと `docs/` を正とする。

- **三階層LSTM（HierarchicalLSTM）** — 生活状態推定の本体。Micro／Meso／Macro の3階層で、現在の5尺度（気分・疲労・ストレス・集中度・眠気）と日次5尺度、活動分類を推定する。入力98次元、隠れ層48次元、パラメータ数 86,050。特徴仕様バージョンは `hierarchical-v2-received-cutoff`（受信時刻ベースの因果カットオフ）。
- **ContextLSTM** — 拠点（場所）とタスクの推定モデル。隠れ層24次元、場所／タスク埋め込み各32次元。仕様バージョンは `behavior-context-v2-received-cutoff`。GPSは使わない。
- **LocalEncoder** — 文章特徴用のローカル SentenceTransformer（BERT系、隠れ384次元）。埋め込みを固定ランダム射影で32次元化して三階層LSTMへ入力する。参加者の入力原文を外部サービスへ送信しないため、エンコーダはローカル実行のみ。
- **typing_change** — 入力（訂正率）の普段との差の検出。日単位プーリングで1日50 inserts以上を有効日とし、基準は暫定3日／正式5日、閾値は99パーセンタイル。
- **GrowingMap** — 入力行動パターンを逐次クラスタリングする生活状態マップ（最大256ノード）。
- **個人ベースライン（conditional／weekday_trends）** — 過去56日を使った条件付き個人ベースラインと、曜日×時間帯の傾向推定。推定値そのものではなく「普段との差」の根拠として使う。

## 学習まわりの前提

- データモードは `real`／`sample`／`combined` の3種（サンプルは合成データで、実データとは参加者を分けて管理）。
- 本番モデルはオンライン学習ではない。推論は60秒間隔で固定モデルを使い、学習はデータ指紋の変化を見て1時間ごとにバッチ再学習し、検証結果が既存モデルより悪くない場合だけ昇格させる。
- 個人適応は本番の逐次更新ではなく、prequential（予測→受信済み回答だけで更新）プロトコルで評価する。
