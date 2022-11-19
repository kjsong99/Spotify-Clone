package com.song.spotifyback.controller;

import com.song.spotifyback.entity.Album;
import com.song.spotifyback.service.impl.AlbumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/album")
public class AlbumController {
    @Autowired
    private final AlbumServiceImpl albumService;

    @ResponseBody
    @RequestMapping("/all")
    public ResponseEntity<List<Album>> getAllArtists(){
        return ResponseEntity.ok(this.albumService.getAllAlbums());
    }

    @RequestMapping("/all/artist/{artistId}")
    @ResponseBody
    public ResponseEntity<List<Album>> getAllAlbumsByArtist(@PathVariable Long artistId){
        return ResponseEntity.ok(this.albumService.getAllAlbumsByArtistId(artistId));
    }
    @RequestMapping()
    @ResponseBody
    public ResponseEntity<Album> getAlbumById(@RequestParam Long albumId) throws Exception{
        return ResponseEntity.ok(this.albumService.getAlbumById(albumId));

    }

}
