package bookapi.services;

import bookapi.adapters.BookAdapter;
import com.google.common.base.Preconditions;
import bookapi.controllers.resources.BookDTO;
import bookapi.model.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import bookapi.repositories.BookRepository;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {

    public BookRepository bookRepository;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> findAllBooks() {  //no es necesario, se puede retornar una lista vacia
        List<Book> books = bookRepository.findAll();
        Preconditions.checkArgument(!books.isEmpty(), "There is not books at data base.");

        return books;
    }

    public Optional<Book> findBookById(Long id) {
        Optional<Book> book = bookRepository.findById(id);
        Preconditions.checkArgument(book.isPresent(), "The book does not exists at data base");

        return book;
    }

    public Book saveBook(BookDTO bookDTO) {
        Preconditions.checkArgument(bookDTO.getPrice() != -1, "Invalid price.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getName()), "Book name can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getAuthor()), "Author can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getImageURL()), "Invalid URL.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getGenre()), "Genre can not be empty.");

        Preconditions.checkArgument(!bookRepository.existsByName(bookDTO.getName()),"The book already exists.");

        Book newBook = BookAdapter.convertToDAO(bookDTO);
        bookRepository.save(newBook);

        Preconditions.checkArgument(bookRepository.existsById(newBook.getId()), "The book was not saved"); //no es necesario

        return newBook;
    }

    public Book updateBook (BookDTO bookDTO, Long id) {
        Preconditions.checkArgument(bookRepository.existsById(id),"The book does not exists at data base");

        Preconditions.checkArgument(bookDTO.getPrice() != -1, "Invalid price.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getName()), "Book name can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getAuthor()), "Author can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getImageURL()), "Invalid URL.");
        Preconditions.checkArgument(!StringUtils.isEmpty(bookDTO.getGenre()), "Genre can not be empty.");

        Book book = BookAdapter.convertToDAO(bookDTO);
        bookRepository.save(book);

        //no es necesario///////////////////////////////////// consume mucho recurso
        Book updatedBook = findBookById(id).get();

        Preconditions.checkArgument(updatedBook.getId().equals(book.getId()), "The book was not uploaded");
        Preconditions.checkArgument(updatedBook.getPrice().equals(book.getPrice()), "The book was not uploaded");
        Preconditions.checkArgument(updatedBook.getName().equals(book.getName()), "The book was not uploaded");
        Preconditions.checkArgument(updatedBook.getAuthor().equals(book.getAuthor()), "The book was not uploaded");
        Preconditions.checkArgument(updatedBook.getImageURL().equals(book.getImageURL()), "The book was not uploaded");
        Preconditions.checkArgument(updatedBook.getGenre().equals(book.getGenre()), "The book was not uploaded");

        //////////////////////////////////////////////////////

        return updatedBook;
    }

    public Boolean deleteBook(Long id) {
        Optional<Book> book = findBookById(id);

        bookRepository.delete(book.get());

        if(bookRepository.existsById(id)) {
            return false;
        }
        return true;
    }

}
