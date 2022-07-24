module templates.DevToolChain;

version(dbg_01){private enum dbg= 1;}else
version(dbg_02){private enum dbg= 2;}else
version(dbg_03){private enum dbg= 3;}else
version(dbg_04){private enum dbg= 4;}else
version(dbg_05){private enum dbg= 5;}else
{ private enum dbg= 0; }

public class DevToolChain_DbgMessage {
    import d.reflection;
    import std.stdio:writeln;
    public uint threshold;
    public this(uint threshold) {
        this.threshold= threshold;
    };
    public static void opDispatch(string mode, T...)(T message, int line= __LINE__) {
        // if(dbg <= this.threshold)return;
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        writeln("[",mode,"] ",st[4]," @",line,":   ",message);
    };
};

public abstract class DevToolChain {
    import std.stdio:writeln;
    public DevToolChain_DbgMessage log= new DevToolChain_DbgMessage(0);
    public DevToolChain_DbgMessage log1= new DevToolChain_DbgMessage(1);
    public DevToolChain_DbgMessage log2= new DevToolChain_DbgMessage(2);
    public DevToolChain_DbgMessage log3= new DevToolChain_DbgMessage(3);
    public DevToolChain_DbgMessage log4= new DevToolChain_DbgMessage(4);
    public DevToolChain_DbgMessage log5= new DevToolChain_DbgMessage(5);
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
