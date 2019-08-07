namespace Measurements
{
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Characterization;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;

    operation AllProblems () : Unit {
        BasicMeasurements();
        // PlusMinusMeasurements();
        // ABMeasurements();
        // BasicTwoQubitsStateMeasurements();
        // TwoQubitSStateMeasurements();
        // ParityMeasurements();
        // GHZorWStateMeasurements();
    }

    // Problem1
    //|0>か|1>の状態のQubitを判定する
    operation BasicMeasurements(): Unit {
        Message("=== |0> or |1> ===");
        using (q0 = Qubit()){
            DumpRegister((), [q0]);
            
            let res = IsZero(q0);
            Message($"q0は{res ? "|0>" | "|1>"}");

            DumpRegister((), [q0]);
            Reset(q0);
        }
        using (q1 = Qubit()){
            X(q1);
            DumpRegister((), [q1]);
            
            let res = IsZero(q1);
            Message($"q1は{res ? "|0>" | "|1>"}");

            DumpRegister((), [q1]);
            Reset(q1);
        }
    }

    //TODO qが|0>ならtrue,|1>ならfalseを標準出力に出してください
    operation IsZero(q: Qubit) : Bool {
        return false;
    }

    // Problem2
    // |+>か|->を判定する
    // |+⟩ = (|0⟩ + |1⟩) / sqrt(2)
    // |-⟩ = (|0⟩ - |1⟩) / sqrt(2)
    operation PlusMinusMeasurements(): Unit {
        Message("=== |+> or |-> ===");
        using (q0 = Qubit()){
            H(q0);
            DumpRegister((), [q0]);
            
            let res = IsPlus(q0);
            Message($"q0は{res ? "|+>" | "|->"}");

            DumpRegister((), [q0]);
            Reset(q0);
        }
        using (q1 = Qubit()){
            X(q1);
            H(q1);
            DumpRegister((), [q1]);

            let res = IsPlus(q1);
            Message($"q1は{res ? "|+>" | "|->"}");

            DumpRegister((), [q1]);
            Reset(q1);
        }
    }

    //TODO |+>か|->のQubitが、|+>ならtrueを返す
    operation IsPlus(q: Qubit) : Bool {
        return false;
    }

    // Problem3
    // |A> か |B>か
    // |A⟩ =   cos(alpha) * |0⟩ + sin(alpha) * |1⟩,
    // |B⟩ = - sin(alpha) * |0⟩ + cos(alpha) * |1⟩.
    operation ABMeasurements(): Unit {
        let alpha = RandomReal(5) * PI();
        Message($"=== |A> or |B> with alpha = {alpha} ===");
        using (q0 = Qubit()){
            Ry(2.0 * alpha, q0);
            DumpRegister((), [q0]);
            
            let res = IsA(q0, alpha);
            Message($"q0は{res ? "|A>" | "|B>"}");

            DumpRegister((), [q0]);
            Reset(q0);
        }
        using (q1 = Qubit()){
            X(q1);
            Ry(2.0 * alpha, q1);
            DumpRegister((), [q1]);

            let res = IsA(q1, alpha);
            Message($"q1は{res ? "|A>" | "|B>"}");

            DumpRegister((), [q1]);
            Reset(q1);
        }
    }

    //TODO |A>か|B>のQubitが、|A>ならtrueを返す
    operation IsA(q: Qubit, alpha: Double) : Bool {
        return false;
    }

    // Problem 4
    // 2量子状態の判定
    operation BasicTwoQubitsStateMeasurements() : Unit {
        Message("=== |00> or |01> or |10> or |11> ===");
        using (qs0 = Qubit[2]){
            DumpRegister((), qs0);
            
            let res = TwoQubitsState(qs0);
            Message($"qs0は{res}");

            DumpRegister((), qs0);
            ResetAll(qs0);
        }
        using (qs1 = Qubit[2]){
            X(qs1[1]);
            DumpRegister((), qs1);
            
            let res = TwoQubitsState(qs1);
            Message($"qs1は{res}");

            DumpRegister((), qs1);
            ResetAll(qs1);
        }
        using (qs2 = Qubit[2]){
            X(qs2[0]);
            DumpRegister((), qs2);
            
            let res = TwoQubitsState(qs2);
            Message($"qs2は{res}");

            DumpRegister((), qs2);
            ResetAll(qs2);
        }
        using (qs3 = Qubit[2]){
            X(qs3[0]);
            X(qs3[1]);
            DumpRegister((), qs3);
            
            let res = TwoQubitsState(qs3);
            Message($"qs3は{res}");

            DumpRegister((), qs3);
            ResetAll(qs3);
        }
    }

    // TODO 
    // 出力: 0 if qubits were in |00⟩ state,
    //         1 if they were in |01⟩ state,
    //         2 if they were in |10⟩ state,
    //         3 if they were in |11⟩ state.
    operation TwoQubitsState(qs: Qubit[]) : Int {
        return -1;
    }

    // Problem 5
    // 2量子S状態の判定
    //         |S0⟩ = (|00⟩ + |01⟩ + |10⟩ + |11⟩) / 2
    //         |S1⟩ = (|00⟩ - |01⟩ + |10⟩ - |11⟩) / 2
    //         |S2⟩ = (|00⟩ + |01⟩ - |10⟩ - |11⟩) / 2
    //         |S3⟩ = (|00⟩ - |01⟩ - |10⟩ + |11⟩) / 2
    operation TwoQubitSStateMeasurements() : Unit {
        Message("=== |S0> or |S1> or |S2> or |S3> ===");
        using (qs0 = Qubit[2]){
            H(qs0[0]);
            H(qs0[1]);
            DumpRegister((), qs0);
            
            let res = TwoQubitsSState(qs0);
            Message($"qs0は{res}");

            DumpRegister((), qs0);
            ResetAll(qs0);
        }
        using (qs1 = Qubit[2]){
            X(qs1[1]);
            H(qs1[0]);
            H(qs1[1]);
            DumpRegister((), qs1);
            
            let res = TwoQubitsSState(qs1);
            Message($"qs1は{res}");

            DumpRegister((), qs1);
            ResetAll(qs1);
        }
        using (qs2 = Qubit[2]){
            X(qs2[0]);
            H(qs2[0]);
            H(qs2[1]);
            DumpRegister((), qs2);
            
            let res = TwoQubitsSState(qs2);
            Message($"qs2は{res}");

            DumpRegister((), qs2);
            ResetAll(qs2);
        }
        using (qs3 = Qubit[2]){
            X(qs3[0]);
            X(qs3[1]);
            //ApplyToEachCA(X,qs3);
            H(qs3[0]);
            H(qs3[1]);
            //ApplyToEachCA(H,qs3);            
            DumpRegister((), qs3);
            
            let res = TwoQubitsSState(qs3);
            Message($"qs3は{res}");

            DumpRegister((), qs3);
            ResetAll(qs3);
        }
    }

    // TODO
    // 出力: 0 if qubits were in |S0⟩ state,
    //         1 if they were in |S1⟩ state,
    //         2 if they were in |S2⟩ state,
    //         3 if they were in |S3⟩ state.
    operation TwoQubitsSState(qs: Qubit[]) : Int {
        return -1;
    }

    // Problem 6
    // パリティ測定
    // ２量子ビットが以下の２つのどちらかであるか測定する
    // |00>と|11>の重ね合わせ
    // |01>と|10>の重ね合わせ
    operation ParityMeasurements(): Unit {
        Message("=== Parity測定 ===");
        using (qs0 = Qubit[2]){
            let alpha = RandomReal(5) * PI();
            let beta = RandomReal(5) * PI();
            // prep cos(alpha) * |0..0⟩ + sin(alpha) * |1..1⟩
            Ry(2.0 * alpha, qs0[0]);
            //Rx(2.0 * beta, qs[0]);
            CNOT(qs0[0], qs0[1]);
            DumpRegister((), qs0);

            let res = IsZeroZeroOneOne(qs0);
            Message($"|qs0>は{(res ? "|00>と|11>" | "|01>と|10>")}の重ね合わせ");

            DumpRegister((), qs0);
            ResetAll(qs0);
        }
        using (qs1 = Qubit[2]){
            let alpha = RandomReal(5) * PI();
            let beta = RandomReal(5) * PI();
            // prep cos(alpha) * |0..0⟩ + sin(alpha) * |1..1⟩
            Ry(2.0 * alpha, qs1[0]);
            //Rx(2.0 * beta, qs1[0]);
            CNOT(qs1[0], qs1[1]);
            X(qs1[0]);
            DumpRegister((), qs1);

            let res = IsZeroZeroOneOne(qs1);
            Message($"|qs1>は{(res ? "|00>と|11>" | "|01>と|10>")}の重ね合わせ");

            DumpRegister((), qs1);
            ResetAll(qs1);
        }
    }

    //TODO 1 測定後の状態は任意でよいので、
    //|00>と|11>の重ね合わせの場合はtrue、
    //|01>と|10>の重ね合わせの場合はfalseを返す。
    //TODO 2 TODO 1ができたら、測定後の状態を変化させないようにする。
    operation IsZeroZeroOneOne(qs: Qubit[]) : Bool {
         return false;
    }

    // Problem 7
    // パリティ測定2
    // 偶数個の量子ビットがGHZ状態かW状態のどちらかか判定する
    // Input: N >= 2 qubits (stored in an array) which are guaranteed to be
    //        either in GHZ state (https://en.wikipedia.org/wiki/Greenberger%E2%80%93Horne%E2%80%93Zeilinger_state)
    //        or in W state (https://en.wikipedia.org/wiki/W_state).
    // Output: 0 if qubits were in GHZ state,
    //         1 if they were in W state.
    operation GHZorWStateMeasurements() : Unit {
        for (i in 1 .. 1) {
            Message($"=== GHZ or W状態 ({2*i} Qubits)===");
            using (qs0 = Qubit[2*i]){
                let alpha = RandomReal(5) * PI();
                Ry(2.0 * alpha, qs0[0]);
                ApplyToEachCA(CNOT(qs0[0], _), qs0[1 .. Length(qs0) - 1]);
                DumpRegister((), qs0);

                let res = IsGHZState(qs0);
                Message($"qs0は{(res ? "GHZ状態" | "W状態")}");
                DumpRegister((), qs0);

                ResetAll(qs0);
            }
            using (qs1 = Qubit[2*i]){
                StatePrep_WState_Arbitrary(qs1);
                DumpRegister((), qs1);

                let res = IsGHZState(qs1);
                Message($"qs1は{(res ? "GHZ状態" | "W状態")}");
                DumpRegister((), qs1);

                ResetAll(qs1);
            }
        }
    }

    operation StatePrep_WState_Arbitrary (qs : Qubit[]) : Unit
    is Adj + Ctl {
        
        let N = Length(qs);
            
        if (N == 1) {
            // base case of recursion: |1⟩
            X(qs[0]);
        }
        else {
            // |W_N> = |0⟩|W_(N-1)> + |1⟩|0...0⟩
            // do a rotation on the first qubit to split it into |0⟩ and |1⟩ with proper weights
            // |0⟩ -> sqrt((N-1)/N) |0⟩ + 1/sqrt(N) |1⟩
            let theta = ArcSin(1.0 / Sqrt(IntAsDouble(N)));
            Ry(2.0 * theta, qs[0]);
                
            // do a zero-controlled W-state generation for qubits 1..N-1
            X(qs[0]);
            Controlled StatePrep_WState_Arbitrary(qs[0 .. 0], qs[1 .. N - 1]);
            X(qs[0]);
        }
    }
    
    // TODO 1 測定後の状態は問わない
    // TODO 2 測定後の状態は測定前と一致していないといけない
    // GHZ状態ならtrue、W状態ならfalseを返す
    operation IsGHZState(qs: Qubit[]) : Bool {
        return false;
    }

}
