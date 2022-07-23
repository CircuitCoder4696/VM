module templates.DevToolChain;

public class DevToolChain_DbgMessage {
    import d.reflection;
    import std.stdio:writeln;
    public static void opDispatch(string mode, T...)(T message, int line= __LINE__) {
        string[] st= stack_trace();
        // foreach(i, sts; st)writeln("[",i,"]: ",sts);
        writeln("[",mode,"] ",st[4]," @",line,":   ",message);
    };
};

public abstract class DevToolChain {
    public DevToolChain_DbgMessage log= new DevToolChain_DbgMessage();
};