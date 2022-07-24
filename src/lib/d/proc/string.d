module d.proc.string;

public bool contains(string[] self, string query) {
    foreach(v; self)if(v==query)return true;
    return false;
};
