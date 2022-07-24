module app.Assembler;

private enum devMode= false;

public class Assembler {
    import d.util.BinFile;
    public string fp;
    public string[] srcCode;
    // public string[] symbols;   //   The symbols will have to be passed to the binary file, potentially.  
    public BinFile binFile;
    public this(string filePath) {
        import std.array;
        import std.file:exists,read;
        import std.stdio:writeln;
        this.binFile= new BinFile(filePath);
        if(this.binFile is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile` is still null!  ");
        // if(this.binFile.ff is null)this.binFile.ff= new bf_ByteCode(new void[60000]);   //   Make sure `this.binFile.ff` is not null.  
        if(this.binFile.ff is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff` is still null!  ");
        if(this.binFile.ff.symbols is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff.symbols` is still null!  ");
        this.fp= filePath;
        if(!exists(this.fp)) {
            writeln("[Err] ",__MODULE__," @",__LINE__,":   Could not find file \"",this.fp,"\"");
            return;
        };
        this.srcCode= (cast(string) read(filePath)).split("\n");
    };
    public bool assembleInst(size_t line, string inst) {
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
        // writeln(this.binFile);
        if(this.binFile is null)
            this.binFile= new BinFile(this.fp);
        switch(instSegs[0]) {   //SearchIndex:   inst.elements;
            case "object":
                break;
            case "procedure":
                writeln("[Symbol] procedure `",instSegs[1],"`: ",line,";");
                this.binFile.newSymbol(instSegs[1]);
                break;
            case "start":
                binFile.start= instSegs[1];
                this.binFile.newSymbol(instSegs[1]);
                break;
            default:
                static if(devMode)writeln("unknown_inst=`",inst,"`;");
                unimplementedInstructions ~= [inst];
                return false;
        };
        return true;
    };
    public typeof(this) assemble() {
        import std;
        ubyte[] result= [];
        string[] unimplementedInstructions;
        foreach(i, inst; this.srcCode) {
            if((cast(size_t) inst[].ptr)==0)return this;   //   Avoid segmentaton.  
            if(assembleInst(i, inst))continue;
            if(unimplementedInstructions.indexOf(inst)==-1)unimplementedInstructions ~= [inst];
        };
        if(unimplementedInstructions.length!=0)writeln("unimplementedInstructions= ",unimplementedInstructions,";");
        this.binFile= new BinFile(this.fp);
        return this;
    };
    //getters:
        import std.stdio:writeln;
        public void[] data() @property @trusted {
            assert(this.binFile !is null, "`this.binFile` can not be null.  ");
            void[] result= this.binFile.data;   //   Data is is generated and can't be directly overridden.  
            return result;   //   Data is is generated and can't be directly overridden.  
        };
        public string[] symbols() @property {
            if(this.binFile is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile` shouldn't be null.  ");
            if(this.binFile.ff is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff` shouldn't be null.  ");
            if(this.binFile.ff.symbols is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff.symbols` shouldn't be null.  ");
            writeln("symbols= ",this.binFile.ff.symbols,";");
            return this.binFile.ff.symbols.dup;
        };
};
