module _vm_main;
import templates.DevToolChain;

void main(string[] ArgV) {
    DevToolChain_DbgMessage log;
    import application.Main;
    auto main= new Main();
    main.ArgV= ArgV;
    while(main.ArgI < main.ArgV.length) {
        main.init(main.getNextArg());
        main.next= false;
    };
    main.main(main.params);
    import std;
    writeln(main.params);
};
