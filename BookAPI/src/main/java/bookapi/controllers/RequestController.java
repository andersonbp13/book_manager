package bookapi.controllers;

import bookapi.controllers.resources.BookDTO;
import bookapi.model.Book;
import com.google.common.base.Preconditions;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import bookapi.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RequestController {

    @Autowired //Le dice a Spring que llene esta variable con un bean que tenga almacenado
    private BookService bookService;

    @RequestMapping(value = "/books", method = RequestMethod.GET)
    public ResponseEntity getBooks() {
        return ResponseEntity.ok(bookService.findAllBooks());
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.GET)
    public ResponseEntity getBookById(@PathVariable("id") Long id) {
        Preconditions.checkArgument(id != null, "id is not valid.");
        return ResponseEntity.ok(bookService.findBookById(id));
    }

    @RequestMapping(value = "/books", method = RequestMethod.POST)
    public ResponseEntity saveBook(@RequestBody BookDTO bookDTO) {
        Preconditions.checkArgument(bookDTO != null, "body is not valid.");
        return ResponseEntity.ok(bookService.saveBook(bookDTO));
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.PUT)
    public ResponseEntity updateBook(@PathVariable("id") Long id, @RequestBody BookDTO bookDTO) {
        Preconditions.checkArgument(id != null && bookDTO !=null, "id or body is not valid.");
        return ResponseEntity.ok(bookService.updateBook(bookDTO, id));
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.DELETE)
    public ResponseEntity deleteBook(@PathVariable("id") Long id) {
        Preconditions.checkArgument(id != null, "id is not valid.");
        return ResponseEntity.ok(bookService.deleteBook(id));
    }
}
