module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
    import app.Assembler;
    import std.stdio:writeln;
    Assembler assembly;
    foreach(sourceFile; ah.getParam("compile")) {
        assembly= new Assembler(sourceFile);
        version(dbg_03)writeln(assembly.assemble().data);
        version(dbg_00)writeln("defined symbols= ",assembly.symbols,";");
    };
    writeln("/----- (0)");
    version(dbg_00)writeln(ah.getParam("compile"));
    writeln("\\----- (0)");
    version(dbg_00)writeln(ah.getParam("args"));
    version(dbg_00)writeln("Hello vmdk.  ");
};
