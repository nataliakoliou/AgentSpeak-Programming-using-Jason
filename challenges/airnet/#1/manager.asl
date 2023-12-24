// Manager: an agent responsible for making flight reservations - assigning flight requests among the aircrafts

all_proposals_received(CNPId,NP) :-  
     .count(propose(CNPId,_)[source(_)], NO) &  
     .count(refuse(CNPId)[source(_)], NR) &    
     NP = NO + NR.  // num(participants) = num(proposals) + num(refusals)

!cnp(1,flight(athens,berlin)).
!cnp(2,flight(berlin,moscow)).
!cnp(3, flight(paris, istanbul)).
!cnp(4, flight(boston, rome)).
!cnp(5, flight(seville, beijing)).
!register.

+!register <- .df_register(initiator).

+!cnp(Id,Task)
   <- !call(Id,Task,LP);
      !bid(Id,LP);
      !winner(Id,LO,WAg);
      !result(Id,LO,WAg).

+!call(Id,Task,LP)
   <- .print("Waiting aircrafts for ",Task,"...");
      .wait(2000);
      .df_search("participant",LP);
      .print("Sending CFP to ",LP);
      .send(LP,tell,cfp(Id,Task)).

+!bid(Id,LP) // the deadline of the CNP is now + 4 seconds (or all proposals received)
   <- .wait(all_proposals_received(Id,.length(LP)), 4000, _).

+!winner(Id,LO,WAg) : .findall(offer(O,A),propose(Id,O)[source(A)],LO) & LO \== []
   <- .print("Offers are ",LO);
      .min(LO,offer(WOf,WAg)); // the first offer is the best
      .print("Winner is ",WAg," with ",WOf).
+!winner(_,_,nowinner). // no offer case

+!result(_,[],_).
+!result(CNPId,[offer(_,WAg)|T],WAg) // announce result to the winner
   <- .send(WAg,tell,accept_proposal(CNPId));
      !result(CNPId,T,WAg).
+!result(CNPId,[offer(_,LAg)|T],WAg) // announce to others
   <- .send(LAg,tell,reject_proposal(CNPId));
      !result(CNPId,T,WAg).