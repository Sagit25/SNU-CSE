// Implement AVL Tree
// Modified from Lecture Note

public class AVLTree <K extends Comparable<K>, P extends Comparable<P>> {
    public AVLNode <K, P> root;
    public int numItems;
    static final AVLNode NIL = new AVLNode (null, null, null, null, 0);

    public AVLTree() {
        root = NIL;
        numItems = 0;
    }

    // Search Part

    public MyLinkedList <P> search(K key) {
        AVLNode <K, P> find = searchItem (this.root, key);
        return find.item;
    }

    private AVLNode <K, P> searchItem(AVLNode <K, P> tNode, K key) {
        if (tNode == NIL) return NIL;
        if (key.compareTo(tNode.node) == 0) return tNode;
        if (key.compareTo(tNode.node) < 0) return searchItem(tNode.leftChild, key);
        return searchItem(tNode.rightChild, key);
    }

    // Insert Part

    public void insert(K key, P child) {
        this.root = insertItem(root, key, child);
        numItems++;
    }

    private AVLNode <K, P> insertItem (AVLNode <K, P> tNode, K key, P child) {
        int type;
        if (tNode == NIL) {
            tNode = new AVLNode <K, P> (key, new MyLinkedList<P>());
            tNode.insert(child);
        }
        else if (key.compareTo(tNode.node) < 0) { // left branch
            tNode.leftChild = insertItem(tNode.leftChild, key, child);
            tNode.height = 1 + Math.max(tNode.leftChild.height, tNode.rightChild.height);
            type = needBalance(tNode);
            if (type != NO_NEED) tNode = balanceAVL(tNode, type);
        }
        else if (key.compareTo(tNode.node) > 0) { // right branch
            tNode.rightChild = insertItem(tNode.rightChild, key, child);
            tNode.height = 1 + Math.max(tNode.leftChild.height, tNode.rightChild.height);
            type = needBalance(tNode);
            if (type != NO_NEED) tNode = balanceAVL(tNode, type);
        }
        else { // Same Node
            tNode.insert(child);
        }
        return tNode;
    }

    // Balancing Part

    private final int LL = 1, LR = 2, RR = 3, RL = 4, NO_NEED = 0, ILLEGAL = -1;
    private int needBalance(AVLNode <K, P> t) {
        int type = ILLEGAL;
        if (t.leftChild.height + 2 <= t.rightChild.height) { // type R
            if (t.rightChild.leftChild.height <= t.rightChild.rightChild.height) {
                type = RR;
            }
            else {
                type = RL;
            }
        }
        else if (t.leftChild.height >= t.rightChild.height + 2) { // type L
            if (t.leftChild.leftChild.height >= t.leftChild.rightChild.height) {
                type = LL;
            }
            else {
                type = LR;
            }
        }
        else {
            type = NO_NEED;
        }
        return type;
    }

    private AVLNode <K, P> balanceAVL(AVLNode <K, P> tNode, int type) {
        AVLNode<K, P> returnNode = NIL;
        switch(type) {
            case LL:
                returnNode = rightRotate(tNode);
                break;
            case LR:
                tNode.leftChild = leftRotate(tNode.leftChild);
                returnNode = rightRotate(tNode);
                break;
            case RR:
                returnNode = leftRotate(tNode);
                break;
            case RL:
                tNode.rightChild = rightRotate(tNode.rightChild);
                returnNode = leftRotate(tNode);
                break;
            default:
                System.out.println("impossible type!");
                break;
        }
        return returnNode;
    }

    private AVLNode <K, P> leftRotate(AVLNode <K, P> t) {
        AVLNode<K, P> RChild = t.rightChild;
        if (RChild == NIL) {
            System.out.println("t's RChild shouldn't be NIL!");
        }
        else {
            AVLNode<K, P> RLChild = RChild.leftChild;
            RChild.leftChild = t;
            t.rightChild = RLChild;
            t.height = 1 + Math.max(t.leftChild.height, t.rightChild.height);
            RChild.height = 1 + Math.max(RChild.leftChild.height, RChild.rightChild.height);
        }
        return RChild;
    }

    private AVLNode <K, P> rightRotate(AVLNode <K, P> t) {
        AVLNode<K, P> LChild = t.leftChild;
        if (LChild == NIL) {
            System.out.println("t's LChild shouldn't be NIL!");
        }
        else {
            AVLNode<K, P> LRChild = LChild.rightChild;
            LChild.rightChild = t;
            t.leftChild = LRChild;
            t.height = 1 + Math.max(t.leftChild.height, t.rightChild.height);
            LChild.height = 1 + Math.max(LChild.leftChild.height, LChild.rightChild.height);
        }
        return LChild;
    }
}
