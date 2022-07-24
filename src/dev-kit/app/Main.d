module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
    import app.Assembler;
    import std.stdio:writeln;
    Assembler assembly;
    foreach(sourceFile; ah.getParam("compile")) {
        assembly= new Assembler(sourceFile);
        writeln(assembly.assemble().data);
        writeln("defined symbols= ",assembly.symbols,";");
    };
    writeln(ah.getParam("compile"));
    writeln(ah.getParam("args"));
    writeln("Hello vmdk.  ");
};
