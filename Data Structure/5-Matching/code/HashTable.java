public class HashTable <K extends Comparable<K>, V extends Comparable<V>> {
    static final int maxTableSize = 100;
    public AVLTree <K, V> [] table;

    public HashTable() {
        table = new AVLTree [maxTableSize];
    }

    public void insert(K key, V val) {
        int idx = key.hashCode() % maxTableSize;
        if (table[idx] == null) {
            table[idx] = new AVLTree <K, V> ();
        }
        table[idx].insert(key, val);
    }

    public MyLinkedList <V> search(K key) {
        int idx = key.hashCode() % maxTableSize;
        if (table[idx] == null) {
            return null;
        }
        return table[idx].search(key);
    }
}
