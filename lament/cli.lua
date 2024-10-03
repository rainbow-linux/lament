local argparse = require("argparse")

local parser = argparse("lament", "Simple bidirectional configuration application tool")

parser:argument("module", "The module name")
parser:argument("setting", "The setting name")
parser:argument("value", "The value to set")

local args = parser:parse()

local function print_help()
    print("Usage:")
    print("  lament <command> [options]")
    print()
    print("Commands:")
    print("  set <module> <setting> <value>                   Set a value for a module setting")
    print("  advanced <module> <setting> <action> <value>    Advanced setting operations (append, remove, set)")
    print("  apply                                           Apply all changes")
    print()
    print("Options:")
    print("  --module <module>       The module name")
    print("  --setting <setting>     The setting name")
    print("  --value <value>         The value to set or append")
    print("  --action <action>       The action to perform (append, remove, set)")
end

if args._command == "apply" then
    print("Applying all changes...")
elseif args._command == "set" then
    if args.module and args.setting and args.value then
        print(string.format("Setting '%s' of module '%s' to '%s'.", args.setting, args.module, args.value))
    else
        print("Missing arguments for 'set' command.")
        print_help()
    end
elseif args._command == "advanced" then
    if args.module and args.setting and args.action and args.value then
        if args.action == "append" then
            print(string.format("Appending '%s' to setting '%s' of module '%s'.", args.value, args.setting, args.module))
        elseif args.action == "remove" then
            print(string.format("Removing '%s' from setting '%s' of module '%s'.", args.value, args.setting, args.module))
        elseif args.action == "set" then
            print(string.format("Setting '%s' of module '%s' to '%s'.", args.setting, args.module, args.value))
        else
            print("Unknown action. Use 'append', 'remove', or 'set'.")
            print_help()
        end
    else
        print("Missing arguments for 'advanced' command.")
        print_help()
    end
end
