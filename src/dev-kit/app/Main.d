module app.Main;
import d.io.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output");
    import std.stdio:writeln;
    foreach(sourceFile; ah.compile)writeln(sourceFile);
    writeln("Hello vmdk.  ");
};
