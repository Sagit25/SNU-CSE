// Modified from HW2.MyLinkedList.java

import java.util.Iterator;
import java.util.NoSuchElementException;

public class MyLinkedList<T extends Comparable<T>> implements ListInterface<T> {
    // dummy head
    Node<T> head;
    int numItems;

    public MyLinkedList() {
        this.head = new Node<T>(null, null);
        this.numItems = 0;
    }

    public final Iterator<T> iterator() {
        return new MyLinkedListIterator<T>(this);
    }

    @Override
    public boolean isEmpty() {
        return head.getNext() == null;
    }

    @Override
    public int size() {
        return numItems;
    }

    @Override
    public T first() {
        return head.getNext().getItem();
    }

    @Override
    public void add(T item) {
        Node<T> last = head;
        Node<T> past = head;
        if (numItems != 0) {
            last = last.getNext();
            while (last != null) {
                past = last;
                last = last.getNext();
            }
        }
        past.insertNext(item);
        numItems++;
    }

    public void delete(T item) {
        Node<T> last = head;
        if (numItems == 0) {
            return;
        }
        last = last.getNext();
        Node<T> past = head;
        while ((last != null) && (!last.item.equals(item))) {
            past = last;
            last = last.getNext();
        }
        if (past.getNext() != null) {
            past.removeNext();
            numItems--;
        }
    }

    @Override
    public void removeAll() {
        head.setNext(null);
    }
}

class MyLinkedListIterator<T extends Comparable<T>> implements Iterator<T> {
    public MyLinkedList<T> list;
    public Node<T> curr;
    public Node<T> prev;

    public MyLinkedListIterator(MyLinkedList<T> list) {
        this.list = list;
        this.curr = list.head;
        this.prev = null;
    }

    @Override
    public boolean hasNext() {
        return curr.getNext() != null;
    }

    @Override
    public T next() {
        if (!hasNext())
            throw new NoSuchElementException();

        prev = curr;
        curr = curr.getNext();

        return curr.getItem();
    }

    @Override
    public void remove() {
        if (prev == null)
            throw new IllegalStateException("next() should be called first");
        if (curr == null)
            throw new NoSuchElementException();
        prev.removeNext();
        list.numItems -= 1;
        curr = prev;
        prev = null;
    }
}