// Aeroflot: an aircraft that offers service under certain conditions

price(_Service,X) :- .random(R) & X = (100*R)+100. // the price for the service is a random value between 100 and 200
forbidden(flight(S,D)) :- S==paris | D==paris.

!register.

+!register <- .df_register("participant");
              .df_subscribe("initiator").

@c1 +cfp(CNPId,flight(S,D))[source(A)] : provider(A,"initiator") & forbidden(flight(S,D))
   <- .print("Sorry, I can't provide service to CNP ",CNPId, " for ",flight(S,D),".");
      .send(A,tell,refuse(CNPId)).

@c2 +cfp(CNPId,flight(S,D))[source(A)] : provider(A,"initiator") & price(flight(S,D),Offer)
   <- +proposal(CNPId,flight(S,D),Offer); // remember my proposal
      .send(A,tell,propose(CNPId,Offer)).

@r1 +accept_proposal(CNPId) : proposal(CNPId,flight(S,D),Offer)
   <- .print("My proposal '",Offer,"' won CNP ",CNPId, " for ",flight(S,D),"!").

@r2 +reject_proposal(CNPId)
   <- .print("I lost CNP ",CNPId, ".");
      -proposal(CNPId,_,_).