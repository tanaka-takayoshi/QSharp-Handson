namespace Problem1
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Teleport(msg : Qubit, there : Qubit) : Unit 
     {
        borrowing  (here = Qubit()) 
        {        
            // Create some entanglement that we can use to send our message.
            H(here);
            CNOT(here, there);
        
            // Move our message into the entangled pair.
            CNOT(msg, here);
            H(msg);

            // Measure out the entanglement.
            if (M(msg) == One)  { Z(there); }
            if (M(here) == One) { X(there); }

            // Reset our "here" qubit before releasing it.
            Reset(here);
        }

    }

    operation TeleportClassicalMessage(message : Bool) : Bool
    {
        mutable measurement = false;

        //using ((msg, there) = (Qubit(), Qubit()))
        using (register = Qubit[2])
        {
            // Ask for some qubits that we can use to teleport.
            let msg = register[0];
            let there = register[1];
            
            // Encode the message we want to send.
            if (message) { X(msg); }
        
            // Use the operation we defined above.
            Teleport(msg, there);

            // Check what message was sent.
            if (M(there) == One) { set measurement = true; }

            // Reset all of the qubits that we used before releasing
            // them.
            ResetAll(register);
        }

        return measurement;

    }
}
