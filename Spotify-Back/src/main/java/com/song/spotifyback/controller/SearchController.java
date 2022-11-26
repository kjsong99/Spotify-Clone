package com.song.spotifyback.controller;

import com.song.spotifyback.entity.Album;
import com.song.spotifyback.entity.Search;
import com.song.spotifyback.repository.SearchRepository;
import com.song.spotifyback.service.SearchService;
import com.song.spotifyback.service.impl.AlbumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/search")
public class SearchController {

    @Autowired
    private final SearchService searchService;

    @ResponseBody
    @RequestMapping()
    public ResponseEntity<List<Search>> searchByKeyword(@RequestParam ("keyword") String keyword){
//        searchService.initSequence();
        return ResponseEntity.ok(this.searchService.search(keyword));
    }

    @ResponseBody
    @RequestMapping("/artist")
    public ResponseEntity<List<Search>> searchArtistByKeyword(@RequestParam ("keyword") String keyword){
//        searchService.initSequence();
        return ResponseEntity.ok(this.searchService.searchArtist(keyword));
    }

    @ResponseBody
    @RequestMapping("/music")
    public ResponseEntity<List<Search>> searchMusicByKeyword(@RequestParam ("keyword") String keyword){
//        searchService.initSequence();
        return ResponseEntity.ok(this.searchService.searchMusic(keyword));
    }

    @ResponseBody
    @RequestMapping("/album")
    public ResponseEntity<List<Search>> searchAlbumByKeyword(@RequestParam ("keyword") String keyword){
//        searchService.initSequence();
        return ResponseEntity.ok(this.searchService.searchAlbum(keyword));
    }
}
