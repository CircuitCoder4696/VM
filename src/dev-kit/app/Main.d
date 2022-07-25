module app.Main;
import d.proc.command:ArgHandler;
import templates.DevToolChain;

public class Main:DevToolChain {
    public static void main(string[] ArgV) {
        ArgHandler ah= new ArgHandler(ArgV, "c:compile", "o:output", "args:args");
        import app.Assembler;
        Assembler assembly;
        foreach(sourceFile; ah.getParam("compile")) {
            start0();
            assembly= new Assembler(sourceFile);
            log.info(5, assembly.assemble().data);
            log.info(4, "defined symbols= ",assembly.symbols,";");
            stop0();
        };
        log.info(0, ah.getParam("compile"));
        log.info(0, ah.getParam("args"));
        log.info(0, "Hello vmdk.  ");
    };
};

void main(string[] ArgV) {
    Main.main(ArgV);
};
