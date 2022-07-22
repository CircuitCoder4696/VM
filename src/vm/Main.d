module Main;
import templates.AppInit;

public class Main:AppInit {
    import main;
    import std.stdio:writeln;
    public static string[] ArgV;
    public static void initProc(uint ArgI) {
        switch(ArgV[ArgI]) {
            case "-s":
                writeln("[UNIMPL] ",__MODULE__," @",__LINE__,":   The scan option is not yet implemented.  ");
                break;
            default:
                if(option=="") {
                    writeln("No option selected!  ");
                    exit(-1);
                };
        };
    };
};
