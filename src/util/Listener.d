module util.Listener;
import util.Path;

public interface Listener { };

public interface IOListener:Listener { };

public interface FSysListener:IOListener { };

public interface PathListener:FSysListener {
    public string preInit(string val);    //   Run code on the file-path during initialization before `util.Path` or `util.File` connects to the file.
    public string postInit(string val);   //   Run code on the file-path during initialization after `util.Path` or `util.File` connects to the file.
};

public class FileListener:FSysListener {
    public static FileListener[] globalListeners= [];
    public Path preInit(Path val);           //   Run code on the file-path during initialization before `util.Path` or `util.File` connects to the file.
    public Path postInit(Path val);          //   Run code on the file-path during initialization after `util.Path` or `util.File` connects to the file.
    public void[] onAppend(void[] data);
    public void[] onRead(void[] data);
    public void[] onWrite(void[] data);
};
