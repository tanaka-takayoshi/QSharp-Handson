## Q# ハンズオン 第１回 (再)

### はじめに

今回は第1回と同じ内容ですが、特に問題0に集中して行います。問題0ができて時間のある方は[前回](/01)のページから問題1,2やQunatumKatasに取り組んでみてください。

問題の解答は [Problem0](https://github.com/tanaka-takayoshi/QSharp-Handson/tree/master/01/Problem0) にあります。
フィードバックは[GitHubのissue](https://github.com/tanaka-takayoshi/QSharp-Handson/issues)にお願いします。

### 参考資料

- [本家ドキュメント](https://docs.microsoft.com/en-us/quantum/techniques/?view=qsharp-preview)
- [日本語でまとめた資料 - Q#基礎 ver1.1](https://www.slideshare.net/tanakata/q-ver11)

### 問題0 Bell state

参照: [Quickstart - your first quantum program](https://docs.microsoft.com/ja-jp/quantum/quickstart?view=qsharp-preview&tabs=tabid-vscode)


次のようにBell状態を使った測定を行うQ#プロジェクトを作成してください。

- C#コードからQ#には試行回数(Int)と初期状態(Result)を渡す。
- 試行回数だけ次の操作を行う。
  - 2量子ビット用意し、最初の1つはC#から渡された初期状態にセットする。もう1つは0にセットする。
  - 2つの量子ビットをエンタングル状態にする
  - 量子ビットを測定し、最初の1つの量子ビットが1かどうかと、最初のビットと２番目のビットの測定結果が同じかどうかを判定する
- Q#コードからC#コードには、最初の量子ビットが0だった回数(Int)、最初の量子ビットが1だった回数(Int)、最初の量子ビットと２番目の量子ビットが同じだった回数(Int)の3つの値を返す。
- C#コードから、試行回数はどちらも1000で、初期状態が0のものと1のものを指定して2回Q#コードを実行する。それぞれで、最初の量子ビットが0だった回数、1だった回数、2つの量子ビットの測定結果が同じだった回数を表示する。
  
  出力例

  ```txt
  初期状態:Zero |0>=478  |1>=522  同一=1000
  初期状態:One  |0>=511  |1>=489  同一=1000
  ```

#### 解き方

解き方がわからない人向けに以下の手順で前で説明していきます。この説明を聞きながら手順をすすめて行きましょう。また、この問題は参照リンク先の``Quickstart - your first quantum program``で作成しているプロジェクトと同じです。

- Q#プロジェクトの作成と実行
- Q#のコードに、C#から呼び出す空のoperationを追加
- C#のDriverクラスの編集
- Q#のコードの実装

### 問題1 量子テレポーテーション

[Microsoftのブログ](https://blogs.msdn.microsoft.com/uk_faculty_connection/2018/02/27/quantum-teleportation-in-q)を参考に量子テレポーテーションをQ#プロジェクトとして実装してください。

#### 実装するプロジェクトの詳細

- C#コードからは1bitのmessage(Bool)を送信する。量子テレポーテーションした結果のメッセージをBoolとして取得。
- falseを送信すればfalseが,trueを送信すればtrueがかえってくるのが条件。
- Q#側で受信したメッセージをそのまま返せば条件を満たせますが、ちゃんとQubitを使ってテレポーテーションしましょう。

#### ヒント

C#から呼ぶQ#のオペレーションは次のような定義になります。このオペレーションの中で送信用のQubitと受信用のQubitそれぞれ１個ずつを生成してみましょう。

```qs
operation TeleportClassicalMessage(message : Bool) : Bool 
```

さらにそれぞれのQubit間でテレポーテーションするOperationとして次のOperationを定義してみましょう。このOperationの中では、エンタングルするためにさらに1個のQubitが必要になります。

```qs
operation Teleport(msg : Qubit, there : Qubit) : Unit
```

### 問題2 Q# Conding Contestの問題C2の回答を検証する

#### 問題の詳細

Q# Conding Contestの[問題C2](https://codeforces.com/contest/1002/problem/C2)を実際に実行して確認するプロジェクトをつくってみよう。

問題C2であるSolveメソッドは次のフォーマットをしています、

```
operation Solve (q : Qubit) : Int
```

`q`に`|0>`または`|+>`状態の量子ビットを渡すたとき、`|0>`であれば0を返し、`|+>`であれば1を返し、検知不能の場合は-1を返します。さらに10000回実行したときに次の条件も満たしています。

- 誤って0または1を返すことはありません(`|0>`のときに1を返したり、`|1>`のときに0を返すことはない)
- -1を返すのは多くとも80%まで。
- 少なくとも10%の確率で`|0>`を正しく判定する
- 少なくとも10%の確率で`|+>`を正しく判定する

そこでこの問題ではこのSolveメソッドの解答が正しく動作しているか検証するプロジェクトを作成します。
C#からはSolveメソッドを実行する回数（偶数）を渡します。
Q#のコードでは、指定された回数のうち半分は`|0>`を生成してSolveメソッドを実行します。
残り半分は`|1>`を生成してSolveメソッドを実行します。Solveメソッドの結果を集計して次の4つの値をC#に返します。C#コードはこの結果を表示します。

- `|0>`が`|0>`と正しく判定された回数
- `|0>`が不定と判定された回数
- `|1>`が`|1>`と正しく判定された回数
- `|1>`が不定と判定された回数

Solveメソッドの実装はこのページの一番下にあります。自分で解いてみたい方はそのまま解いてみるか、下のヒントを参考にしてみてください。


#### C2を解く場合のヒント

両方確実に検出することは不可能なので、`|0>`だった場合に`|0>`を確実に検出しそれ以外の場合は-1を返すパターンと、`|+>`だった場合に`|+>`を確実に検出しそれ以外の場合に-1を返すパターンの２パターンを用意し、それぞれ50%の確率的に実行することにします。
とんち的な問題ですが、これにより目的を達成できます。
`|0>`であることは、M(q)による測定結果が1であることで検出できます。
`|+>`であることは、Hadamard変換した後にM(q)による測定結果が1であることで検出できます。

### Q# 全般のヒント (適宜追加予定)

- usingで生成したQubitはusingを抜ける際に0にリセットしないといけません。

### 発展(時間が余ったら)

[QuantumKatas](https://github.com/Microsoft/QuantumKatas)をやってみましょう。
（今日の最後に簡単に紹介する予定です）


### 問題2で出てくるCoding Contest C2の解答

```qs
operation Solve (q : Qubit) : Int 
{
    mutable output = 0;
    let basis = RandomInt(2);
    
    if (basis == 0) 
    {
        //三項演算子を使うとこう書ける
        set output = M(q) == One ? 1 | -1;

        //三項演算子を書き下すならこんな感じ
        // let result = M(q);
        // if (result == One) 
        // {
        //     set output = 1;
        // }
        // else 
        // {
        //     set output = -1;
        // }
    }
    else 
    {
        H(q);
        set output = M(q) == One ? 0 | -1;
        // let result = M(q);
        // if (result == One)
        // {
        //     set output = 0;
        // }
        // else 
        // {
        //     set output = -1;
        // }
    }
    
    return output;
}
```