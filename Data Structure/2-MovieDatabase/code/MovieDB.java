import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * Genre, Title 을 관리하는 영화 데이터베이스.
 * 
 * MyLinkedList 를 사용해 각각 Genre와 Title에 따라 내부적으로 정렬된 상태를  
 * 유지하는 데이터베이스이다. 
 */
public class MovieDB {
	public MyLinkedList<Genre> genreList;

    public MovieDB() {
    	genreList = new MyLinkedList<Genre>();
    }

    public void insert(MovieDBItem item) {
		int flag = 0;
		Genre find = new Genre(item.genre);
		for (Genre now : genreList) {
			if (now.getItem().equals(find.getItem())) {
				for (MovieDBItem check : now.titleList) {
					if(check.equals(item)) return;
				}
				now.titleList.add(item);
				flag = 1;
			}
		}
		if (flag == 0) {
			genreList.add(find);
			this.insert(item);
		}
    }

    public void delete(MovieDBItem item) {
		Genre find = new Genre(item.getGenre());
		for (Genre check : genreList) {
			if(check.equals(find)) {
				check.titleList.delete(item);
				if (check.titleList.size() == 0) {
					genreList.delete(find);
				}
				break;
			}
		}
    }

    public MyLinkedList<MovieDBItem> search(String term) {
        MyLinkedList<MovieDBItem> results = new MyLinkedList<MovieDBItem>();
		for (Genre list : genreList) {
			for (MovieDBItem item : list.titleList) {
				if (item.getTitle().contains(term)) {
					results.add(item);
				}
			}
		}
        return results;
    }
    
    public MyLinkedList<MovieDBItem> items() {
        MyLinkedList<MovieDBItem> results = new MyLinkedList<MovieDBItem>();
		for (Genre list : genreList) {
			for (MovieDBItem item : list.titleList) {
				results.add(item);
			}
		}
    	return results;
    }
}

class Genre extends Node<String> implements Comparable<Genre> {
	public MyLinkedList<MovieDBItem> titleList;
	public String name;

	public Genre(String name) {
		super(name);
		this.name = name;
		titleList = new MyLinkedList<MovieDBItem>();
	}
	
	@Override
	public int compareTo(Genre o) {
		return getItem().compareTo(o.getItem());
	}

	@Override
	public int hashCode() {
		return getItem().hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		return getItem().equals(((Genre) obj).getItem());
	}
}