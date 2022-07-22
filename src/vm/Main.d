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
                break;
            default:
                if(option=="") {
                    writeln("No option selected!  ");
                    exit(16);
                };
                writeln("Should ave an associated array of parameters.  ");
                writeln(params);
        };
    };
};
