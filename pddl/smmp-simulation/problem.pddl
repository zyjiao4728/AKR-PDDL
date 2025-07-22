(define

(problem Serve-and-Clean)
(:domain AKR)
(:requirements :derived-predicates :typing :strips :equality :negative-preconditions :disjunctive-preconditions :conditional-effects)
(:objects
    OnGround_1 - state
    OnGround_2 - state
    OnGround_3 - state
    OnKitchenTable - state
    OnDesk - state
    InFridge - state
    InTrashCan - state
    Trash - obj
    Drink - obj
    Broom - obj
    Fridge - obj
    Bedroom - obj
)
(:init
    (RobotAbleToPick Robot)
    (IsNotLocation Opened)
    (IsNotLocation Closed)
    
    (RigiObj Trash)
    (ToolObj Broom)
    (ArtiObj Fridge)
    (ArtiObj Bedroom)

    (ValidState Trash OnGround_1)
    (ValidState Broom OnGround_2)
    (ValidState Drink InFridge)
    (ValidState Fridge Closed)
    (ValidState Bedroom Closed)

    (InValidState Drink OnGround_1)
    (InValidState Drink OnGround_2)
    (InValidState Drink OnGround_3)
    (InValidState Drink InTrashCan)
    (InValidState Fridge InTrashCan)
    (InValidState Bedroom InTrashCan)

    (IsOccupied OnGround_1)
    (IsOccupied OnGround_2)
    (IsOccupied InFridge)

    (IsXYPlane OnGround_1)
    (IsXYPlane OnGround_2)
    (IsXYPlane OnGround_3)

    (ContainSpace Fridge InFridge)
    (ContainSpace Bedroom OnDesk)

    (ToolReachable OnGround_1)
    (FreeHandReachable OnGround_2)
    (FreeHandReachable OnGround_3)
    (FreeHandReachable OnKitchenTable)
    (FreeHandReachable InTrashCan)
    (FreeHandReachable Opened)
    (FreeHandReachable Closed)
)

(:goal
    (and
        (ValidState Trash InTrashCan)
        (ValidState Fridge Closed)
        (ValidState Bedroom Closed)
        (ValidState Drink OnDesk)
        (ValidState Broom OnGround_2)
    )  
)
)