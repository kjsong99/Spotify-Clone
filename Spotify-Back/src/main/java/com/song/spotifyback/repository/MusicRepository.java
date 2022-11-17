package com.song.spotifyback.repository;

import com.song.spotifyback.entity.Music;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MusicRepository extends JpaRepository<Music, Long> {
}
