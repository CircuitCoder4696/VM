module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
    import std.stdio:writeln;
    int[int] abc;
    abc[3]= 5;
    writeln(abc.keys);
    // foreach(sourceFile; ah.compile)writeln(sourceFile);
    writeln(ah.getParam("compile"));
    writeln(ah.getParam("args"));
    writeln("Hello vmdk.  ");
};
