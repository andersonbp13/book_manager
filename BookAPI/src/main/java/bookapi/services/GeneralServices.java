package bookapi.services;

import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class GeneralServices {

    private Random random;

    public GeneralServices() {
        this.random = new Random();
    }

    //obtain a random number
    public int getRandomNumber(int limit ) {
        return random.nextInt(limit)+1;
    }

    public float getRandomNumber(float limit ) {
        return (random.nextFloat()*limit)+1;
    }

}
