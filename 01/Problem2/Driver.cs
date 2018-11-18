using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Problem2
{
    class Driver
    {
        static void Main(string[] args)
        {
            //new QuantumSimulator(randomNumberGeneratorSeed:41)
            using (var sim = new QuantumSimulator()) 
            {
                var received = RunQsharp.Run(sim).Result;
                Console.WriteLine($"|0>の測定結果: |0>={received.Item1.Item1} |+>={500 - received.Item1.Item1 - received.Item1.Item2} 不定={received.Item1.Item2}");
                Console.WriteLine($"|+>の測定結果: |+>={received.Item2.Item1} |0>={500 - received.Item2.Item1 - received.Item2.Item2} 不定={received.Item2.Item2}");
                Console.ReadLine();
            }
        }
    }
}