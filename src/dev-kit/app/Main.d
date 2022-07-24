module app.Main;
import d.proc.command:ArgHandler;
import templates.DevToolChain;

public class Main:DevToolChain {
    public static void main(string[] ArgV) {
        ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
        import app.Assembler;
        Assembler assembly;
        foreach(sourceFile; ah.getParam("compile")) {
            assembly= new Assembler(sourceFile);
            log3.info(assembly.assemble().data);
            version(dbg_00)writeln("defined symbols= ",assembly.symbols,";");
        };
        start0();
        log.info(ah.getParam("compile"));
        stop0();
        log.info(ah.getParam("args"));
        log.info("Hello vmdk.  ");
    };
};

void main(string[] ArgV) {
    Main.main(ArgV);
};
