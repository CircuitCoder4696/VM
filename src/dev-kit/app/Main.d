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
            start0();
            log5.info(assembly.assemble().data);
            stop0();
            log4.info("defined symbols= ",assembly.symbols,";");
        };
        // log.info(0, ah.getParam("compile"));
        // log.info(0, ah.getParam("args"));
        log.info("Hello vmdk.  ");
    };
};

void main(string[] ArgV) {
    Main.main(ArgV);
};
