// Santa: the leader-agent at his workshop, assisting reindeers in toy delivery and elves in toy development

round(0).

+!group(Kind,G) : .desire(work(_,_))  // if santa is busy, goal !group will be resumed after !work
   <- .print("Waiting to proceed with ",G, " ...");
      .suspend;                      
      !!group(Kind,G).               
@lg[atomic]  // santa cannot handle another event +!group (from resume) before executing !!work
+!group(Kind,G)
   <- !!work(Kind,G).  // use !! so that work() isn’t performed as atomic

+!work(Kind,G) : round(N) & N < 20  // just a stop condition
   <- .print("Working with ",Kind,"s: ",G," (",N,")");
      -+round(N+1);
      .abolish(done);
      .send(G,achieve,proceed);
      .wait(.count(done[source(_)],.length(G)));  // suspends this intention until |G| dones are received
      .print("Group ",G," of ",Kind,"s has finished");
      !!resume_all.  // .resume() needs to be in another intention, otherwise st claus will be working while checking new groups)
+!work(_,_) <- .print("It is better to stop for now...").

+!resume_all <-
      .resume(group(elf,_));  // elfs have priority
      .resume(group(_,_)).