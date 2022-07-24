module app.Assembler;
import templates.DevToolChain;

version(dbg_01){private enum dbg= 1;}else
version(dbg_02){private enum dbg= 2;}else
version(dbg_03){private enum dbg= 3;}else
version(dbg_04){private enum dbg= 4;}else
version(dbg_05){private enum dbg= 5;}else
{ private enum dbg= 0; }

public abstract class a0Assembler:DevToolChain {
    import d.util.BinFile;
    public uint limit= 400;
    public bool assemblingAProcedure= false;
    public bool eoas= false;   //   Tells the assembler that there's no more code to assemble.  
    public uint line;   //   Allow for switching between the assembler's methods.  
    public string fp;
    public string[] srcCode;
    // public string[] symbols;   //   The symbols will have to be passed to the binary file, potentially.  
    public BinFile binFile;
    public bool asmProcedureInstruction() {
        assert(limit-- > 0);
        string[] inst= this.nextInstSegs();
        switch(inst[0]) {
            case "param":
                log.param(inst[1]);
                return !this.eoas;
            default:
                log.unknownInst(inst[0]);
        };
        return !this.eoas;
    };
    public bool asmProcedure() {
        assert(limit > 0);
        string inst;
        while(asmProcedureInstruction())limit--;
        return true;
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
            if(dbg > 2)writeln("symbols= ",this.binFile.ff.symbols,";");
            return this.binFile.ff.symbols.dup;
        };
    //properties:
        public string currentInst() @property {
            return this.srcCode[this.line];
        };
        public string[] currentInstSegs() @property {
            string result= this.srcCode[this.line];
            uint i,j= cast(uint) result.length;
            while(i<j && result[i]==' ')i++;
            result= result[i..$];
            return result.split(" ");
        };
    //incremented-getters:
        public string nextInst() {
            assert(!this.eoas,"The assembler can't assemble non-existent code.  ");
            if(this.line>=this.srcCode.length)this.eoas= true;
            return this.srcCode[++this.line];
        };
        public string[] nextInstSegs() {
            assert(!this.eoas,"The assembler can't assemble non-existent code.  ");
            if(this.line>=this.srcCode.length)this.eoas= true;
            string result= this.srcCode[++this.line];
            uint i,j= cast(uint) result.length;
            while(i<j && result[i]==' ')i++;
            result= result[i..$];
            if(this.line>=this.srcCode.length)this.eoas= true;
            return result.split(" ");
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
            ""
        )if(instI<inst.length)instI++;
        if(inst.length<=instI)return true;
        string[] instSegs= inst[instI..$];
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
                if(instSegs.length > 2)this.asmProcedure();
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
            if(assembleInst())continue;
            if(!unimplementedInstructions.contains(this.currentInst))unimplementedInstructions ~= [this.currentInst];
        };
        if(unimplementedInstructions.length!=0)writeln("unimplementedInstructions= ",unimplementedInstructions,";");
        this.binFile= new BinFile(this.fp);
        return this;
    };
};
