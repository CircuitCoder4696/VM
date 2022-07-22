module application.Main;
import app.VM;
import templates.AppInit;

public class Main:AppInit {
    import _vm_main;
    import std.stdio:writeln;
    public void init(string arg) { switch(arg) {
    case "-run":
        option= "run";
        break;
    case "-s":
        option= "scan";
        break;
    default:
        if(option=="") {
            log.err("No option selected!  ");
            exit(16);
        };
        params[option] ~= [arg];
    }; };
    public static void main(string[][string] params) {
        writeln(params["scan"]);
        writeln(params["run"]);
        VM vm= new VM();
        foreach(p; params["run"])if(exists(p)) {
            vm.newThread(read(p));
        } else {
            writeln("Could not find executable \"",p,"\"");
        };
    };
};
