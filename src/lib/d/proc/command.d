module d.proc.command;

public bool contains(string[] self, string query) {
    foreach(v; self)if(v==query)return true;
    return false;
};

public class ArgHandler {
    private string[] ArgV;
    private string[string] pdDict;
    public this(pd...)(string[] ArgV, pd parameterDefinitions) {
        import std.array;
        this.ArgV= ArgV;
        string[] pdeSegs;
        foreach(pde; parameterDefinitions) {
            pdeSegs= pde.split(":");
            pdDict[pdeSegs[0]]= pdeSegs[1];
        };
        this.pdDict["compile"]= "c";
        this.pdDict["args"]= "args";
    };
    public string[] getParam(string param) {
        import std;
        // import std.array;
        if(!this.pdDict.keys.contains(param))return null;
        bool appendArgs= false;
        string[] result;
        foreach(arg; this.ArgV[1..$])if(arg[0]=='-') {
            appendArgs= false;
            if(arg[1..$]==this.pdDict[param])appendArgs= true;
        } else {
            if(appendArgs)result ~= [arg];
        };
        return result;
    };
};
