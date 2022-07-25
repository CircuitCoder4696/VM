module templates.DevToolChain;
import d.io.FileIO;
private enum dbg= 4;
private FileIO file;

private struct info {
    int threshold;
    int line;
    string mod;
};

public class DevToolChain_DbgMessage {
    import d.reflection;
    import std.stdio:writeln;
    static this() {
        file= new FileIO("./log.html");
    };
    private void ____msg(T...)(T message, int threshold, string mode= "NULL") {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        if(threshold < dbg) {
            writeln("[",mode,"] ",i.mod," @",i.line,":   ",message);
            file.append("["~mode~"] "~i.mod~" @"~i.line~":   "~message);
        };
    };
    public void param(T...)(int lvl, T msg) {
        this.____msg(msg, lvl, "PARAM");
    };
    public void dbg(T...)(int lvl, T msg) {
        this.____msg(msg, lvl, "DBG");
    };
    public void info(T...)(int lvl, T msg,) {
        this.____msg(msg, lvl, "INFO");
    };
};

public abstract class DevToolChain {
    import std.stdio:writeln;
    public DevToolChain_DbgMessage log= new DevToolChain_DbgMessage();
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
