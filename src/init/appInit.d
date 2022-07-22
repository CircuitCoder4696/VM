module _vm_main;
import templates.DevToolChain;

void main(string[] ArgV) {
    DevToolChain_DbgMessage log;
    import application.Main;
    auto main= new Main();
    main.ArgV= ArgV;
    while(main.ArgI < main.ArgV.length) {
        main.main(main.getNextArg());
        main.next= false;
    };
    import std;
    writeln(main.params);
};
