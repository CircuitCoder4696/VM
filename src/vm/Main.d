module Main;

public class Main {
    import std.stdio:writeln;
    public static string[] ArgV;
    public static void initProc(uint ArgI) {
        switch(ArgV[ArgI]) {
            case "-s":
                writeln("[UNIMPL] ",__MODULE__," @",__LINE__,":   The scan option is not yet implemented.  ");
                break;
            default:
                if((cast(size_t)option)==0) {
                    writeln("No option selected!  ");
                    exit(-1);
                };
        };
    };
};
