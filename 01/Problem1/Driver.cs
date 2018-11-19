using System;
using System.Linq;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Problem1
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var rand = new System.Random();

                foreach (var i in Enumerable.Range(0, 8))
                {
                    var sent = rand.Next(2) == 0;
                    var received = TeleportClassicalMessage.Run(sim, sent).GetAwaiter().GetResult();
                    Console.WriteLine($"{i}回目: Sent {sent}, got {received}.");
                    Console.WriteLine(sent == received ? "Teleportation 成功!!\n" : "\n");
                }
            }

            Console.WriteLine("キーを押したら終了します...");
            Console.ReadLine();
        }
    }
}