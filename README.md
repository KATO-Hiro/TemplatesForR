# TemplatesForR

R言語で計算・描画するためのテンプレート

## スクリプトを実行することで得られるアウトプット

Note: 図の追加・削除に応じて更新してください．

- 図: TODO: Write here!
  TODO: Write here! (src\output\hoge)

## ファイル・ディレクトリ構成

```terminal
src
  main.r: 主要な計算や作図を行うスクリプトです．

  - docs: 元データに関する説明や注意事項などをまとめたフォルダです．

  - input: 入力データに関するファイルをまとめたフォルダです．

  - output: 計算結果や図をまとめたフォルダです．

  - preparation: 前処理を行うためのスクリプトです．

  - pilot_study: 予備検討を行うためのスクリプトです．

  - lib: 汎用的な処理をまとめたスクリプトです．

  - common: 本プロジェクト固有の共通処理をまとめたスクリプトです．

  - scripts: コマンドの処理を実行するためのスクリプトです．
    - pull.cmd: GitおよびGit Hubでソースコードを管理しており，該当するソフトウェアを利用する際にタイプ量を減らすことができます．

  - log: 計算の途中経過を出力したファイルがあるフォルダです．プログラムの不具合の特定に役立ちます．

  - backup: バックアップを取るためのフォルダです．

  - tmp: ファイルやフォルダを一時的に退避させるためのフォルダです．

  - trashbox: 使わない可能性が高いものの，削除するかどうか迷っているファイル・フォルダを置きます．
```

## 使い方

1. 作業ディレクトリに移動します．

注: ディレクトリのパスをエクスプローラーからコピーした場合は，「\」を「\\」に変更してください．

```terminal
setwd("C:\\Users\\yourname\\(your PATH)\\")

ex:
setwd("C:\\Users\\KATO-Hiro\\Documents\\work\\")
```

2. (初回のみ)Rで使用するパッケージをインストールします．

```terminal
source("installer.r")
```

3. 以下のコマンドを実行して，計算や図の描画を行います．

- RStudioで実行するコマンド

```terminal
# 予備検討(少ないデータで試行錯誤するためのスクリプト)を行います．
source("src\\pilot_study\\main.r")

# 計算・図の描画を行います．
source("src\\main.r")
```

## スクリプトの改変および拡張される方に向けた情報

オプションで項目を切り替えたり，パターンを増やしたりすることができます．

### 前処理

注: 分析の前提条件を大幅に見直した場合やデータが消失した場合などを除いて，以下のスクリプトを実行することはほぼないと思います．

#### TODO: Write here!

- TODO: Write here!(src\preparation\foo.r)
  - 入力ファイル:
    - TODO: Write here!: src\input\hoge.csv
  - 出力先: src\output\fuga.csv

  ```md
  fuga.csv

  TODO: Write here!
  ```

### 入力ファイルのフォーマット

- TODO: write here!
  - src/input/hoge.csv

```md
TODO: write here!
```

- TODO: write here!
  - src/input/hoge.csv

```md
TODO: write here!
```

### 出力ファイルのフォーマット

- TODO: write here!
  - src/output/foo.csv

```md
```

- TODO: write here!
  - src/output/foo.csv

```md
```
