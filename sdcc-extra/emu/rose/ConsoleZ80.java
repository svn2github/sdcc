import java.awt.*;
import java.util.*;
import java.io.*;
import java.net.*;

/** Implements a Z80 with 64k RAM and a write-only console at IO port 0.
    @author Michael Hope <michaelh@juju.net.nz> 2001
    @see Z80
*/
public class ConsoleZ80 
    extends Z80 
    implements Runnable 
{
    String romImageName = null;

    boolean isWatched[];

    public ConsoleZ80(String _romImageName) {
	super(4.0, 1);
	romImageName = _romImageName;
	isWatched = new boolean[65536];
    }
    
    public ConsoleZ80() {
	this(null);
    }

    public void setImageName(String name) {
	romImageName = name;
    }
    
    /** Byte access */
    public int peekb( int addr ) {
        //        System.out.println("Read from " + addr + " of " + mem[addr]);
	return mem[ addr ];
    }

    public void pokeb( int addr, int newByte ) {
	if (isWatched[addr]) {
	    System.out.println("watch: write to 0x" + Integer.toString(addr, 16) + " at pc 0x" + Integer.toString(PC(), 16));
	}
	mem[ addr ] = newByte;
    }

    public int inb( int port ) {
	return 0xff;
    }

    public void outb( int port, int outByte, int tstates ) {
	switch (port) {
	case 0xFF:
	    System.out.write(outByte);
	    System.out.flush();
	    break;
	case 1:
	    switch (outByte) {
	    case 0:
		System.exit(0);
		break;
	    }
	}
    }

    public void loadROM( String name, InputStream is ) throws Exception {
	readBytes(is, mem, 32768);
    }

    int rst(int num) {
        if (num == 8) {
            switch (A()) {
            case 0:
                System.exit(0);
                break;
            case 1:
                System.out.write(L());
                System.out.flush();
                break;
            default:
                // Drop.
            }
            return 0;
        }
        else {
            return super.rst(num);
        }
    }

    private int readBytes( InputStream is, int a[], int n ) throws Exception {
	try {
	    byte buff[] = new byte[ n ];
	    int toRead = n;
	    while ( toRead > 0 ) {
		int nRead = is.read(buff, n-toRead, toRead);
		toRead -= nRead;
	    }
	    for ( int i = 0; i < n; i++ ) {
		a[i] = (buff[i]+256)&0xff;
	    }

	    return n;
	}
	catch ( Exception e ) {
	    return -1;
	}
    }

    /** Start the applet creating a new thread which invokes run(). */
    public void start() throws Exception {
	Thread thread = new Thread(this, "ConsoleZ80");
	thread.start();
    }
    
    /** Read applet parameters and start the Rex. */
    public void run() {
	try {
	    FileInputStream rom = new FileInputStream(romImageName);
	    loadROM(romImageName, rom);
	    rom.close();
	    reset();
	    execute();
	} catch (Exception e) { 
	    System.out.println("readParameters: " +e.toString());
	}
    }

    public void addWatch(String addr) {
	try {
	    isWatched[Integer.valueOf(addr).intValue()] = true;
	} catch (NumberFormatException ignored) {};
    }

    public static void main(String[] args) throws Exception {
	boolean setImage = false;
	ConsoleZ80 z80 = new ConsoleZ80();

	for (int i=0; i<args.length; i++) {
	    if (args[i].equals("-w")) {
		z80.addWatch(args[++i]);
	    }
	    else if (args[i].equals("-h")) {
		System.out.println("Usage: java ConsoleZ80 [romimage]");
		System.exit(0);
	    }
	    else {
		z80.setImageName(args[i]);
		setImage = true;
	    }
	}
	if (!setImage) {
	    z80.setImageName("test.gb");
	}
	z80.start();
    }

}
