// Worker: the worker-agent at santa's workshop, providing service either as an elf or as a reindeer

msg("Ho, ho, ho! Let's meet in the study!") :- kind(elf).
msg("Ho, ho, ho! Let's deliver toys!") :- kind(reindeer).

offer(O) :- .random(R) & O = (10*R)+1.

!start.
+!start : secretary(S) & offer(O)
   <- .send(S,achieve,iamhere(O)).

+!proceed[source(A)] : msg(M)
   <- .print(M);
      .send(A,tell,done);
      .wait(math.random(20)+10);
      !!start.