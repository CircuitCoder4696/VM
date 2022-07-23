module d.io.command;

public class ArgHandler {
    private string[] ArgV;
    public static string[] opDispatch(string param)() {
        string[] result;
        foreach(a; this.ArgV)if(a[0]=='-') {} else {};
    };
};
