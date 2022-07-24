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
    public void opDispatch(string mode, T...)(T message, int line= __LINE__) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        writeln("[",mode,"] ",st[4]," @",line,":   ",message);
    };
};

public abstract class DevToolChain {
    public DevToolChain_DbgMessage log= new DevToolChain_DbgMessage(0);
    public DevToolChain_DbgMessage log1= new DevToolChain_DbgMessage(1);
    public DevToolChain_DbgMessage log2= new DevToolChain_DbgMessage(2);
    public DevToolChain_DbgMessage log3= new DevToolChain_DbgMessage(3);
    public DevToolChain_DbgMessage log4= new DevToolChain_DbgMessage(4);
    public DevToolChain_DbgMessage log5= new DevToolChain_DbgMessage(5);
};
