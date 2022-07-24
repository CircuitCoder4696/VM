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
            log.info(3, assembly.assemble().data);
            version(dbg_00)writeln("defined symbols= ",assembly.symbols,";");
        };
        start0();
        log.info(0, ah.getParam("compile"));
        stop0();
        log.info(0, ah.getParam("args"));
        log.info(0, "Hello vmdk.  ");
    };
};

void main(string[] ArgV) {
    Main.main(ArgV);
};
