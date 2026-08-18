#define SERVER_LOG_STORAGE_MAX 400 // Number of chat logs the telecomms servers will store before they start deleting the older ones.
#define TELECOMMS_SCAN_RANGE 25 // The range at which the telecomms computers can scan for telecomm servers.

///If something is an 'object' to scripting.
#define IS_OBJECT(thing) (istype(thing, /datum) || istype(thing, /list) || istype(thing, /savefile) || istype(thing, /client) || (thing==world))

GLOBAL_LIST_EMPTY(pretty_filter_items)

/*
 * Macros: Status Macros
 */
///Indicates that the current function is returning a value.
#define RETURNING (1<<0)
///Indicates that the current loop is being terminated.
#define BREAKING (1<<2)
///Indicates that the rest of the current iteration of a loop is being skipped.
#define CONTINUING (1<<3)
///Indicates that we are entering a new function and the allowed_status var should be cleared
#define RESET_STATUS (1<<4)

/**
 * Macros: Operator Precedence
 * The higher the value, the lower the priority in the precedence.
 */
#define OOP_ASSIGN 0
///Logical or ||
#define OOP_OR 1
///Logical and &&
#define OOP_AND 2
///Bitwise operations &, |
#define OOP_BIT 3
///Equality checks ==, !=
#define OOP_EQUAL 4
///Greater than, less than, etc >, <, >=, <=
#define OOP_COMPARE 5
///Addition and subtraction + -
#define OOP_ADD 6
///Multiplication and division * / %
#define OOP_MULTIPLY 7
///Exponents ^
#define OOP_POW 8
///Unary Operators !
#define OOP_UNARY 9
///Parenthesis ()
#define OOP_GROUP 10
