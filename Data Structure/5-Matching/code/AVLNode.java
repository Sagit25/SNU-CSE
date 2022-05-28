// Implement AVL Tree Node
// Modified from Lecture Note

public class AVLNode <K extends Comparable<K>, P extends Comparable<P>> {
    public K node;
    public int height;
    public MyLinkedList <P> item;
    public AVLNode <K, P> leftChild, rightChild;

    public AVLNode(K node, MyLinkedList <P> item) {
        this.node = node;
        this.item = item;
        leftChild = rightChild = AVLTree.NIL;
        height = 1;
    }

    public AVLNode(K node, MyLinkedList <P> item, AVLNode <K, P> left, AVLNode <K, P> right, int height) {
        this.node = node;
        this.item = item;
        this.leftChild = left;
        this.rightChild = right;
        this.height = height;
    }

    public void insert(P child) {
        item.add(child);
    }

    public MyLinkedList <P> search(K key) {
        int cmp = node.compareTo(key);
        if (cmp > 0) {
            if (leftChild == null) {
                return null;
            }
            return leftChild.search(key);
        }
        else if (cmp == 0) {
            return item;
        }
        else {
            if (rightChild == null) {
                return null;
            }
            return rightChild.search(key);
        }
    }

}