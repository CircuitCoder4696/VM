module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
    import app.Assembler;
    import std.stdio:writeln;
    int[int] abc;
    abc[3]= 5;
    writeln(abc.keys);
    Assembler assembly;
    foreach(sourceFile; ah.getParam("compile")) {
        assembly= new Assembler(sourceFile);
        writeln(assembly.assemble().data);
    };
    writeln(ah.getParam("compile"));
    writeln(ah.getParam("args"));
    writeln("Hello vmdk.  ");
};
