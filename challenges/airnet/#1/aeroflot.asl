// Aeroflot: an aircraft fully booked for all its scheduled flights - hence always rejecting new passengers

!register.

+!register <- .df_register("participant");
              .df_subscribe("initiator").

@c +cfp(CNPId,_Service)[source(A)] : provider(A,"initiator")
   <- .send(A,tell,refuse(CNPId)).