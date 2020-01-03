package bookapi.adapters;

import bookapi.model.Book;
import bookapi.controllers.resources.BookDTO;

public class BookAdapter {

    public static Book convertToDAO(BookDTO bookDTO) {
        Book book = new Book(bookDTO.getName(),
                bookDTO.getAuthor(),
                bookDTO.getPrice(),
                bookDTO.getImageURL(),
                bookDTO.getGenre());

        if(bookDTO.getId() != null) {   //no es necesario
            book.setId(bookDTO.getId());
        }

        return book;
    }

    public static BookDTO convertToDTO(Book book) {
        BookDTO bookDTO = new BookDTO();
        bookDTO.setId(book.getId());
        bookDTO.setName(book.getName());
        bookDTO.setAuthor(book.getAuthor());
        bookDTO.setPrice(book.getPrice());
        bookDTO.setImageURL(book.getImageURL());
        bookDTO.setGenre(book.getGenre());

        return bookDTO;
    }
}
