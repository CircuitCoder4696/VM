module app.Assembler;

public class Assembler {
    import d.util.BinFile;
    public string fp;
    public string[] srcCode;
    public BinFile!(bf_ByteCode) binFile;
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
    public bool assembleInst(string inst) {
        import std.array;
        import std.stdio:writeln;
        int instI= 0;
        if(inst.length==0)return false;
        while(
            inst[instI]
            ==
            0x20
        )if(instI<inst.length)instI++;
        if(inst.length<=instI)return true;
        string[] instSegs= inst[instI..$].split(" ");
        switch(instSegs[0]) {
            case "object":
                writeln("object path: ",(inst[(instI +7)..$]),";");
                break;
            case "start":
                binFile.start= instSegs[1];
            default:return false;
        };
        return true;
    };
    public typeof(this) assemble() {
        import std;
        ubyte[] result= [];
        foreach(inst; this.srcCode) {
            writeln("/----- (1)");
            if((cast(size_t) inst[].ptr)==0)return this;   //   Avoid segmentaton.  
            if(assembleInst(inst))continue;
            writeln("\\----- (1)");
            writeln("Unknown instruction:   ",inst);
        };
        this.binFile= new BinFile!bf_ByteCode(this.fp);
        return this;
    };
    //getters:
        public void[] data() @property @trusted {
            return this.binFile.ff.data.dup;   //   Data is duped to avoid the data being overridden, by code outside of the assembler itself.  
        };
};
