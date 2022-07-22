module templates.AppInit;

public abstract class AppInit {
    private import core.stdc.stdlib;
    private import std.stdio;
    protected static string[][string] params;
    public static void exit(int statusCode) {
        _Exit(statusCode);
    };
    public string option= "";
    public int ArgI;
    public string[] ArgV;
};
