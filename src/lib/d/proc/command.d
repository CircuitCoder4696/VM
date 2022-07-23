module d.proc.command;

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
    };
    public string[] opDispatch(string param)() {
        writeln(param);
        bool appendArguments= false;
        string[] result;
        foreach(a; this.ArgV)if(a[0]=='-') {
            appendArguments= false;
            
            if(this.pdDict.keys.indexOf(param)==-1)return;
            if(
                a[1..$]
                ==
                this.pdDict[param]
            )appendArguments= true;
        } else {
            if(appendArguments)result ~= [a];
        };
        return result;
    };
};
