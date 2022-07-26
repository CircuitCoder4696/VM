module templates.DevToolChain;
import d.io.FileIO;
private enum threshold= 2;
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
    public uint th;
    public this(uint level) {
        this.th= level;
        if(this.th >= threshold)writeln("Logger",level," can log stuff.  ");
    };
    private void ____msg(string mode, string[] message) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        string msg= "";
        writeln("log.____msg   th=",th);
        if(this.th >= threshold)return;
        foreach(s; message)msg ~= s;
        writeln("[",mode,"] ",st[4]," :   ",msg);
        file.append("[%s] %s:   %s".format(mode, st[4], msg).voidArr);
    };
    public void param(T...)(T message) {
        string[] d= [];
        foreach(v; message)d ~= ["%s".format(v)];
        this.____msg("param", d);
    };
    public void dbg(T...)(T message) {
        string[] d= [];
        foreach(v; message)d ~= ["%s".format(v)];
        this.____msg("debug", d);
    };
    public void info(T...)(T message) {
        string[] d= [];
        writeln("log.info");
        foreach(v; message)d ~= ["%s".format(v)];
        this.____msg("info", d);
    };
    public void warn(T...)(T message) {
        string[] d= [];
        foreach(v; message)d ~= ["%s".format(v)];
        this.____msg("warn", d);
    };
    public void error(T...)(T message) {
        string[] d= [];
        foreach(v; message)d ~= ["%s".format(v)];
        this.____msg("error", d);
    };
};

public abstract class DevToolChain {
    import std.stdio:writeln;
    public static Logger log;
    public static Logger log1;
    public static Logger log2;
    public static Logger log3;
    public static Logger log4;
    public static Logger log5;
    static this() {
        DevToolChain.log= new Logger(0);
        DevToolChain.log1= new Logger(1);
        DevToolChain.log2= new Logger(2);
        DevToolChain.log3= new Logger(3);
        DevToolChain.log4= new Logger(4);
        DevToolChain.log5= new Logger(5);
    };
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
