// Bob: an agent that wants to go from floor 0 to floor 1.

!served.

+!served : not served & at(X) & X<=2
  <- !at(0);
     .print("Take me to 1.");
     .send(machine,achieve,at(1));
     .print("Thanks, bye!").
+!served <- .print("Alice go!");
            .send(alice,achieve,served);
            .print("I'll wait here.");
            .wait(1000);
            !served.

+!at(0) : at(0).
+!at(0) <- .print("Pick me up from 0.");
           .send(machine,achieve,at(0)).
