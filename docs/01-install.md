# 01. インストールと起動

WSL2 (Ubuntu) に conda (Miniforge) を使って PyMOL (オープンソース版) をインストールし、起動するまでの手順です。

## 前提環境

| 項目 | 想定 |
| --- | --- |
| OS | Windows 11 + WSL2 |
| ディストリビューション | Ubuntu 22.04 |
| GUI 表示 | WSLg (Windows 11 の WSL に標準で入っている) |

WSLg が有効なら、Linux の GUI アプリのウィンドウが Windows のデスクトップにそのまま表示されます。X サーバー (VcXsrv など) を別に入れる必要はありません。

WSL のバージョンが古い場合は、Windows 側の PowerShell で更新しておきます。

```powershell
wsl --update
wsl --shutdown   # 再起動して反映
```

## インストール

### 1. Miniforge をインストール (未導入の場合のみ)

`conda --version` が通るなら、このステップは飛ばしてください。

```bash
cd ~
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

途中の質問はすべて `yes` で問題ありません。終わったらシェルを開き直し (または `source ~/.bashrc`)、確認します。

```bash
conda --version
mamba --version
```

### 2. PyMOL 用の環境を作成

conda-forge の `pymol-open-source` を、`pymol` という名前の環境にインストールします。

```bash
mamba create -n pymol -c conda-forge pymol-open-source
```

> `mamba` が無い場合は `conda create ...` でも同じです (少し遅いだけです)。

GUI に必要な PyQt5 も依存関係として一緒に入ります。

### 3. 確認

```bash
conda activate pymol
pymol --version
```

次のように表示されれば成功です (バージョンは時期によって変わります)。

```
PyMOL 3.1.0 Open-Source (...)
```

### 4. alias を登録する (推奨)

`pymol` コマンドを使うたびに `conda activate pymol` するのは手間なので、`~/.bashrc` に alias を登録しておきます。

```bash
echo "alias pymol='~/miniforge3/envs/pymol/bin/pymol'" >> ~/.bashrc
source ~/.bashrc
```

これで、どの conda 環境が有効になっていても `pymol` だけで起動できます。

```bash
type pymol
# pymol is aliased to `~/miniforge3/envs/pymol/bin/pymol'
```

> Miniforge を `~/miniforge3` 以外に入れた場合は、`conda env list` で `pymol` 環境の場所を確認し、パスを読み替えてください。

> alias が効くのは `pymol` コマンドだけです。Python スクリプトから `from pymol import cmd` で使う場合は、これまでどおり `conda activate pymol` してから `python` を実行します (後述)。

---

## 起動方法

### GUI で起動する

```bash
pymol
```

WSLg 経由で PyMOL のウィンドウが開きます。ファイルを指定して開くこともできます。

```bash
pymol protein.pdb
pymol session.pse
```

### GUI なし (バッチモード) で起動する

画像の一括出力など、ウィンドウを出さずに処理したいときに使います。

```bash
# PyMOL コマンドを直接実行する
pymol -cq -d 'fetch 1crn; print(cmd.count_atoms("all"))'

# スクリプトファイル (.pml または .py) を実行する
pymol -cq script.pml
pymol -cq script.py
```

| オプション | 意味 |
| --- | --- |
| `-c` | GUI を出さないコマンドラインモード (処理が終わると終了する) |
| `-q` | 起動時のメッセージを表示しない |
| `-d 'cmd'` | 起動後に PyMOL コマンドを実行する |
| `-k` | `~/.pymolrc` やプラグインを読み込まない |
| `-K` | `-c` のとき、処理後も終了せずにプロンプトを残す |

その他のオプションは `pymol --help` で確認できます。

### Python から使う

PyMOL は Python モジュールとしても使えます。

```python
# example.py
from pymol import cmd

cmd.fetch("1crn")
cmd.show_as("cartoon")
cmd.png("1crn.png", width=800, height=600, dpi=150, ray=1)
```

```bash
conda activate pymol
python example.py
```

---

## 動作確認

インストールできたら、次のコマンドで最低限の動作を確認します。

```bash
pymol -cq -d 'fetch 1crn; print("atoms:", cmd.count_atoms("all")); png test.png, width=400, height=300, ray=1'
```

- `atoms: 327` と表示される → PDB からのダウンロード (`fetch`) と読み込みは OK
- `test.png` ができる → 描画 (レイトレース) は OK

最後に `pymol` だけで起動し、ウィンドウが開けば GUI も問題ありません。

> `fetch` を実行するとカレントディレクトリに `1crn.cif` などが保存されます。保存先は `set fetch_path, /path/to/dir` で変えられます。

---

## トラブルシューティング

### `pymol: command not found`

- alias を登録した直後なら、`source ~/.bashrc` を実行するかターミナルを開き直します。
- alias を登録していない場合は、`conda activate pymol` を忘れていないか確認します。

### `ModuleNotFoundError: No module named 'pymol'`

Python スクリプトを `pymol` 環境以外の `python` で実行しています。`conda activate pymol` してから実行してください。

```bash
which python
# ~/miniforge3/envs/pymol/bin/python になっていれば OK
```

### ウィンドウが表示されない / `could not connect to display`

WSLg が動いていない可能性があります。

```bash
echo $DISPLAY          # :0 などが表示されるか
ls /mnt/wslg           # ディレクトリが存在するか
```

何も出ない場合は、Windows 側で `wsl --update` と `wsl --shutdown` を実行してから WSL を開き直してください。

### OpenGL 関連のエラーで起動しない・画面が真っ黒

GPU ドライバとの相性の問題であることが多いです。ソフトウェアレンダリングに切り替えると回避できます。

```bash
LIBGL_ALWAYS_SOFTWARE=1 pymol
```

### ウィンドウ内の文字が小さい / 大きい

高解像度ディスプレイでは Qt の拡大率を指定します。

```bash
QT_SCALE_FACTOR=1.5 pymol
```
