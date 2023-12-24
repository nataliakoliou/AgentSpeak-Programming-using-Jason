// Secretary: the manager-agent at santa's workshop, forming groups of workers

group([]).

@liam1[atomic]
+!iamhere[source(A)] : group_size(S,Kind) & group(Group) & .length(Group,S-1)
   <- -+group([]);
      .send(santa,achieve,group(Kind,[A|Group])).

@liam2[atomic]
+!iamhere[source(A)] : group(Group)
   <- -+group([A|Group]).