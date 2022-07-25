module templates.DevToolChain;
import d.io.FileIO;
private enum threshold= 4;
private FileIO file;

private struct info {
    int threshold;
    int line;
    string mod;
};

private void[] voidArr(string self) @property {
    return cast(void[]) self[];
};

public class Logger {
    import d.reflection;
    import std.format;
    import std.stdio:writeln;
    static this() {
        file= new FileIO("./log.html");
    };
    public uint threshold;
    public this(uint threshold) {
        this.threshold= threshold;
    };
    private void ____msg(T...)(string mode, int threshold, T message) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        if(this.threshold < threshold) {
            writeln("[",mode,"] ",st[4]," :   ",message);
            file.append("[%s] %s:   %s".format(mode, st[4], message).voidArr);
        };
    };
    public void param(T...)(int lvl, T msg) {
        this.____msg("", lvl, msg);
    };
    public void dbg(T...)(int lvl, T msg) {
        this.____msg("", msg, lvl);
    };
    public void info(T...)(int lvl, T msg,) {
        this.____msg("", msg, lvl);
    };
};

public abstract class DevToolChain {
    import std.stdio:writeln;
    public Logger log= new Logger(0);
    public Logger log1= new Logger(1);
    public Logger log2= new Logger(2);
    public Logger log3= new Logger(3);
    public Logger log4= new Logger(4);
    public Logger log5= new Logger(5);
    public static void start0() {
        writeln("/----- (0)");
    };
    public static void stop0() {
        writeln("\\----- (0)");
    };
    public static void start1() {
        writeln("/----- (1)");
    };
    public static void stop1() {
        writeln("\\----- (1)");
    };
    public static void start2() {
        writeln("/----- (2)");
    };
    public static void stop2() {
        writeln("\\----- (2)");
    };
    public static void start3() {
        writeln("/----- (3)");
    };
    public static void stop3() {
        writeln("\\----- (3)");
    };
    public static void start4() {
        writeln("/----- (4)");
    };
    public static void stop4() {
        writeln("\\----- (4)");
    };
    public void start5() {
        writeln("/----- (5)");
    };
    public void stop5() {
        writeln("\\----- (5)");
    };
};
