module templates.AppInit;

public abstract class AppInit {
    private import core.stdc.stdlib;
    private import std.stdio;
    public static void exit(int statusCode) {
        writeln("App exited with status code ",statusCode,".  ");
        _Exit(statusCode);
    };
    public static string option;
};
