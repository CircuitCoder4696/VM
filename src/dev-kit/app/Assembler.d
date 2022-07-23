module app.Assembler;

public class Assembler {
    public string fp;
    public string[] srcCode;
    public void[] data;
    public this(string filePath) {
        import std.array;
        import std.file:exists,read;
        import std.stdio:writeln;
        this.fp= filePath;
        if(!exists(this.fp)) {
            writeln("[Err] ",__MODULE__," @",__LINE__,":   Could not find file \"",this.fp,"\"");
            return;
        };
        this.srcCode= (cast(string) read(filePath)).split("\n");
    };
    public typeof(this) assemble() {
        import std;
        ubyte[] result= [];
        foreach(inst; this.srcCode)switch(inst) {
            default: writeln("Unknown instruction:   ",inst);
        };
        this.data= cast(void[]) result;
        return this;
    };
};
