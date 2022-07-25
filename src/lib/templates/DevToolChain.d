module templates.DevToolChain;
import d.io.FileIO;
private enum dbg= 4;
private FileIO file;

private struct info {
    int threshold;
    int line;
    string mod;
};

public class Logger {
    import d.reflection;
    import std.stdio:writeln;
    static this() {
        file= new FileIO("./log.html");
    };
    private void ____msg(T...)(string mode, int threshold, T message) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        if(threshold < dbg) {
            writeln("[",mode,"] ",st[4]," :   ",message);
            file.append("[",mode,"] ",st[4]," :   ",message);
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
    public Logger log= new Logger();
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
