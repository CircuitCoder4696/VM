module app.VM;
import d.util.bits;
private enum totalThreadsPerProcess= 64;

public struct Proc {
    ulong r0,r1,r2,r3;
    ulong cp;   //   Call pointer.  
    ulong dp;   //   Data pointer.  
    ulong fr;   //   Flag register.  
    ulong kr;   //   Kern-register.  
    ulong ip;   //   Instruction pointer.  
    ulong rp;   //   Result pointer.  
    void[] mem;
};

public class VM {
    public import std.stdio:writeln;
    public static VM[totalThreadsPerProcess] threads;
    private static size_t threadI;
	public static bool run= true;
	public static bool allowFullIO= false;
	public static bool allowNativeExt= true;
    public bool running= true;
	public Proc proc= Proc();
	public static ulong limit= 400;
	public static void function(Proc)[256] vm,vm_ff;
    public static BitField!256 bf,bf_ff;
	private static void f_00(Proc) {};
    private static void f_ff(Proc proc) {
        ubyte opcode= (cast(ubyte[]) proc.mem)[proc.ip++];
        if(!VM.bf[opcode])return;
        vm[opcode](proc);
        return;
    };
	private static void f_ff_00(Proc proc) {
        VM.____newThread(proc.mem);
    };
	static this() {
		this.vm[0x00]= &f_00;
        this.bf[0x00]= true;
		this.vm[0xff]= &f_ff;
		this.bf[0xff]= true;
		this.vm_ff[0x00]= &f_ff_00;
		this.bf_ff[0x00]= true;
	};
	public static void ____newThread(void[] mem) {
        size_t j= this.threadI;
        foreach(i; 0 .. (totalThreadsPerProcess +1)) {
            if(
                (cast(size_t)
                 &this.threads[(i + j)%totalThreadsPerProcess]
                )
                ==0)break;
            if(i==totalThreadsPerProcess) {
                writeln("All thread-slots are taken.  ");
                return;
            };
        };
        VM result= new VM();
        this.threads[this.threadI%totalThreadsPerProcess]= result;
        result.proc= Proc(0,0,0,0, 0,0, 0, 0, 0, 0, cast(void[]) mem);
    };
    public int ____runOneInst() {
        if(this.proc.mem.length <= this.proc.ip)return 1;
        ubyte opcode= (cast(ubyte[])this.proc.mem)[this.proc.ip++];
        if(this.running) {
            if(!this.bf[opcode])return 2;
            this.vm[opcode](this.proc);
            return 0;
        };
        return 0;
    };
};
