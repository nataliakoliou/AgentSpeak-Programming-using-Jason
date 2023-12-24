// Paul: an agent that wants to go from floor 7 to floor 6.

!served.

+!served : not served & at(X) & X>=7-1 & X<=7+1
  <- !at(7);
     .print("Take me to 6.");
     .send(machine,achieve,at(6));
     .print("Thanks, bye!").
+!served <- .print("I'll take the stairs.");
            stairs.

+!at(7) : at(7).
+!at(7) <- .print("Pick me up from 7.");
           .send(machine,achieve,at(7)).
