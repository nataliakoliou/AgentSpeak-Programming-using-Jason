// Machine: the agent that controlls the elevator.

+!at(Y) : at(Y).

+!at(Y) : at(X)
  <- move(X,Y).