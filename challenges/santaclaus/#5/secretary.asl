// Secretary: the manager-agent at santa's workshop, forming groups of workers

group([]).
offers(0).
extra(0).

@liam1[atomic]
+!iamhere(O)[source(A)] : group_size(S,Kind) & group(Group) & .length(Group,S-1) & offers(Os) & extra(E)
   <- -+group([]);
      -+offers(0);
      !charge(A);
      .send(santa,achieve,group(Kind,[A|Group],Os+O+E)).

@liam2[atomic]
+!iamhere(O)[source(A)] : group(Group) & offers(Os) & extra(E)
   <- -+group([A|Group]);
      !charge(A);
      -+offers(Os+O+E).

+!charge(A) : A==elf2 | A==elf7
   <- .print("Ah, it's ",A," again! Let's spice up his offer with an extra special charge... +100!");
      -+extra(100).
+!charge(A)
   <- -+extra(0).