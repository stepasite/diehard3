-------- MODULE diehard3 --------
EXTENDS Integers, Sequences, TLC

VARIABLES jug3, jug5, path

Min (a,b) == IF a < b THEN a ELSE b

Init ==
    /\ jug3 = 0
    /\ jug5 = 0
    /\ path = << >>

FillJug3 ==
    /\ jug3 < 3
    /\ jug3' = 3
    /\ jug5' = jug5
    /\ path' = Append(path, <<jug3', jug5'>>)

FillJug5 ==
    /\ jug5 < 5
    /\ jug3' = jug3
    /\ jug5' = 5
    /\ path' = Append(path, <<jug3', jug5'>>)

EmptyJug3 ==
    /\ jug3 > 0
    /\ jug3' = 0
    /\ jug5' = jug5
    /\ path' = Append(path, <<jug3', jug5'>>)

EmptyJug5 ==
    /\ jug5 > 0
    /\ jug3' = jug3
    /\ jug5' = 0
    /\ path' = Append(path, <<jug3', jug5'>>)

PourJug3ToJug5 ==
    /\ jug3 > 0
    /\ jug5 < 5
    /\ LET pourAmt == Min(jug3, 5 - jug5)
     IN /\ jug3' = jug3 - pourAmt
        /\ jug5' = jug5 + pourAmt
        /\ path' = Append(path, <<jug3', jug5'>>)

PourJug5ToJug3 ==
    /\ jug5 > 0
    /\ jug3 < 3
    /\ LET pourAmt == Min(jug5, 3 - jug3)
     IN /\ jug5' = jug5 - pourAmt
        /\ jug3' = jug3 + pourAmt
        /\ path' = Append(path, <<jug3', jug5'>>)

Next ==
    \/ FillJug3
    \/ FillJug5
    \/ EmptyJug3
    \/ EmptyJug5
    \/ PourJug3ToJug5
    \/ PourJug5ToJug3

Goal ==
    jug5 /= 4

Spec ==
    Init /\ [][Next]_<<jug3, jug5, path>>
================
