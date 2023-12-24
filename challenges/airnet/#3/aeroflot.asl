// Aeroflot: an aircraft fully booked for all its scheduled flights - hence always rejecting new passengers

price(_Service,X) :- .random(R) & X = (100*R)+100. // the price for the service is a random value between 100 and 200

!register.

+!register <- .df_register("participant");
              .df_subscribe("initiator").

@c +cfp(CNPId,_Service)[source(A)] : provider(A,"initiator")
   <- .send(A,tell,refuse(CNPId)).