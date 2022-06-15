// Modified this code from HW2

import java.util.Iterator;
import java.util.NoSuchElementException;

public class MyLinkedList<T extends Comparable<T>> {
	Node<T> head;
	int numItems;

	public MyLinkedList() {
		head = new Node<T>(null);
	}

    public final Iterator<T> iterator() {
		return new MyLinkedListIterator<T>(this);
    }

	public boolean isEmpty() {
		return head.getNext() == null;
	}

	public int size() {
		return numItems;
	}

	public T first() {
		return head.getNext().getItem();
	}

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

	public void removeAll() {
		head.setNext(null);
	}
}

class MyLinkedListIterator<T extends Comparable<T>> implements Iterator<T> {
	private MyLinkedList<T> list;
	private Node<T> curr;
	private Node<T> prev;

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