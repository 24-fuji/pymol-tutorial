# チュートリアル作成ロードマップ

## ゴール

参考論文 `pymol-tutorial.pdf` (Kjaergaard et al., *The Biophysicist* 2022, "Teaching Computational Skills via Molecular Graphics in PyMOL") の **Fig 3A にある 8 枚の図 (Q1〜Q8)** を、学習者が自分で PyMOL スクリプトを書いて作れるようになること。

| 問題 | 内容 | 区分 |
| --- | --- | --- |
| Q1 | 全体構造 (Overall structure) | 表示 |
| Q2 | イオンを表示する (Show ions) | 表示 |
| Q3 | 特定の残基を表示する (Show residues) | 表示 |
| Q4 | 原子間の距離を測る (Measure distance) | 解析 |
| Q5 | イオンの周り 6 Å 以内の残基を選ぶ (Select neighbors) | 解析 |
| Q6 | 2 つの構造を重ね合わせる (Align) | 解析 |
| Q7 | B-factor を色で表す (Map B-factor) | マッピング |
| Q8 | 静電ポテンシャルを表面に表示する (Electrostatics) | マッピング |

論文の試験と同じく、「構造を読み込み、8 個の空のシーンを作るテンプレートスクリプト」を出発点にし、8 個のシーンを完成させる形式を最終課題にする。

## 題材

論文と同じアミノ酸輸送体 **LeuT** を使う。PyMOL 3.1 (conda 版) で動作確認済み。

| PDB ID | 内容 | 用途 |
| --- | --- | --- |
| 2A65 | LeuT、基質のロイシンと Na⁺ イオン 2 個が結合 | Q1〜Q5、Q7、Q8 |
| 2QJU | LeuT、抗うつ薬デシプラミンが結合 (論文の参考文献 23) | Q6 の重ね合わせの相手 |
| 4M48 | ショウジョウバエのドーパミン輸送体 | 06 章の練習 (配列の似ていない構造の重ね合わせ) |
| 4HHB | ヘモグロビン | 03 章、07 章の練習 |

確認したこと:

- どちらも 1 本鎖 (A 鎖) で、Na⁺ (`resn NA`) が 2 個ずつある
- `align 2qju, 2a65` で RMSD 0.56 Å
- 2A65 で Na⁺ の 6 Å 以内にある残基の選択ができる
- 真空中の静電ポテンシャル (`util.protein_vacuum_esp`) がオープンソース版でも使える

## 論文の学習の流れとの対応

論文 Fig 1 では、19 のトピックを通じて機能を少しずつ導入している。そのうち Fig 3A に必要な部分を抜き出し、次の順に並べる。

| 論文 Fig 1 のトピック | 導入される機能 | このチュートリアル |
| --- | --- | --- |
| 1. Intro to PyMOL | GUI の Action/Show/Hide/Label/Color、`fetch` | 02 (済) |
| 2. Scripting | `reinitialize`、`select`、`and/or/not`、`show/hide/as`、`color`、`bg_color`、`get_view/set_view`、`util.cbc` など、プロパティでの選択、Scene | 04 |
| 3. Protein structure | `byres`、`within`、`distance` | 05 |
| 7. Evolution | `align`、`super` | 06 |
| 4. Protein structure / 14. Dynamics | `surface`、`spectrum`、B-factor での選択 | 07 |
| 12. Post-translational modifications | 静電ポテンシャル (GUI) | 07 |

## タスク一覧

### 済み

- [x] **01. インストールと起動** (`docs/01-install.md`)
- [x] **02. 基本操作 (GUI)** (`docs/02-basic-operations.md`)
- [x] **03. 演習: 図を作ってみる** (`docs/03-exercise.md`): 4hhb を使った GUI だけの演習
- [x] **04. コマンドとスクリプトの基本** (`docs/04-commands-and-scripts.md`) → Q1〜Q3
- [x] **05. 選択の応用と距離の測定** (`docs/05-selection-and-distance.md`) → Q4、Q5
- [x] **06. 構造の重ね合わせ** (`docs/06-structural-alignment.md`) → Q6
- [x] **07. 情報を色で表す** (`docs/07-color-mapping.md`) → Q7、Q8
- [x] **08. 最終課題: Fig 3A を再現する** (`docs/08-final-exercise.md`、`templates/fig3a_template.pml`)

### 実践編 (08 章の後)

[PyMOL Wiki - Practical Pymol for Beginners](https://wiki.pymol.org/index.php/Practical_Pymol_for_Beginners) を参考に、Fig 3A の再現に続いて、実際の研究・発表で使う技術をまとめた。

- [x] **09. 論文・スライド用の図を作る** (`docs/09-publication-images.md`): 画像の大きさと dpi、背景の透明化、`ray_trace_mode`、見た目の設定、プリセット、ラベル。演習は 1hsg
- [x] **10. Python で自動化する** (`docs/10-python-automation.md`): `cmd` API、`iterate`、CSV 出力、複数構造の一括処理、`save` / `extract`、`log_open`。演習は LeuT 3 構造の Na⁺ 配位残基の表
- [x] **11. 動画を作る** (`docs/11-movies.md`): `mset`、`movie.roll` / `rock`、シーン間の動画、`movie.produce`、`mpng` + ffmpeg (MP4 / GIF)。演習は 2a65 の回転動画

### 各章の確認演習と最終課題の対応

各章の確認演習 (練習 Q1〜Q8) は、最終課題と同じ種類の図を **別の対象** で作るようにして、最終課題の答えにならないようにしている。

| 問題 | 章の練習 | 最終課題 (08) |
| --- | --- | --- |
| Q1 | 2a65、1〜260 番と 261〜519 番で色分け | 2a65、緑一色 |
| Q2 | 2a65 の Cl⁻ | 2a65 の Na⁺ 2 個 |
| Q3 | 基質ロイシンと TYR-108、PHE-253、SER-256 | ARG-30、TYR-108、ASP-404 (細胞外ゲート) |
| Q4 | ASN-179 ND2 – GLU-112 OE2 (2.95 Å) | GLN-250 NE2 – GLU-290 OE1 (2.92 Å) |
| Q5 | 基質から 4 Å 以内 (13 残基) | Na⁺ から 6 Å 以内 (25 残基) |
| Q6 | 4m48 (ドーパミン輸送体) を `super` で 2a65 に重ねる | 2qju を `align` で 2a65 に重ねる |
| Q7 | 4hhb、範囲 10〜40 | 2a65、範囲 20〜45 |
| Q8 | 4hhb (`remove` してから計算) | 2a65 (`create` でタンパク質だけのコピーを作って計算) |

### 作成中に分かった注意点

- PyMOL 3.x は mmCIF の「見えていない残基」を座標なし・B-factor 0 の原子として読み込む。`spectrum b` の自動範囲が 0 から始まるため、07 で注意書きと範囲指定を教えている
- `util.protein_vacuum_esp` は選択範囲ではなくオブジェクト名しか受け付けない。最終課題では `remove` を使うと Q2・Q5 の Na⁺ まで消えるため、`create` を 07 で教えている
- `ray_opaque_background` の初期値は -1 で、`pymol -c` で実行すると背景が透明になる。09 で注意している
- `mpng` は保存先のディレクトリが無いとエラーになる。`log_open` は `@` で実行したスクリプトの中身を記録しない
- `orient` の結果 (向きの裏表) は直前の視点に依存する。完成図の向きは目安であり、各演習で「向きは完全に同じでなくてよい」と明記している

### 残っていること

- [ ] 解答スクリプトの扱いを決める (現状はリポジトリに含めていない)
- [ ] (任意) 8 枚の PNG を 2 × 4 に並べて 1 枚の図にする方法
- [ ] GUI の手順 (メニュー名など) を実際のウィンドウで一通り確認する
