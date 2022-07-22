module _vm_main;

void main(string[] ArgV) {
    import app.Main;
    auto main= new Main();
    main.ArgV= ArgV;
    main.main();
};
