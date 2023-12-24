// Lufthansa: an aircraft currently under maintenance - hence not available for passengers

price(_Service,X) :- .random(R) & X = (50*R)+120.  // the price for the service is a random value between 120 and 170

!register.

+!register <- .df_register("participant").