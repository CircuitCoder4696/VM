module app.Main;
import d.io.commands:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler.ArgV= ArgV;
    import std.stdio:writeln;
    writeln("Hello vmdk.  ");
};
