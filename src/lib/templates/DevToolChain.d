module templates.DevToolChain;
private enum dbg= 1;

public class DevToolChain_DbgMessage {
    import d.reflection;
    import std.stdio:writeln;
    public static void opDispatch(string mode, T...)(int threshold, T message, int line= __LINE__) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        if(threshold < dbg)writeln("[",mode,"] ",st[4]," @",line,":   ",message);
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
