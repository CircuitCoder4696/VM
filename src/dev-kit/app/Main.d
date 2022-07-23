module app.Main;
import d.proc.command:ArgHandler;

public void main(string[] ArgV) {
    ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
    import std.stdio:writeln;
    int[int] abc;
    abc[3]= 5;
    writeln(abc.keys);
    Assembler asm= new Assembler();
    foreach(sourceFile; ah.getParam("compile"))writeln(asm.assemble(sourceFile).data);
    writeln(ah.getParam("compile"));
    writeln(ah.getParam("args"));
    writeln("Hello vmdk.  ");
};
