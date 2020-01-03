package bookapi;

import bookapi.controllers.resources.BookDTO;
import bookapi.model.Book;
import bookapi.repositories.BookRepository;
import io.restassured.RestAssured;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.hamcrest.Matchers.equalTo;

public class BookAPIFT extends BaseFT {

    @Autowired
    private BookRepository bookRepository;

    @Test
    public void getAllTest() {

        List<Book> book = bookRepository.findAll();

        List<?> response = RestAssured.given().urlEncodingEnabled(false)
                .get("/books")
                .then()
                .log()
                .ifValidationFails()
                .statusCode(200)
                .extract()
                .body()
                .as(List.class);

       Assert.assertEquals(book.size(), response.size());
    }

    @Test
    public void getTest() {

        Book book = bookRepository.findById(1L).get();

        RestAssured.given()
                .header("Content-Type", "application/json")
                .get("/books/1")
                .then()
                .log()
                .ifValidationFails()
                .statusCode(200)
                .body("name", equalTo(book.getName()))
                .body("id", equalTo(book.getId().intValue()))
                .body("price", equalTo(book.getPrice()))
                .body("genre", equalTo(book.getGenre()))
                .body("imageURL", equalTo(book.getImageURL()))
                .body("author", equalTo(book.getAuthor()));
    }

    @Test
    public void postTest() {

        BookDTO bookDTO = new BookDTO();
        bookDTO.setAuthor("authorPost");
        bookDTO.setName("bookPost");
        bookDTO.setPrice(1231F);
        bookDTO.setGenre("CDC");
        bookDTO.setImageURL("asdasdasd");

        Book response = RestAssured.given()
                .header("Content-Type", "application/json")
                .body(bookDTO)
                .post("/books")
                .then()
                .log()
                .ifValidationFails()
                .statusCode(200)
                .extract()
                .body()
                .as(Book.class);

        Book repositoryBook = bookRepository.findById(response.getId()).get();

        Assert.assertEquals(repositoryBook.getId(), response.getId());
        Assert.assertEquals(repositoryBook.getAuthor(), response.getAuthor());
        Assert.assertEquals(repositoryBook.getName(), response.getName());
        Assert.assertThat(repositoryBook.getPrice(), equalTo(response.getPrice()));
        Assert.assertThat(repositoryBook.getGenre(), equalTo(response.getGenre()));
        Assert.assertThat(repositoryBook.getImageURL(), equalTo(response.getImageURL()));
    }

    @Test
    public void putTest() {

        BookDTO bookDTO = new BookDTO();
        bookDTO.setId(2L);
        bookDTO.setAuthor("authorPut");
        bookDTO.setName("bookPut");
        bookDTO.setPrice(1231F);
        bookDTO.setGenre("CDC");
        bookDTO.setImageURL("asdasdasd");

        Book response = RestAssured.given()
                .header("Content-Type", "application/json")
                .body(bookDTO)
                .put("/books/2")
                .then()
                .log()
                .ifValidationFails()
                .statusCode(200)
                .extract()
                .body()
                .as(Book.class);

        Book repositoryBook = bookRepository.findById(response.getId()).get();

        Assert.assertEquals(repositoryBook.getId(), response.getId());
        Assert.assertEquals(repositoryBook.getAuthor(), response.getAuthor());
        Assert.assertEquals(repositoryBook.getName(), response.getName());
        Assert.assertThat(repositoryBook.getPrice(), equalTo(response.getPrice()));
        Assert.assertThat(repositoryBook.getGenre(), equalTo(response.getGenre()));
        Assert.assertThat(repositoryBook.getImageURL(), equalTo(response.getImageURL()));
    }

    @Test
    public void deleteTest() {

        Boolean response = RestAssured.given()
                .header("Content-Type", "application/json")
                .delete("/books/3")
                .then()
                .log()
                .ifValidationFails()
                .statusCode(200)
                .extract()
                .body()
                .as(Boolean.class);

        Assert.assertEquals(true, response); //es mejor mirar directamente desde el repositiorio
    }
}
