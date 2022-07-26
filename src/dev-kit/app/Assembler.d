module app.Assembler;
import templates.DevToolChain;

public abstract class a0Assembler:DevToolChain {
    import d.util.BinFile;
    import std.array;
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
        if(inst.length <= 0)return !this.eoas;
        switch(inst[0]) {
            case "param":
                log.param(5, inst[1]);
                return !this.eoas;
            default:
                log1.warn("Could not find `",inst,"`.  ");
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
            void[] result= this.binFile.data;   //   Data is generated and can't be directly overridden.  
            return result;   //   Data is is generated and can't be directly overridden.  
        };
        public string[] symbols() @property {
            if(this.binFile is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile` shouldn't be null.  ");
            if(this.binFile.ff is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff` shouldn't be null.  ");
            if(this.binFile.ff.symbols is null)writeln("[Err] ",__MODULE__," @",__LINE__,":   `this.binFile.ff.symbols` shouldn't be null.  ");
            log5.info("symbols= ",this.binFile.ff.symbols,";");
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
            if(this.srcCode.length <= this.line)return null;
            string result= this.srcCode[++this.line];
            uint i,j= cast(uint) result.length;
            while(i<j && result[i]==' ')i++;
            result= result[i..$];
            if((this.line +1)>=this.srcCode.length)this.eoas= true;
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
        start2();
        log1.dbg(instSegs[0]);
        switch(instSegs[0]) {   //SearchIndex:   inst.elements;
            case "object":
                this.binFile.setObjPath(instSegs[1]);
                break;
            case "procedure":
                log.info(1, "[Symbol] procedure `",this.binFile.objPath,"->",instSegs[1],"`: ",line,";");
                this.binFile.newSymbol(this.binFile.objPath~"->"~instSegs[1], cast(uint) line);
                if(instSegs.length > 2)this.asmProcedure();
                break;
            case "start":
                binFile.start= instSegs[1];
                this.binFile.newSymbol(instSegs[1]);
                break;
            default:
                log.info(1, "unknown_inst=`",inst,"`;");
                return false;
        };
        stop2();
        return true;
    };
    public typeof(this) assemble() {
        import d.proc.string;
        import std;
        ubyte[] result= [];
        string[] unimplementedInstructions;
        while(!this.eoas) {
            start1();
            if(assembleInst())continue;
            stop1();
            if(!unimplementedInstructions.contains(this.currentInst)) {
                unimplementedInstructions ~= [this.currentInst];
            };
        };
        this.binFile= new BinFile(this.fp);
        return this;
    };
};
