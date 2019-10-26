/// Tokens.
struct token
{
    enum yytokentype
    {
        INT = 258,
        BOOL = 259,
        VOID = 260,
        TRUE = 261,
        FALSE = 262,
        IF = 263,
        ELSE = 264,
        WHILE = 265,
        RETURN = 266,
        CIN = 267,
        COUT = 268,
        RIGHT_OP = 269,
        LEFT_OP = 270,
        AND_OP = 271,
        OR_OP = 272,
        LE_OP = 273,
        GE_OP = 274,
        EQ_OP = 275,
        NE_OP = 276,
        SEMICOL = 277,
        LB = 278,
        RB = 279,
        COL = 280,
        EQ = 281,
        LRB = 282,
        RRB = 283,
        LSB = 284,
        RSB = 285,
        MINUS = 286,
        PLUS = 287,
        TIMES = 288,
        DIVIDE = 289,
        GL = 290,
        GR = 291,
        IDENTIFIER = 292,
        STRINGLITERAL = 293
    };
};