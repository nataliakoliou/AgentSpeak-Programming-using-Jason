// Alice: an agent that wants to go from floor 3 to floor 2, but will only do so once she receives a call from Bob.

+!served : not served
  <- !at(3);
     .print("Take me to 2.");
     .send(machine,achieve,at(2));
     .print("Thanks, bye!").

+!at(3) : at(3).
+!at(3) <- .print("Pick me up from 3.");
           .send(machine,achieve,at(3)).
