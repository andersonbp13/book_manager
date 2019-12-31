package bookapi.repositories;

import bookapi.model.Book;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface BookRepository extends CrudRepository <Book, Long> {

    List<Book> findAll();
    boolean existsByName(String name);
}
