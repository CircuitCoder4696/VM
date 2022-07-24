module app.Assembler;

version(dbg_01){private enum dbg= 1;}else
version(dbg_02){private enum dbg= 2;}else
version(dbg_03){private enum dbg= 3;}else
version(dbg_04){private enum dbg= 4;}else
version(dbg_05){private enum dbg= 5;}else
{ private enum dbg= 0; }

public abstract class a0Assembler {
    import d.util.BinFile;
    public bool assemblingAProcedure= false;
    public bool eoas= false;   //   Tells the assembler that there's no more code to assemble.  
    public uint line;   //   Allow for switching between the assembler's methods.  
    public string fp;
    public string[] srcCode;
    // public string[] symbols;   //   The symbols will have to be passed to the binary file, potentially.  
    public BinFile binFile;
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
            if(dbg > 2)writeln("symbols= ",this.binFile.ff.symbols,";");
            return this.binFile.ff.symbols.dup;
        };
    //incremented-getters:
        public string nextInst() {
            assert(!this.eoas,"The assembler can't assemble non-existent code.  ");
            return this.srcCode[this.line++];
        };
};

public class Assembler:a0Assembler {
    import d.util.BinFile;
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
    public bool assembleInst() {
        import std.array;
        import std.stdio:writeln;
        string[] inst= this.nextInst().split(" ");
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
                this.binFile.setObjPath(instSegs[1]);
                break;
            case "procedure":
                if(dbg > 1)writeln("[Symbol] procedure `",this.binFile.objPath,"->",instSegs[1],"`: ",line,";");
                this.binFile.newSymbol(this.binFile.objPath~"->"~instSegs[1], cast(uint) line);
                if(instSegs.length > 2)this.binFile.asmProcedure(instSegs);
                break;
            case "start":
                binFile.start= instSegs[1];
                this.binFile.newSymbol(instSegs[1]);
                break;
            default:
                static if(dbg > 1)writeln("unknown_inst=`",inst,"`;");
                return false;
        };
        return true;
    };
    public typeof(this) assemble() {
        import d.proc.string;
        import std;
        ubyte[] result= [];
        string[] unimplementedInstructions;
        while(!this.eoas) {
            if((cast(size_t) inst[].ptr)==0)return this;   //   Avoid segmentaton faults.  
            if(assembleInst(i, inst))continue;
            if(unimplementedInstructions.contains(inst))unimplementedInstructions ~= [inst];
        };
        if(unimplementedInstructions.length!=0)writeln("unimplementedInstructions= ",unimplementedInstructions,";");
        this.binFile= new BinFile(this.fp);
        return this;
    };
};
