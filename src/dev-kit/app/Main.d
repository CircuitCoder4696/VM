module app.Main;
import d.proc.command:ArgHandler;
import templates.DevToolChain;
import templates.AppInit;

public class Main:AppInit {
    public void main(string[string] initData) {
        log.info(initData);
    };
};
