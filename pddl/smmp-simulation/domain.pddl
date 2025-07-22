(define (domain AKR)
    (:requirements :derived-predicates :typing :strips :equality :negative-preconditions :disjunctive-preconditions :conditional-effects)
    (:types
        state obj akr - object
    )

    (:constants
        Robot - akr
        Opened - state
        Closed - state
    )

    (:predicates
        (ArtiObj ?o - obj)
        (RigiObj ?o - obj)
        (ToolObj ?o - obj)
        (FreeHandReachable ?s)
        (ToolReachable ?s)
        (ContainSpace ?o ?s)
        (OnRobot ?o - obj)
        (HasTool ?akr - akr)
        (ValidState ?o - obj ?s - state)
        (InValidState ?o - obj ?s - state)
        (RobotAbleToPick ?akr - akr)
        (IsNotLocation ?s)
        (IsXYPlane ?s)
        (IsOccupied ?s)
    )

    ; max 1 tool + 1 rigid/tool object in hand
    (:action pick-akr
        :parameters (?o - obj ?s - state ?akr - akr)
        :precondition (and
            (ValidState ?o ?s)
            (RobotAbleToPick ?akr)
            (or
                (and
                    (not (ArtiObj ?o))
                    (ToolReachable ?s)
                    (HasTool ?akr)
                )
                (and
                    (not (ArtiObj ?o))
                    (FreeHandReachable ?s)
                )
                (and
                    ; cannot manipulate articulate object when holding a tool
                    (ArtiObj ?o)
                    (FreeHandReachable ?s)
                    (not (HasTool ?akr))
                )
            )
        )
        :effect (and
            (not (ValidState ?o ?s))
            (OnRobot ?o)
            (when
                (and
                    (ToolObj ?o)
                    (HasTool ?akr)
                )
                (not (RobotAbleToPick ?akr))
            )
            (when
                (and
                    (ToolObj ?o)
                    (not (HasTool ?akr))
                )
                (HasTool ?akr)
            )
            (when
                ; when pick up a articulate/rigid object
                (not (ToolObj ?o))
                (not (RobotAbleToPick ?akr))
            )
            (when
                (not (IsNotLocation ?s))
                (not (IsOccupied ?s))
            )
        )
    )

    (:action place-akr
        :parameters (?o - obj ?s - state ?akr - akr)
        :precondition (and
            (OnRobot ?o)
            (or
                (and
                    (HasTool ?akr)
                    (RigiObj ?o)
                    (IsXYPlane ?s)
                )
                (or
                    (not (HasTool ?akr))
                    (ToolObj ?o)
                )
            )
            (or
                (IsNotLocation ?s)
                (not (IsOccupied ?s))
            )
            (or
                (ArtiObj ?o)
                (not (IsNotLocation ?s))
            )
            (or
                (and
                    (ToolReachable ?s)
                    (HasTool ?akr)
                    (not (ToolObj ?o))
                )
                (FreeHandReachable ?s)
            )
            (or
                (and
                    ; Cannot place a tool if there is an object attached to it
                    (ToolObj ?o)
                    (RobotAbleToPick ?akr)
                )
                (not (ToolObj ?o))
            )
            (not (InValidState ?o ?s))

        )
        :effect (and
            (ValidState ?o ?s)
            (not (OnRobot ?o))
            (when
                (not (ToolObj ?o))
                (RobotAbleToPick ?akr)
            )
            (when
                ; use tool pick anthor tool
                (and
                    (ToolObj ?o)
                    (not (RobotAbleToPick ?akr))
                )
                (RobotAbleToPick ?akr)
            )
            (when
                (and
                    (ToolObj ?o)
                    (RobotAbleToPick ?akr)
                )
                (not (HasTool ?akr))
            )
            (when
                (and
                    (ArtiObj ?o)
                    (= ?s Opened)
                )
                (forall
                    (?room - state)
                    (when
                        (ContainSpace ?o ?room)
                        (FreeHandReachable ?room)
                    )
                )
            )
            (when
                (and
                    (ArtiObj ?o)
                    (= ?s Closed)
                )
                (forall
                    (?room - state)
                    (when
                        (ContainSpace ?o ?room)
                        (not (FreeHandReachable ?room))
                    )
                )
            )
            (when
                (not (IsNotLocation ?s))
                (IsOccupied ?s)
            )
        )
    )
)