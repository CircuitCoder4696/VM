module app.Main;
import templates.AppInit;

public class Main:AppInit {
    import _vm_main;
    import std.stdio:writeln;
    public void main() {
        string arg= getNextArg();
        writeln(arg);
        switch(arg) {
            case "-s":
                option= "scan";
                next= true;
                break;
            default:
                if(option=="") {
                    log.err("No option selected!  ");
                    exit(16);
                };
                log.dbg("Should have an associated array of parameters.  ");
                writeln(params);
        };
    };
};
