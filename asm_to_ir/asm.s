label_0:
    MOV x1 125
    MOV x2 50
label_1:
    MOV x3 0
    MOV x4 0
label_7:
    SQUARE_ABS x4 x3 x1 x6
    BLE x2 x6 x0
    SET_COLOR x6 1
    JUMP_COND x0 label_11
label_8:
    SET_COLOR x6 0
label_11:
    PAINT_PIXEL x4 x3 x6
    INC_LT x4 500 x0
    JUMP_COND x0 label_7
label_3:
    MOV x4 0
    INC_LT x3 250 x0
    JUMP_COND x0 label_7
label_4:
    MOV x3 0
    FLUSH_WIN
    MOVE x1
    DIV x2 2 x6
    ADD x6 250 x6
    BLE x1 x6 x0
    JUMP_COND x0 label_88
label_9:
    DIV x2 -2 x1
label_88:
    INC_LT x5 1000 x0
    JUMP_COND x0 label_1
label_77:
    HLT
    