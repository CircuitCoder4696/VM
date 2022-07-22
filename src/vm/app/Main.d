module application.Main;
import templates.AppInit;

public class Main:AppInit {
    import _vm_main;
    import std.stdio:writeln;
    public void init(string arg) { switch(arg) {
    case "-s":
        option= "scan";
        next= true;
        break;
    default:
        if(option=="") {
            log.err("No option selected!  ");
            exit(16);
        };
        params[option] ~= [arg];
    }; };
};
