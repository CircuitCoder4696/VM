module templates.AppInit;
import templates.DevToolChain;
import d.reflection;

public abstract class AppInit:DevToolChain {
    private import core.stdc.stdlib;
    private import std.stdio;
    protected static string[][string] params;
    public static void exit(int statusCode) {
        _Exit(statusCode);
    };
    public string option= "";
    public int ArgI= 1;   //   It doesn't need to provide the host application's name as a command-line argument.  
    public string[] ArgV;
    public string getNextArg() {
        if(this.ArgI >= this.ArgV.length)return null;
        return this.ArgV[this.ArgI++];
    };
};
