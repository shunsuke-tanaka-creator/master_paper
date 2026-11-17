# 参考文献19件の書誌照合

対象: `master_paper@4d4be49ede531bd621d1fa13013ccef5268968fc/references.bib`。確認日: 2026-11-17。

## 結論

確定した書誌誤りは1件。`tudorlocke2019cadence` の第3著者 **Han, Hailey** は **Han, Ho** が正しい。公式掲載の著者名は **Ho Han** である。原稿・参考文献は変更していない。

他18件について、確認できた著者・タイトル・年・DOIの範囲では重大な不一致を発見しなかった。ただし、Huber原論文の公式メタデータ/本文はProject Euclidの追加セキュリティにより取得できず、一次資料による完全確認は未完了。各論文全文を精読した検証ではなく、公式書誌情報と取得可能な抄録、必要な箇所の確認である。

## 確定修正

`references.bib` の `tudorlocke2019cadence`:

```bibtex
% 原文
author = {Tudor-Locke, Catrine and Aguiar, Elroy J. and Han, Hailey and others},

% 修正案
author = {Tudor-Locke, Catrine and Aguiar, Elroy J. and Han, Ho and others},
```

根拠: [Springer/BMC公式掲載](https://link.springer.com/article/10.1186/s12966-019-0769-6)。著者一覧の第3著者がHo Han、出版年2019、DOI `10.1186/s12966-019-0769-6`。この著者名修正はP3（書誌の事実誤り）として扱える。

## 個別確認表

「一致」は取得したメタデータとの一致を意味し、本文の全主張に対する引用適合性を保証するものではない。`and others`で省略された著者を、書誌スタイルを無視して誤り扱いしていない。

| 引用キー | 確認結果 | 一次資料/公式ページと確認範囲 |
|---|---|---|
| hochreiter1997lstm | 著者2名、タイトル、1997年、DOI一致 | [著者所属機関の原論文PDF](https://people.idsia.ch/~juergen/lstm1997-2024head.pdf)、[出版社DOI](https://doi.org/10.1162/neco.1997.9.8.1735)。公式検索結果でDOI/Neural Computation 9(8),1735–1780を確認。DOIページ直接openは403だった |
| gers2000forget | 著者3名、タイトル、2000年、DOI一致 | [出版社DOI](https://doi.org/10.1162/089976600300015015)、[IDSIA原論文](https://sferics.idsia.ch/pub/juergen/FgGates-NC.pdf)。forget gate導入の抄録も確認 |
| williams1990tbptt | 著者2名、タイトル、1990年、DOI一致 | [著者大学の論文一覧](https://www.khoury.northeastern.edu/home/rjw/pubs.html)、[MIT Press/IEEEメタデータ](https://ieeexplore.ieee.org/abstract/document/6797135/)。公式検索で著者、Neural Computation 2(4),490–501、DOI確認。大学サイト直接openは403 |
| fritzke1995gng | 著者、タイトル、NIPS7一致。1995を誤りとしない | [NeurIPS公式](https://papers.nips.cc/paper/1994/hash/d56b9fc4b0f1be8871f5e1c40c0067e7-Abstract.html)。会議年1994と論文集出版年1995の区別をBibTeX冒頭に既記載。rootでも確認済み |
| gurrin2014lifelogging | 著者3名、タイトル、2014年、DOI一致 | [DCU著者機関リポジトリ](https://doras.dcu.ie/19998/)、[出版社提供抜粋](https://www.nowpublishers.com/article/DownloadSummary/INR-033)。LifeLoggingの大文字小文字は実質的誤りに数えない |
| reimers2019sentencebert | 著者2名、タイトル、2019年、DOI一致 | [ACL公式](https://aclanthology.org/D19-1410/)。Nils Reimers/Iryna Gurevych、DOI `10.18653/v1/D19-1410`、EMNLP-IJCNLP確認 |
| wang2020minilm | 著者6名の順序、タイトル、2020年、NeurIPS33一致 | [NeurIPS公式](https://papers.nips.cc/paper_files/paper/2020/hash/3f5ee243547dee91fbd053c1c4a845aa-Abstract.html)。DOIは原稿に記載なく、未割当を断定していない |
| chen2020simclr | 著者4名、タイトル、2020年、ICML37/PMLR一致 | [PMLR公式](https://proceedings.mlr.press/v119/chen20j)。PMLR119:1597–1607。DOI未記載を誤り扱いしない |
| he2022mae | 著者6名の順序、タイトル、2022年、CVPR一致 | [CVF公式](https://openaccess.thecvf.com/content/CVPR2022/html/He_Masked_Autoencoders_Are_Scalable_Vision_Learners_CVPR_2022_paper.html)。公式BibTeXも確認。DOIは未調査 |
| devlin2019bert | 著者4名、タイトル、2019年、DOI一致 | [ACL公式](https://aclanthology.org/N19-1423/)。DOI `10.18653/v1/N19-1423`。正式巻はVolume1(Long and Short Papers)だが、巻号省略方針なので欠落を重大誤りに数えない |
| gelman2007multilevel | 著者2名、書名、出版社、2007年、DOI一致 | [Cambridge公式](https://www.cambridge.org/highereducation/books/data-analysis-using-regression-and-multilevel-hierarchical-models/32A29531C7FD730C3A68951A17C9D983?chapterId=CBO9780511790942A005)、[公式frontmatter](https://assets.cambridge.org/97805218/67061/frontmatter/9780521867061_frontmatter.pdf)。商品ページの発売日2006年12月と本文書誌2007は区別。frontmatterのFirst published2007を確認したため2007は妥当 |
| huber1964robust | 二次書誌では著者/タイトル/1964/DOI一致。一次資料確認は未完了 | [原論文DOI](https://doi.org/10.1214/aoms/1177703732)はProject Euclidへ到達するが追加セキュリティ画面で停止。[NII書誌](https://cir.nii.ac.jp/crid/1361699995665709184)ではPeter J.Huber、Ann.Math.Statist.35(1):73–101、DOI一致。公式本文を読んだとは扱わない |
| loshchilov2019adamw | 著者2名、タイトル、ICLR2019一致 | [OpenReview公式原論文](https://openreview.net/pdf?id=Bkg6RiCqY7)。初投稿2017と採択会議2019を混同せず、2019を誤りとしない |
| ainsworth2011compendium | 記載先頭3著者、タイトル、2011年一致。DOIは公式サイトが案内するPubMed書誌で一致 | [研究チーム公式サイト](https://pacompendium.com/)のPast Compendium Citations、[同サイト案内のPubMed](https://pubmed.ncbi.nlm.nih.gov/21681120/)。出版社DOI直接openは402。個々の活動コードと全MET値の照合は未実施 |
| tudorlocke2011steps | 記載先頭3著者、タイトル、2011年、DOI一致 | [BMC公式PDF](https://ijbnpa.biomedcentral.com/counter/pdf/10.1186/1479-5868-8-79.pdf)。成人歩数レビューの主旨も抄録から確認 |
| tudorlocke2019cadence | **第3著者誤り**。タイトル、年、DOIは一致 | [Springer/BMC公式](https://link.springer.com/article/10.1186/s12966-019-0769-6)。正しくはHo Han。21–40歳における100steps/minのheuristicであることを抄録で確認 |
| stone1994momentary | 著者2名、タイトル、誌名、1994年一致 | [Oxford/SBM公式](https://academic.oup.com/abm/article-abstract/16/3/199/4648561)。原稿未記載DOI `10.1093/abm/16.3.199` が確認でき、追加を推奨できる。欠落だけで誤りとはしない |
| shiffman2008ema | 著者3名、タイトル、2008年、DOI一致 | [Annual Reviews公式](https://www.annualreviews.org/content/journals/10.1146/annurev.clinpsy.3.022806.091415)。自然環境での反復的・現時点の報告という抄録説明を確認 |
| eisele2022burden | 著者7名の順序、タイトル、DOI一致。2022巻年は妥当 | [SAGE公式](https://journals.sagepub.com/doi/10.1177/1073191120957102)。2020オンライン先行/Assessment29(2)2022の区別は本査読で確認。抄録は30/60項目×日3/6/9回の学生研究である |

## 本文の引用適合性について確認できた点

1. **原LSTMと忘却ゲートを分けた引用は適切。** 2.4.1はHochreiter1997だけで現代の忘却ゲートまで原提案としないよう、Gers2000を追加しており、公式抄録と整合する。
2. **GNGを関連手法として参照し、GrowingMapの性質へ直接流用しない留保は適切。** 本実装は誤差累積・第2勝者・辺の老化を持たないと本文が明記する。
3. **BERT/MAE/SimCLRをSSLの設計例として区別している点は適切。** 既存研究の画像分類等の達成性能が、そのまま生活状態推定を保証するという記述は確認しなかった。ただし具体的な時系列SSL設計の採用理由・比較結果は別途必要。
4. **Sentence-BERT/MiniLM論文の引用だけでは、実際に使用した384次元モデルの同定にはならない。** ローカルモデル名、revision、ファイルハッシュ、基本経路とSSL経路の選択を実験記録に示す必要がある。[総合査読R07](2026-11-17-comprehensive-review.md)参照。
5. **CADENCEの100歩/分を共通換算の仮定とした留保は妥当。** 元論文は21–40歳の実験条件でheuristic閾値を検討しており、個人固有の速度やすべての対象集団での保証ではない。2.1.1/4.8はこの点を既に限定している。
6. **Compendiumの一般引用は個々のMET割当てを追跡するには不足。** 4.8.3の歩行3.0、速歩4.3等はコード表と一致するが、活動コード、速度・条件、採用版との一対一対応は原典確認が必要。本調査は全活動表を照合しておらず、数値が誤りとは断定しない。2024版も存在するが、2011版を明示採用すること自体は誤りではない。
7. **Eisele研究から現システムの日4件が最適とは推論できない。** 本文は頻度・長さ・負担を考察する方法研究として使っており、現時点でそのような過度の主張は見つからなかった。
8. **Huberと部分プーリングの厳密な式は原典の一般論だけでなく、損失実装を根拠に評価する必要がある。** Huber(beta=1)のコード対応と、Gaussian priorと欠測件数による収縮の関係は[数式別紙2.9・3](2026-11-17-equations.md)を参照。
