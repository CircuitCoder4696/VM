module app.Main;
import templates.AppInit;

public class Main:AppInit {
    import _vm_main;
    import std.stdio:writeln;
    public void main(uint ArgI) {
        switch(ArgV[ArgI]) {
            case "-s":
                option= "scan";
                break;
            default:
                if(option=="") {
                    writeln("No option selected!  ");
                    exit(16);
                };
                params[option] ~= [ArgV[ArgI]];
                writeln(params);
        };
    };
};
