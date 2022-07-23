module d.proc.command;

public class ArgHandler {
    private string[] ArgV;
    private string[string] pdDict;
    public this(pd...)(string[] ArgV, pd parameterDefinitions) {
        import std.array;
        this.ArgV= ArgV;
        string[] pdeSegs;
        // foreach(pde; parameterDefinitions) {
        //     pdeSegs= pde.split(":");
        //     pdDict[pdeSegs[0]]= pdeSegs[1];
        // };
        this.pdDict["compile"]= "c";
    };
    public string[] opDispatch(string param)() {
        // import std.array;
        // if(this.pdDict.keys.indexOf(param)==-1)return null;
        bool appenArgs= false;
        string[] result;
        return [param];
    };
};
