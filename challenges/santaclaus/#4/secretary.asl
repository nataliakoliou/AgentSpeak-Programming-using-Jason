// Secretary: the manager-agent at santa's workshop, forming groups of workers

group([]).
offers(0).

@liam1[atomic]
+!iamhere(O)[source(A)] : group_size(S,Kind) & group(Group) & .length(Group,S-1) & offers(Os)
   <- -+group([]);
      -+offers(0);
      .send(santa,achieve,group(Kind,[A|Group],Os+O)).

@liam2[atomic]
+!iamhere(O)[source(A)] : group(Group) & offers(Os)
   <- -+group([A|Group]);
      -+offers(Os+O).