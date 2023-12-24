// Aegean: an aircraft that offers service

price(_Service,X) :- .random(R) & X = (80*R)+100.  // the price for the service is a random value between 100 and 180

!register.

+!register <- .df_register("participant");
              .df_subscribe("initiator").

@c +cfp(CNPId,flight(S,D))[source(A)] : provider(A,"initiator") & price(flight(S,D),Offer)
   <- +proposal(CNPId,flight(S,D),Offer); // remember my proposal
      .send(A,tell,propose(CNPId,Offer)).

@r1 +accept_proposal(CNPId) : proposal(CNPId,flight(S,D),Offer)
   <- .print("My proposal '",Offer,"' won CNP ",CNPId, " for ",flight(S,D),"!").

@r2 +reject_proposal(CNPId)
   <- .print("I lost CNP ",CNPId, ".");
      -proposal(CNPId,_,_).