module app.VM;

public class VM {
    private alias func= void function(void*);
    private static uint i= 0;
    private static void delegate(void* ctx)[] instructionSet;
    public static uint setInst(
        funcrion
        void
        (
            void*
            ctx
        )
        inst,
    ) {
        uint result= this.i++;
        this.instructionSet ~= inst;
        return result;
    };
    public static __callOne(size_t ip, uint[] code) {
        this.inst[code[ip]]();
    };
    public static void x_00000000(void*) {
        writeln("Hello world.  ");
    };
    static this() {
        VM.set(&x_00000000);
    };
};
