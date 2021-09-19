/// Helper define that can only be used in /obj/item/circuit_component/input_received()
#define COMPONENT_TRIGGERED_BY(trigger, port) (trigger.value && trigger == port)

/// Define to be placed at any proc that is triggered by a port.
#define CIRCUIT_TRIGGER SHOULD_NOT_SLEEP(TRUE)

// Port defines

#define PORT_MAX_NAME_LENGTH 50

// Port types. Determines what the port can connect to

/// Can accept any datatype. Only works for inputs, output types will runtime.
#define PORT_TYPE_ANY "any"

// Fundamental datatypes
/// String datatype
#define PORT_TYPE_STRING "string"
#define PORT_MAX_STRING_LENGTH 5000
#define PORT_MAX_STRING_DISPLAY 100
/// Number datatype
#define PORT_TYPE_NUMBER "number"
/// Signal datatype
#define PORT_TYPE_SIGNAL "signal"
/// List datatype
#define PORT_TYPE_LIST "list"
/// Table datatype. Derivative of list, contains other lists with matching columns.
#define PORT_TYPE_TABLE "table"
/// Options datatype. Derivative of string.
#define PORT_TYPE_OPTION "option"

// Other datatypes
/// Atom datatype
#define PORT_TYPE_ATOM "entity"


/// The maximum range between a port and an atom
#define PORT_ATOM_MAX_RANGE 7

#define COMPONENT_DEFAULT_NAME "component"

/// The minimum position of the x and y co-ordinates of the component in the UI
#define COMPONENT_MIN_RANDOM_POS 200
/// The maximum position of the x and y co-ordinates of the component in the UI
#define COMPONENT_MAX_RANDOM_POS 400

/// The maximum position in both directions that a component can be in.
/// Prevents someone from positioning a component at an absurdly high value.
#define COMPONENT_MAX_POS 10000

// Components

/// The value that is sent whenever a component is simply sending a signal. This can be anything, and is currently the seconds since roundstart.
#define COMPONENT_SIGNAL (world.time / (1 SECONDS))

// Comparison defines
#define COMP_COMPARISON_EQUAL "="
#define COMP_COMPARISON_NOT_EQUAL "!="
#define COMP_COMPARISON_GREATER_THAN ">"
#define COMP_COMPARISON_LESS_THAN "<"
#define COMP_COMPARISON_GREATER_THAN_OR_EQUAL ">="
#define COMP_COMPARISON_LESS_THAN_OR_EQUAL "<="

// Clock component
#define COMP_CLOCK_DELAY 0.9 SECONDS

// Shells

/// Whether a circuit is stuck on a shell and cannot be removed (by a user)
#define SHELL_FLAG_CIRCUIT_FIXED (1<<0)

/// Whether the shell needs to be anchored for the circuit to be on.
#define SHELL_FLAG_REQUIRE_ANCHOR (1<<1)

/// Whether or not the shell has a USB port.
#define SHELL_FLAG_USB_PORT (1<<2)

/// Whether the shell allows actions to be peformed on a shell if the action fails. This will additionally block the messages from being displayed.
#define SHELL_FLAG_ALLOW_FAILURE_ACTION (1<<3)

// Shell capacities. These can be converted to configs very easily later
#define SHELL_CAPACITY_SMALL 25
#define SHELL_CAPACITY_MEDIUM 50
#define SHELL_CAPACITY_LARGE 100
#define SHELL_CAPACITY_VERY_LARGE 500

/// The maximum range a USB cable can be apart from a source
#define USB_CABLE_MAX_RANGE 2

// Circuit flags
/// Creates an input trigger that means the component won't be triggered unless the trigger is pulsed.
#define CIRCUIT_FLAG_INPUT_SIGNAL (1<<0)
/// Creates an output trigger that sends a pulse whenever the component is successfully triggered
#define CIRCUIT_FLAG_OUTPUT_SIGNAL (1<<1)
/// Prohibits the component from being duplicated via the module duplicator
#define CIRCUIT_FLAG_UNDUPEABLE (1<<2)
/// Marks a circuit component as admin only. Admins will only be able to link/unlink with these circuit components.
#define CIRCUIT_FLAG_ADMIN (1<<3)
/// This circuit component does not show in the menu.
#define CIRCUIT_FLAG_HIDDEN (1<<4)
/// This circuit component has been marked as a component that has instant execution and will show up in the UI as so. This will only cause a visual change.
#define CIRCUIT_FLAG_INSTANT (1<<5)

// Datatype flags
/// The datatype supports manual inputs
#define DATATYPE_FLAG_ALLOW_MANUAL_INPUT (1<<0)
/// The datatype won't update the value when it is connected to the port
#define DATATYPE_FLAG_AVOID_VALUE_UPDATE (1<<1)
