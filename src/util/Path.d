module util.Path;

import std.file:_exists=exists;
import util.File;
public import util.Listener:PathListener;

public class Path {
    private static PathListener[] globalListeners= [];
    private PathListener[] localListeners= [];
    public string fp;
    public this(string filePath) {
        foreach(i, listener; this.globalListeners) filePath= listener.preInit(filePath);
        foreach(i, listener; this.localListeners) filePath= listener.preInit(filePath);
        this.fp= filePath;
        foreach(i, listener; this.localListeners) filePath= listener.postInit(filePath);
        foreach(i, listener; this.globalListeners) filePath= listener.postInit(filePath);
    };
    public bool exists(Path filePath) @property { return _exists(this.fp); };
    public File file() @property { return new File(this); };
};
