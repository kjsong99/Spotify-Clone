package com.song.spotifyback.repository;

import com.song.spotifyback.entity.Album;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AlbumRepository extends JpaRepository<Album, Long> {

    @Query("select m from Album m where m.artist.id = :artistId")
    List<Album> findByArtistId(final Long artistId);
}
