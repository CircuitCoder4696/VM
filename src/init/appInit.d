module _vm_main;
import templates.DevToolChain;

void main(string[] ArgV) {
    Logger log;
    import app.Main;
    auto main= new Main();
    main.ArgV= ArgV;
    while(main.ArgI < main.ArgV.length) {
        main.init(main.getNextArg());
        main.next= false;
    };
    main.main(main.params);
};
