module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output");
    import std.stdio:writeln;
    int[int] abc;
    abc[3]= 5;
    writeln(abc.keys);
    foreach(sourceFile; ah.compile)writeln(sourceFile);
    writeln("Hello vmdk.  ");
};
