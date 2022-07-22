module app.VM;
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
    public static VM[totalThreadsPerProcess] threads;
    private static size_t threadI;
	public static bool run= true;
	public static bool allowFullIO= false;
	public static bool allowNativeExt= true;
	public Proc proc= Proc();
	public static ulong limit= 400;
	public static void function(Proc)[256] vm,vm_ff;
	private static void f_00(Proc) {};
    private static void f_ff(Proc) {};
	private void f_ff_00(Proc) {};
	static this() {
		this.vm[0x00]= &f_00;
		this.vm[0xff]= &f_ff;
		this.vm_ff[0x00]= &f_ff_00;
	};
	public void newThread(ubyte[] mem) {
        size_t j= this.threadI;
        foreach(i; 0 .. (totalThreadsPerProcess +1)) {
            if((cast(size_t)this.threads[(i + j)%totalThreadsPerProcess])==0)break;
            if(i==totalThreadsPerProcess) {
                writeln("All thread-slots are taken.  ");
                return;
            };
        };
        VM result= new VM();
        this.threads[this.threadI%totalThreadsPerProcess]= result;
        result.proc= Proc(0,0,0,0, 0,0, 0, 0, 0, 0, cast(void[]) men);
    };
    public void runInst() {
        if(this.running) {
            if((cast(size_t)this.vm[cast(ubyte)this.proc.mem[this.proc.ip++]])==0)
            this.vm[cast(ubyte)this.proc.mem[this.proc.ip++]](this.proc);
            return;
        };
        return;
    };
};
