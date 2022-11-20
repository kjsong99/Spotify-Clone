package com.song.spotifyback.repository;

import com.song.spotifyback.entity.Search;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SearchRepository extends JpaRepository<Search, Long> {

    @Query(nativeQuery = true, value =
            "select a.artist_name as name, a.artist_id as value_id, a.artist_image_path as image_path, 'artist' as category, (select get_seq('search')) as id from artist a where a.artist_name like %:keyword%" +
                    " UNION " +
                    "select m.music_name as name, m.music_id as value_id, m.music_image_path as image_path, 'music' as category, (select get_seq('search')) as id from music m where m.music_name like %:keyword%" +
                    " UNION " +
                    "select b.album_name as name, b.album_id as value_id, b.album_image_path as image_path, 'album' as category, (select get_seq('search')) as id  from album b where b.album_name like %:keyword%",
        countQuery = "select count(*) from " +
                "(select a.artist_name as name, a.artist_id as valueId, a.artist_image_path as image_path, 'artist' as category from artist a where a.artist_name like %:keyword% " +
                "UNION " +
                "select m.music_name as name, m.music_id as valueId, m.music_image_path as image_path, 'music' as category from music m where m.music_name like %:keyword% " +
                "UNION " +
                "select b.album_name as name, b.album_id as valueId, b.album_image_path as image_path, 'album' as category from album b where b.album_name like %:keyword%) as search"
    )
    List<Search> findAllBy(String keyword);

}
