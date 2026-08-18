#define SERVER_LOG_STORAGE_MAX 400 // Number of chat logs the telecomms servers will store before they start deleting the older ones.
#define TELECOMMS_SCAN_RANGE 25 // The range at which the telecomms computers can scan for telecomm servers.

///If something is an 'object' to scripting.
#define IS_OBJECT(thing) (istype(thing, /datum) || istype(thing, /list) || istype(thing, /savefile) || istype(thing, /client) || (thing==world))

GLOBAL_LIST_EMPTY(pretty_filter_items)

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
