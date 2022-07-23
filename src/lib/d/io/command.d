module d.io.command;

public class ArgHandler {
    private string[] ArgV;
    private string[string] pde;
    public this(string... pd)(string[] ArgV, pd parameterDefinitions) {
        this.ArgV= ArgV;
        string[] pdeSegs;
        foreach(pde; parameterDefinitions) {
            pdeSegs= pde.split(":");
            pdDict[pdeSegs[0]]= pdeSegs[1];
        };
    };
    public static string[] opDispatch(string param)() {
        bool appendArguments= false;
        string[] result;
        foreach(a; this.ArgV)if(a[0]=='-') {
            appendArguments= false;
            if(a[1..$]==param)appendArguments= true;
        } else {
            if(appendArguments)result ~= [a];
        };
        return result;
    };
};
