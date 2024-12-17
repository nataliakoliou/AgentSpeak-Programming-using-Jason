// Prisoner: prisoner agent

reward(0).

decide(confess, Prob) :- Prob <= 0.5.
decide(lie, Prob) :- Prob > 0.5.

!register.

+!register <- .df_register("participant");
              .df_subscribe("initiator").

@c +cfp(Episode)[source(A)] : provider(A,"initiator")
   <- .random(Prob);
      ?decide(Action, Prob);
      .print("[Episode ", Episode, "] I will ",Action," because random number is ", Prob, ".");
      +play(Episode,Action);
      .send(A,tell,play(Episode,Action)).

@r1 +add(Episode, Value)[source(A)] : provider(A,"initiator") & play(Episode, Action)
   <- ?reward(Total);
      New = Total + Value;
      -+reward(New);
      .print("[Episode ", Episode, "] I got a reward of ",Value," playing action ",Action, " so my new total reward is ",New, ".");
      .send(A,achieve,update(New)).