package bookapi.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //indica que el valor se agregara automaticamente al ser agregado a la base de datos
    private Long id;
    private Float price;
    private String name;
    private String author;
    private String imageURL;
    private String genre;

    public Book() {}

    public Book(String name, String author, Float price, String imageURL, String genre) {
        setName(name);
        setAuthor(author);
        setPrice(price);
        setImageURL(imageURL);
        setGenre(genre);
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getAuthor() {
        return author;
    }

    public Float getPrice() {
        return price;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", price=" + price +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", image='" + imageURL + '\'' +
                ", genre='" + genre + '\'' +
                '}';
    }
}
