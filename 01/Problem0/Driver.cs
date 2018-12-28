using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Problem0
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                var initials = new [] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var res = BellTest.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes, agree) = res;
                    Console.WriteLine($"初期状態:{initial,-4} |0>={numZeros,-4} |1>={numOnes,-4} 同一={agree,-4}");
                }
            }

            Console.WriteLine("キーを押したら終了します...");
            Console.ReadKey();
        }
    }
}