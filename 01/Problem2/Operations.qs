namespace Problem2
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation HelloQ () : Unit {
        Message("Hello quantum world!");
    }

    function Terms (total: Int) : (Int, Int)
    {
        return (total/2, total/2);
    }

    operation RunQsharp () : ((Int, Int), (Int, Int)) 
    {
        mutable isZero = 0;
        mutable isMZero = 0;
        mutable isPlus = 0;
        mutable isMPlus = 0;

        
        using (q = Qubit()) 
        {
            //関数に切り出すほどではないけど、functionにしてみた
            let (term0, term1) = Terms(1000);
            for (i in 1 .. term0)  //s..e でsからeまで列挙するRange型
            {
                let res1 = Solve(q);
                
                if (res1 == 0) 
                {
                    set isZero = isZero + 1;
                }
                elif (res1 == -1) 
                {
                    set isMZero = isMZero + 1;
                }
                
                Reset(q);
            }
            
            //|+>い
            for (j in 1 .. term1) 
            {
                //|+>にする
                H(q);
                let res2 = Solve(q);
                
                //|+>を|+>として測定できた場合
                if (res2 == 1) 
                {
                    set isPlus = isPlus + 1;
                }
                //|+>が不定として測定された場合
                elif (res2 == -1) 
                {
                    set isMPlus = isMPlus + 1;
                }
                
                Reset(q);
            }
        }
        
        return ((isZero, isMZero), (isPlus, isMPlus));
    }

    operation Solve (q : Qubit) : Int 
    {
        mutable output = 0;
        let basis = RandomInt(2);
        
        if (basis == 0) 
        {
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
}
