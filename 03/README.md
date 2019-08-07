## Q# ハンズオン 第3回

### 課題

[./Measurements]以下がQ# プロジェクトになっているので、Visual StudioやVisual Studio Codeなどで開き、実行できることを確認してください。

[./Measurements/Operations.qs]に課題があります。最初の`AllProblems`ですべての問題をまとめて実行できますが、一度に実行すると標準出力に大量に出力されるので、適宜コメントアウトしてください。

```
    operation AllProblems () : Unit {
        BasicMeasurements();
        // PlusMinusMeasurements();
        // ABMeasurements();
        // BasicTwoQubitsStateMeasurements();
        // TwoQubitSStateMeasurements();
        // ParityMeasurements();
        // GHZorWStateMeasurements();
    }
```

それぞれのoperationに課題が記述してあり、`TODO`と書いてるoperationを課題のとおり実装してください。

### 説明資料

<iframe src="//www.slideshare.net/slideshow/embed_code/key/1VgfwbInj7k1ze" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/tanakata/20190806-q-measurements" title="20190806 Q# Measurements" target="_blank">20190806 Q# Measurements</a> </strong> from <strong><a href="https://www.slideshare.net/tanakata" target="_blank">Takayoshi Tanaka</a></strong> </div>