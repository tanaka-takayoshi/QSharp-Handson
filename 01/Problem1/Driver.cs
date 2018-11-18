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
                    Console.WriteLine($"Round {i}:\tSent {sent},\tgot {received}.");
                    Console.WriteLine(sent == received ? "Teleportation successful!!\n" : "\n");
                }
            }

            Console.WriteLine("\n\nPress Enter to continue...\n\n");
            Console.ReadLine();
        }
    }
}