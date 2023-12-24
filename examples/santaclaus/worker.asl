// Worker: the worker-agent at santa's workshop, providing service either as an elf or as a reindeer

msg("Ho, ho, ho! Let's meet in the study!") :- kind(elf).
msg("Ho, ho, ho! Let's deliver toys!") :- kind(reindeer).

!start.
+!start : secretary(S) <- .send(S,achieve,iamhere).

+!proceed[source(A)] : msg(M)
   <- .print(M);
      .send(A,tell,done);
      .wait(math.random(20)+10);
      !!start.