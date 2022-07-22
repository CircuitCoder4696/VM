module app.VM;

public struct Proc {
  ulong r0,r1,r2,r3,cp,dp,fr,kr;
  public ubyte[] mem;
};

public class VM {
	public static bool run= true;
	public static bool allowFullIO= false;
	public static bool allowNativeExt= true;
	public static Proc proc= Proc();
	public static ulong limit= 400;
	public static void function()[256] vm,vm_ff;
	private static void f_00() {};
	private void f_ff_00() {
    // this.proc.mem += Proc();
  };
	static this() {
		this.vm[0x00]= &f_00;
		this.vm[0xff]= &f_ff;
		this.vm_ff[x00]= &f_ff_00;
	};
	public this(ubyte[] mem) {
    this.proc.mem= mem;
  };
};
