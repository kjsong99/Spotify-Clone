package com.song.spotifyback;

import com.song.spotifyback.entity.Artist;
import com.song.spotifyback.repository.ArtistRepository;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.stream.IntStream;
@RunWith(SpringRunner.class)
@SpringBootTest
public class ArtistRepositoryTests {
    @Autowired
    ArtistRepository artistRepository;

    @Test
    public void insertArtist(){
        IntStream.rangeClosed(1, 10).forEach(i -> {
            Artist artist = Artist.builder()
                    .name("test")
                    .imagePath("testPath")
                    .build();
            artistRepository.save(artist);

        });
    }
}
