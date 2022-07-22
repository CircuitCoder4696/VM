module _vm_main;
import templates.DevToolChain;

void main(string[] ArgV) {
    DevToolChain_DbgMessage log;
    import app.Main;
    auto main= new Main();
    main.ArgV= ArgV;
    while(main.next) {
        main.main();
        main.next= false;
    };
};
