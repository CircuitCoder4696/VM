module _vm_main;

void main(string[] ArgV) {
    import app.Main;
    import std.stdio;
    import std.variant:var=Variant;
    auto main= new Main();
    main.ArgV= ArgV;
    main.main();
};
