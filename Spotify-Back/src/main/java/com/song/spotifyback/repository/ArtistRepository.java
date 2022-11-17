package com.song.spotifyback.repository;

import com.song.spotifyback.entity.Artist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArtistRepository  extends JpaRepository<Artist, Long> {

}
